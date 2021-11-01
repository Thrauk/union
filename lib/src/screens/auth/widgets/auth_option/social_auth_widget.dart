import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/auth/login/cubit/login_cubit.dart';

enum SocialAuthType { SignUp, Login }

class SocialAuthWidget extends StatelessWidget {
  const SocialAuthWidget({Key? key, required this.type}) : super(key: key);

  final SocialAuthType type;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (type == SocialAuthType.Login) {
              context.read<LoginCubit>().logInWithGoogle();
            } else if (type == SocialAuthType.SignUp) {
              // TODO(SignUp): SignUp with Google.
            }
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
