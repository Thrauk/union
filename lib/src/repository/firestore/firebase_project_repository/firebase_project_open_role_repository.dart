import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:union_app/src/models/models.dart';

class FirebaseProjectOpenRoleRepository {
  final CollectionReference<Map<String, dynamic>> _firestoreProjectsCollection =
      FirebaseFirestore.instance.collection('projects');

  final DocumentReference<Map<String, dynamic>> _firestoreProjectsOpenRolesDocument =
      FirebaseFirestore.instance.collection('projects_open_roles').doc();

  final CollectionReference<Map<String, dynamic>> _firestoreProjectsOpenRolesCollection =
      FirebaseFirestore.instance.collection('projects_open_roles');

  final CollectionReference<Map<String, dynamic>> _firestoreProjectsApplicationsCollection =
      FirebaseFirestore.instance.collection('projects_applications');

  final CollectionReference<Map<String, dynamic>> _firestoreUsersCollection = FirebaseFirestore.instance.collection('users');

  final CollectionReference<Map<String, dynamic>> _firestoreUserFilesCollection =
      FirebaseFirestore.instance.collection('user_files');

  void createProjectOpenRole(ProjectOpenRole projectOpenRole) {
    try {
      final ProjectOpenRole openRoleToSave = projectOpenRole.copyWith(id: _firestoreProjectsOpenRolesDocument.id);
      _firestoreProjectsOpenRolesDocument.set(openRoleToSave.toJson());
    } catch (e) {
      print('createProjectOpenRole $e');
    }
  }

  Future<List<ProjectOpenRole>> getOpenRolesByProjectId(String projectId) async {
    final QuerySnapshot<Map<String, dynamic>> query =
        await _firestoreProjectsOpenRolesCollection.where('project_id', isEqualTo: projectId).get();
    return _getOpenRolesFromQuery(query);
  }

  List<ProjectOpenRole> _getOpenRolesFromQuery(QuerySnapshot<Map<String, dynamic>> query) {
    return query.docs.toList().map((QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      final Map<String, dynamic> json = documentSnapshot.data();
      if (json != null) {
        return ProjectOpenRole.fromJson(json);
      } else {
        return ProjectOpenRole.empty;
      }
    }).toList();
  }

  Future<void> addUidToOpenRole(ProjectOpenRoleApplication roleApplication, String openRoleId,
      {FilePickerResult? filePickerResult, String? userCVPath}) async {
    try {
      final DocumentReference<Map<String, dynamic>> applicationDoc = _firestoreProjectsApplicationsCollection.doc();

      ProjectOpenRoleApplication applicationToSave = roleApplication.copyWith(openRoleId: openRoleId, id: applicationDoc.id);
      if (filePickerResult != null) {
        final String? fileUrl = await saveCVFileToApplication(filePickerResult, applicationDoc.id);
        if (fileUrl != null) applicationToSave = applicationToSave.copyWith(cvUrl: fileUrl);
        applicationDoc.set(applicationToSave.toJson());
        return;
      } else if (userCVPath != null && userCVPath.isNotEmpty) {
        copyCvFromUserToApplication(userCVPath, applicationDoc.id);
        applicationToSave = applicationToSave.copyWith(cvUrl: userCVPath);

        applicationDoc.set(applicationToSave.toJson());
      }
      applicationDoc.set(applicationToSave.toJson());
    } catch (e) {
      print('addUidToOpenRole $e');
    }
  }

  Future<void> deleteUidFromOpenRole(String openRoleId, ProjectOpenRoleApplication roleApplication) async {
    try {
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> maybeApplicationQuery =
          (await _firestoreProjectsApplicationsCollection
                  .where('open_role_id', isEqualTo: openRoleId)
                  .where('uid', isEqualTo: roleApplication.uid)
                  .get())
              .docs;

      if (maybeApplicationQuery.isNotEmpty) {
        for (final QueryDocumentSnapshot<Map<String, dynamic>> element in maybeApplicationQuery) {
          _firestoreProjectsApplicationsCollection.doc(element.id).delete();
          if (roleApplication.cvUrl.isNotEmpty) deleteCVFileFromApplication(element.id);
        }
      }
    } catch (e) {
      print('deleteUidFromOpenRole $e');
    }
  }

