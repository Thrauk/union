import 'dart:typed_data';

class File {
  File({this.name = '', this.fileBytes, this.ownerId = ''});

  final String name;
  final Uint8List? fileBytes;
  final String ownerId;
}
