import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:union_app/src/repository/authentication/auth.dart';
import 'package:union_app/src/screens/auth/login/view/login_page.dart';
import 'package:union_app/src/screens/auth/sign_up/sign_up.dart';
import 'package:union_app/src/screens/auth/sign_up/widgets/form_fields/name_input_widget.dart';
import 'package:union_app/src/screens/auth/widgets/auth_option/auth_options.dart';
import 'package:union_app/src/screens/auth/widgets/design/design.dart';
import 'package:union_app/src/screens/main/view/main_screen.dart';
import 'package:union_app/src/theme.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  static Page<void> page() => const MaterialPage<void>(child: SignUpPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider<SignUpCubit>(
        create: (_) => SignUpCubit(context.read<AuthenticationRepository>()),
        child: BlocListener<SignUpCubit, SignUpState>(
            listener: (BuildContext context, SignUpState state) {
              if (state.status.isSubmissionFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content:
                          Text(state.errorMessage ?? 'Authentication Failure'),
                    ),
                  );
              } else if (state.status.isSubmissionSuccess) {
                //Navigator.of(context).popUntil((Route<void> route) => false);
                // THIS SHOULD BE CHANGED IN THE FUTURE!!!!
                Navigator.of(context).push(MainPage.route());
              }
            },
            child: const _SignUpPage()),
      ),
    );
  }
}

class _SignUpPage extends StatelessWidget {
  const _SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 62.0, 8.0, 8.0),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomCenter,
              child: const Text(
                'Union',
                style: TextStyle(
                  fontFamily: 'LatoBlack',
                  fontWeight: FontWeight.w900,
                  fontSize: 26,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                          fontFamily: 'LatoBold',
                          fontSize: 36,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const Text(
                          ' Already have an account?',
                          style: TextStyle(
                            fontFamily: 'LatoBold',
                            fontSize: 16,
                            color: Color.fromRGBO(255, 255, 255, 0.7),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .push<void>(LoginPage.route()),
                          child: const Text(
                            ' Login',
                            style: TextStyle(
                              fontFamily: 'LatoBold',
                              fontSize: 16,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const EmailInputWidget(),
                const SizedBox(height: 12),
                const NameInputWidget(),
                const SizedBox(height: 12),
                const PasswordInputWidget(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: SignUpButtonWidget(),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'By clicking register you agree with our',
                    style: TextStyle(
                        fontFamily: 'Lato',
                        color: Colors.white70,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Terms and Conditions',
                  style: TextStyle(
                      fontFamily: 'Lato',
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: const <Widget>[
                DividerWidget(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: SocialAuthWidget(type: SocialAuthType.SignUp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
