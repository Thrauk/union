import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:union_app/src/screens/auth/sign_up/sign_up.dart';
import 'package:union_app/src/theme.dart';

class SignUpButtonWidget extends StatelessWidget {
  const SignUpButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState previous, SignUpState current) =>
          previous.status != current.status,
      builder: (BuildContext context, SignUpState state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator(
                color: AppColors.primaryColor,
              )
            : ElevatedButton(
                onPressed: () =>
                    context.read<SignUpCubit>().signUpFormSubmitted(),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                  onSurface: Colors.transparent,
                  shadowColor: Colors.transparent,
                  side: const BorderSide(
                    width: 2.0,
                    color: AppColors.primaryColor,
                  ),
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Color.fromRGBO(18, 18, 18, 1),
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              );
      },
    );
  }
}
