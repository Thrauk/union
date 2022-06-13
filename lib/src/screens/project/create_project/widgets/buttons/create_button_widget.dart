import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:provider/src/provider.dart';
import 'package:union_app/src/models/authentication/app_user.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/main/view/main_screen.dart';
import 'package:union_app/src/screens/project/create_project/bloc/bloc.dart';
import 'package:union_app/src/theme.dart';

class CreateButtonWidget extends StatelessWidget {
  const CreateButtonWidget({Key? key, this.organizationId = ''}) : super(key: key);

  final String organizationId;

  @override
  Widget build(BuildContext context) {
    final AppUser user = context.read<AppBloc>().state.user;
    return BlocConsumer<CreateProjectBloc, CreateProjectState>(
      listener: (BuildContext context, CreateProjectState state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).push(MainPage.route());
        }
      },
      builder: (BuildContext context, CreateProjectState state) {
        return ElevatedButton(
          onPressed: () {
            if(organizationId != '') {
              context.read<CreateProjectBloc>().add(CreateButtonPressedOrganization(user.id, user.displayName ?? '', organizationId));
            } else {
              context.read<CreateProjectBloc>().add(CreateButtonPressed(user.id, user.displayName ?? ''));
            }
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
            'Create',
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
