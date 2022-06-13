import 'dart:io';

import 'package:flutter/material.dart';
import 'package:union_app/src/theme.dart';

class ImageSelect extends StatelessWidget {
  const ImageSelect({
    Key? key,
    this.image,
    this.placeholderImageUrl,
    this.containerHeight = 150,
    this.containerWidth = double.infinity,
  }) : super(key: key);

  final File? image;
  final String? placeholderImageUrl;
  final double containerHeight;
  final double containerWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: containerHeight,
      width: containerWidth,
      child: Stack(
        children: <Widget>[
          if (image == null)
            (placeholderImageUrl == null || placeholderImageUrl == '')
                ? Container(
                    color: AppColors.backgroundLight1,
                  )
                : SizedBox(
                    width: double.infinity,
                    child: Image.network(
                      placeholderImageUrl!,
                      fit: BoxFit.fitWidth,
                    ),
                  )
          else
            SizedBox(
              width: double.infinity,
              child: Image.file(
                image!,
                fit: BoxFit.fitWidth,
              ),
            ),
          Container(
            color: const Color.fromRGBO(0, 0, 0, 0.4),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.image,
                  color: AppColors.primaryColor,
                ),
                Text(
                  'Tap to change image',
                  style: AppStyles.textStyleBodyPrimary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
