import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:union_app/src/repository/authentication/auth.dart';

import '../login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider<LoginCubit>(
        create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
        child: BlocListener<LoginCubit, LoginState>(
            listener: (BuildContext context, LoginState state) {
              if (state.status.isSubmissionFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content:
                          Text(state.errorMessage ?? 'Authentication Failure'),
                    ),
                  );
              }
            },
            child: const _LoginPage()),
      ),
    );
  }
}

class _LoginPage extends StatelessWidget {
  const _LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Column(
              children: <Widget>[
                Expanded(
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
                Flexible(flex: 1, child: Container()),
                Expanded(
                  flex: 14,
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  'Welcome back',
                                  style: TextStyle(
                                    fontFamily: 'LatoBold',
                                    fontSize: 36,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Row(
                                children: const <Widget>[
                                  Text(
                                    " Don't have an account?",
                                    style: TextStyle(
                                      fontFamily: 'LatoBold',
                                      fontSize: 16,
                                      color: Color.fromRGBO(255, 255, 255, 0.7),
                                    ),
                                  ),
                                  Text(
                                    ' Sign Up',
                                    style: TextStyle(
                                      fontFamily: 'LatoBold',
                                      fontSize: 16,
                                      color: Color.fromRGBO(169, 223, 216, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Expanded(
                          child: EmailInputWidget(),
                        ),
                        const Expanded(
                          child: PasswordInputWidget(),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: LoginButtonWidget(),
                          ),
                        ),
                        const Flexible(
                            flex: 1,
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.7),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: const <Widget>[
                DividerWidget(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: SocialLoginWidget(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
