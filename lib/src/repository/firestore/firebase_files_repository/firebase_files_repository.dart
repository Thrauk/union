import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseFilesRepository {
  final FirebaseStorage _firebaseInstance = FirebaseStorage.instance;
  final CollectionReference<Map<String, dynamic>> _firestoreUserFilesCollection =
      FirebaseFirestore.instance.collection('user_files');

  Future<void> saveCVFileToUser(FilePickerResult file, String ownerId) async {
    try {
      late String filePath;
      final Uint8List? fileBytes = file.files.first.bytes;
      final Reference reference = _firebaseInstance.ref('users/$ownerId/files/cv/');
      if (fileBytes != null) {
        final UploadTask uploadTask = reference.putData(fileBytes);
        await uploadTask.then((TaskSnapshot task) async => {filePath = await task.ref.getDownloadURL()});
        _firestoreUserFilesCollection.doc(ownerId).set({'cv': filePath});
      }
    } catch (e) {
      print('saveCVFileToUser $e');
    }
  }

  Future<void> deleteCVFileFromUser(String ownerId) async {
    try {
      await _firebaseInstance.ref('users/$ownerId/files/cv').delete();
      // to be refactored
      await _firestoreUserFilesCollection.doc(ownerId).delete();
    } catch (e) {
      print('deleteFile $e');
    }
  }

  Future<void> getFile(String ownerId) async {
    final Future<ListResult> file = _firebaseInstance.ref('users/${ownerId}/files/cv').list(const ListOptions(maxResults: 1));
    print("fisier $file");
  }

  Future<bool> isCVFileAlreadyAddedAtUser(String ownerId) async {
    try {
      final String fileUrl = await _firebaseInstance.ref('users/$ownerId/files/cv').getDownloadURL();
      if (fileUrl != null) return true;
    } catch (e) {
      print('isFileAlreadyAdded $e');
    }
    return false;
  }
}
