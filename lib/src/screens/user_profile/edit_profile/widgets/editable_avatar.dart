import 'dart:io';

import 'package:flutter/material.dart';

const double _avatarSize = 48.0;

class EditableAvatarWidget extends StatelessWidget {
  const EditableAvatarWidget({Key? key, this.photoUrl, this.imageFile}) : super(key: key);

  final String? photoUrl;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    final String? photo = photoUrl;
    ImageProvider? avatar;
    if(imageFile != null) {
      avatar = FileImage(imageFile!);
    } else if(photo != null) {
      avatar = NetworkImage(photo);
    }
    return CircleAvatar(
      radius: _avatarSize,
      backgroundColor: Theme.of(context).primaryColor,
      backgroundImage: avatar,
      child: photo == null ? const Icon(Icons.person, size: _avatarSize) : null,
    );
  }
}
