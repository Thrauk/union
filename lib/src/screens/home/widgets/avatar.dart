import 'package:flutter/material.dart';

const double _avatarSize = 48.0;

class Avatar extends StatelessWidget {
  const Avatar({Key? key, this.photo}) : super(key: key);

  final String? photo;

  @override
  Widget build(BuildContext context) {
    final String? photo = this.photo;
    return CircleAvatar(
      radius: _avatarSize,
      backgroundColor: Theme.of(context).primaryColor,
      backgroundImage: photo != null ? NetworkImage(photo) : null,
      child: photo == null ? const Icon(Icons.person, size: _avatarSize) : null,
    );
  }
}
