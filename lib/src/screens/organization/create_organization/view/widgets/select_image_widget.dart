import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/theme.dart';


class SelectImageWidget extends StatelessWidget {
  const SelectImageWidget({Key? key, this.image}) : super(key: key);

  final File? image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          if (image == null)
            Container(
              color: AppColors.backgroundLight1,
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
