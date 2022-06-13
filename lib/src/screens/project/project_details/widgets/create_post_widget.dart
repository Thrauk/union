import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/theme.dart';

class CreatePostWidget extends StatelessWidget {
  const CreatePostWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        color: AppColors.backgroundLight,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
        child: Row(
          children: const <Widget>[
            Icon(
              Icons.edit,
              color: AppColors.white08,
            ),
            SizedBox(width: 6),
            Expanded(
              child: Text(
                'Write something...',
                style: AppStyles.textStyleBody,
              ),
            ),
            // Text('Search something...', style: AppStyles.textStyleBody)
          ],
        ),
      ),
    );
  }
}
