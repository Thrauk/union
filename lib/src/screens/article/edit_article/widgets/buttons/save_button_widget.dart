import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:union_app/src/screens/article/edit_article/bloc/edit_article_bloc.dart';
import 'package:union_app/src/screens/main/view/main_screen.dart';
import 'package:union_app/src/theme.dart';

class SaveButtonWidget extends StatelessWidget {
  const SaveButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditArticleBloc, EditArticleState>(
      listener: (BuildContext context, EditArticleState state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).push(MainPage.route());
        }
      },
      builder: (BuildContext context, EditArticleState state) {
        return ElevatedButton(
          onPressed: () {
            context.read<EditArticleBloc>().add(SaveButtonPressed());
          },
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
            'Save',
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
