import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:provider/src/provider.dart';
import 'package:union_app/src/models/authentication/app_user.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/article/create_article/bloc/bloc.dart';
import 'package:union_app/src/screens/profile/profile.dart';
import 'package:union_app/src/theme.dart';

class PublishButtonWidget extends StatelessWidget {
  const PublishButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppUser user = context.read<AppBloc>().state.user;
    return BlocConsumer<CreateArticleBloc, CreateArticleState>(
      listener: (BuildContext context, CreateArticleState state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).push(ProfilePage.route());
        }
      },
      builder: (BuildContext context, CreateArticleState state) {
        return ElevatedButton(
          onPressed: () {
            context
                .read<CreateArticleBloc>()
                .add(PublishButtonPressed(user.id));
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
            'Publish',
            style: AppStyles.buttonTextStyle,
          ),
        );
      },
    );
  }
}