  Future<List<ProjectOpenRoleApplication>> _getProjectApplications(String openRoleId) async {
    try {
      final Query<Map<String, dynamic>> reference =
          _firestoreProjectsApplicationsCollection.where('open_role_id', isEqualTo: openRoleId);

      final List<QueryDocumentSnapshot<Map<String, dynamic>>> applicationsListQuery = (await reference.get()).docs.toList();

      return applicationsListQuery.map((QueryDocumentSnapshot<Map<String, dynamic>> e) {
        final Map<String, dynamic> json = e.data();
        if (json != null) {
          return ProjectOpenRoleApplication.fromJson(json);
        } else {
          return const ProjectOpenRoleApplication();
        }
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProjectOpenRoleApplicationItem>> getProjectApplicationItems(String openRoleId) async {
    try {
      final List<ProjectOpenRoleApplicationItem> applicationsListItems = <ProjectOpenRoleApplicationItem>[];

      final List<ProjectOpenRoleApplication> applicationsList = await _getProjectApplications(openRoleId);

      for (final ProjectOpenRoleApplication application in applicationsList) {
        final Map<String, dynamic>? userJson = (await _firestoreUsersCollection.doc(application.uid).get()).data();
        if (userJson != null) {
          final FullUser user = FullUser.fromJson(userJson);
          applicationsListItems
              .add(ProjectOpenRoleApplicationItem(application.notice, user, application.id, cvUrl: application.cvUrl));
        }
      }
      return applicationsListItems;
    } catch (e) {
      print(' getProjectApplicationItems $e');
    }
    return [];
  }

  Future<bool?> isUidAlreadyAdded(String uid, String openRoleId) async {
    try {
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> maybeApplicationQuery =
          (await _firestoreProjectsApplicationsCollection
                  .where('uid', isEqualTo: uid)
                  .where('open_role_id', isEqualTo: openRoleId)
                  .get())
              .docs;

      if (maybeApplicationQuery.isEmpty)
        return false;
      else
        return true;
    } catch (e) {
      print('isUidAlreadyAdded $e');
    }
  }

  Future<String?> saveCVFileToApplication(FilePickerResult file, String applicationId) async {
    try {
      late String filePath;
      final Uint8List? fileBytes = file.files.first.bytes;
      final Reference reference = FirebaseStorage.instance.ref('applications_cv/$applicationId/cv');
      if (fileBytes != null) {
        final UploadTask uploadTask = reference.putData(fileBytes);
        return await uploadTask.then((TaskSnapshot task) async {
          filePath = await task.ref.getDownloadURL();
          return filePath;
        });
      }
    } catch (e) {
      print('saveCVFileToApplication $e');
      throw e;
    }
  }

  Future<String?> getUserCvIfPresent(String ownerId) async {
    try {
      final Map<String, dynamic>? maybeUserCv = (await _firestoreUserFilesCollection.doc(ownerId).get()).data();
      if (maybeUserCv != null) {
        if (maybeUserCv['cv'] != null) return maybeUserCv['cv'] as String;
      }
    } catch (e) {
      print('getUserCvIfPresent $e');
    }
  }

  Future<void> deleteCVFileFromApplication(String applicationId) async {
    try {
      await FirebaseStorage.instance.ref('applications_cv/$applicationId/cv').delete();
      await _firestoreUserFilesCollection.doc(applicationId).delete();
    } catch (e) {
      print('deleteCVFileFromApplication $e');
    }
  }

  Future<String?> copyCvFromUserToApplication(String userCvUrl, String applicationId) async {
    final Uint8List? userCV = await FirebaseStorage.instance.refFromURL(userCvUrl).getData();
    try {
      late String filePath;
      final Reference reference = FirebaseStorage.instance.ref('applications_cv/$applicationId/cv');
      if (userCV != null) {
        final UploadTask uploadTask = reference.putData(userCV);
        return await uploadTask.then((TaskSnapshot task) async {
          filePath = await task.ref.getDownloadURL();
          return filePath;
        });
      }
    } catch (e) {
      print('copyCvFromUserToApplication $e');
    }
  }

  Future<void> deleteOpenRole(ProjectOpenRole openRole) async {
    _firestoreProjectsOpenRolesCollection.doc(openRole.id).delete();
    final QuerySnapshot<Map<String, dynamic>> applicationsSnapshot =
        await (_firestoreProjectsApplicationsCollection.where('open_role_id', isEqualTo: openRole.id)).get();
    applicationsSnapshot.docs.clear();
  }

  void acceptApplication(ProjectOpenRole openRole, ProjectOpenRoleApplicationItem application) {
    try {
      _firestoreProjectsCollection.doc(openRole.projectId).update({
        'members_uid': FieldValue.arrayUnion([application.user.id])
      });
      _deleteApplication(application);
    } catch (e) {
      print("acceptApplication $e");
    }
  }

  void _deleteApplication(ProjectOpenRoleApplicationItem application) {
    _firestoreProjectsApplicationsCollection.doc(application.id).delete();
  }
}
