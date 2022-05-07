import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/theme.dart';

class OrganizationHeaderImage extends StatelessWidget {
  const OrganizationHeaderImage({
    Key? key,
    this.photoUrl = '',
  }) : super(key: key);

  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    if (photoUrl != '')
      return SizedBox(
        height: 120,
        width: double.infinity,
        child: CachedNetworkImage(
          imageUrl: photoUrl,
          fit: BoxFit.fitWidth,
        ),
      );
    else
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            color: AppColors.primaryColor,
          ),
          const Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.group,
              color: AppColors.black09,
              size: 35,
            ),
          ),
        ],
      );
  }
}
