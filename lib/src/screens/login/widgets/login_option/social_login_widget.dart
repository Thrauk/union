import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../login.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            context.read<LoginCubit>().logInWithGoogle();
          },
          child: const Image(
            image: AssetImage('assets/icons/google_icon.png'),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        const Image(
          image: AssetImage('assets/icons/facebook_icon.png'),
        ),
      ],
    );
  }
}
