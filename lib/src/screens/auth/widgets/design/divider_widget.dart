import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        Expanded(
          child: Divider(
            color: Color.fromRGBO(255, 255, 255, 0.7),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'or',
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.7),
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Color.fromRGBO(255, 255, 255, 0.7),
          ),
        ),
      ],
    );
  }
}
