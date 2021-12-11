import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/theme.dart';

import '../profile.dart';

class TestingProfileWidget extends StatelessWidget {
  const TestingProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ProfilePage(uid: '31q36ScZ6BULZdYDb8ejbVyqHD22'),
              ),
            );
          },
          child: Text('Theos profile',
            style: AppStyles.textStyleBody,),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ProfilePage(uid: 'cUHdpcftS7U9qZ6DwqF7uHvuLcE3'),
              ),
            );
          },
          child: Text('Amalias profile',
            style: AppStyles.textStyleBody,),

        ),
      ],
    );
  }

}