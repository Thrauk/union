import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:provider/src/provider.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/open_roles/add_open_role/bloc/add_open_role_bloc.dart';
import 'package:union_app/src/theme.dart';

class PostButtonWidget extends StatelessWidget {
  const PostButtonWidget({Key? key, required this.projectId}) : super(key: key);

  final String projectId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddOpenRoleBloc, AddOpenRoleState>(
      listener: (BuildContext context, AddOpenRoleState state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).push(HomePage.route());
        }
      },
      builder: (BuildContext context, AddOpenRoleState state) {
        return ElevatedButton(
          onPressed: () {
            context.read<AddOpenRoleBloc>().add(PostButtonPressed(projectId, context.read<AppBloc>().state.user.id));
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
            'Post',
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
