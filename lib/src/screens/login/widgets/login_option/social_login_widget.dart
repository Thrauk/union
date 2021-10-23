import 'package:flutter/material.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Image(
          image: AssetImage('assets/icons/google_icon.png'),
        ),
        SizedBox(
          width: 20,
        ),
        Image(
          image: AssetImage('assets/icons/facebook_icon.png'),
        ),
      ],
    );
  }
}
