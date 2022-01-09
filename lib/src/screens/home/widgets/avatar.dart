import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class Avatar extends StatelessWidget {
  const Avatar({Key? key, this.photo, this.avatarSize = 48.0}) : super(key: key);

  final String? photo;
  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    final String? photo = this.photo == '' ? null : this.photo;
    return CircleAvatar(
      radius: avatarSize,
      backgroundColor: Theme.of(context).primaryColor,
      backgroundImage: photo != null ? CachedNetworkImageProvider(photo) : null,
      child: photo == null ? Icon(Icons.person, size: avatarSize) : null,
    );
  }
}
