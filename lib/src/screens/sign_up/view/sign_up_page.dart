import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/repository/authentication/auth.dart';
import 'package:union_app/src/screens/sign_up/cubit/sign_up_cubit.dart';
import 'package:union_app/src/screens/sign_up/widgets/buttons/buttons.dart';
import 'package:union_app/src/screens/sign_up/widgets/form_fields/form_fields.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SignUpCubit>(
        create: (_) => SignUpCubit(context.read<AuthenticationRepository>()),
        child: const _SignUpPage(),
      ),
    );
  }
}

class _SignUpPage extends StatelessWidget {
  const _SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Flexible(
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: const Text(
                  'Union',
                  style: TextStyle(
                    fontFamily: 'LatoBlack',
                    fontWeight: FontWeight.w900,
                    fontSize: 26,
                    color: Color.fromRGBO(169, 223, 216, 1),
                  ),
                ),
              ),
            ),
            Flexible(flex: 1,child: Container()),
            Flexible(
              flex: 14,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                          fontFamily: 'LatoBold',
                          fontSize: 36,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: const <Widget>[
                      Text(
                        ' Already have an account?',
                        style: TextStyle(
                          fontFamily: 'LatoBold',
                          fontSize: 16,
                          color: Color.fromRGBO(255, 255, 255, 0.7),
                        ),
                      ),
                      Text(
                        ' Login',
                        style: TextStyle(
                          fontFamily: 'LatoBold',
                          fontSize: 16,
                          color: Color.fromRGBO(169, 223, 216, 1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const EmailInputWidget(),
                  const PasswordInputWidget(),
                  const ConfirmPasswordInputWidget(),
                  const Flexible(
                      child: SignUpButtonWidget()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
