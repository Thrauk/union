import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseFilesRepository {
  final FirebaseStorage _firebaseInstance = FirebaseStorage.instance;
  Future<void> saveFile(FilePickerResult file, String ownerId) async {
    try {
      final Uint8List? fileBytes = file.files.first.bytes;
      print('bytes $fileBytes');
      if (fileBytes != null)
        await _firebaseInstance.ref('users/$ownerId/files/cv/${file.files.first.name}').putData(fileBytes);
    } catch (e) {
      print('saveFile $e');
    }
  }
}
