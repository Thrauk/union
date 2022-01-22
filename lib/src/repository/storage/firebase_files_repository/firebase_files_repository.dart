import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFilesRepository {
  final CollectionReference<Map<String, dynamic>> firestoreArticleCollection =
  FirebaseFirestore.instance.collection('files');
}
