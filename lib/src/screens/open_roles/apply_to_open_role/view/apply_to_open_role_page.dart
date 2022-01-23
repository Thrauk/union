import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_open_role_repository.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/open_roles/apply_to_open_role/bloc/apply_to_open_role_bloc.dart';
import 'package:union_app/src/screens/widgets/app_bar/simple_app_bar.dart';
import 'package:union_app/src/theme.dart';

class ApplyToOpenRolePage extends StatelessWidget {
  const ApplyToOpenRolePage({Key? key, required ProjectOpenRole projectOpenRole})
      : _projectOpenRole = projectOpenRole,
        super(key: key);

  static Route<void> route(ProjectOpenRole projectOpenRole) {
    return MaterialPageRoute<void>(
      builder: (_) => ApplyToOpenRolePage(
        projectOpenRole: projectOpenRole,
      ),
    );
  }

  final ProjectOpenRole _projectOpenRole;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApplyToOpenRoleBloc>(
      create: (_) => ApplyToOpenRoleBloc(FirebaseProjectOpenRoleRepository())
        ..add(VerifyIfUserHasCv(context.read<AppBloc>().state.user.id)),
      child: _ApplyToOpenRolePage(projectOpenRole: _projectOpenRole),
    );
  }
}

class _ApplyToOpenRolePage extends StatelessWidget {
  const _ApplyToOpenRolePage({Key? key, required ProjectOpenRole projectOpenRole})
      : _projectOpenRole = projectOpenRole,
        super(key: key);

  final ProjectOpenRole _projectOpenRole;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplyToOpenRoleBloc, ApplyToOpenRoleState>(
      buildWhen: (ApplyToOpenRoleState previous, ApplyToOpenRoleState current) {
        return previous.cvAlreadyAdded != current.cvAlreadyAdded || previous.filePickerResult != current.filePickerResult;
      },
      builder: (BuildContext context, ApplyToOpenRoleState state) {
        return Scaffold(
          appBar: const SimpleAppBar(
            title: 'Apply',
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    minLines: 1,
                    maxLines: 10,
                    onChanged: (String value) {
                      context.read<ApplyToOpenRoleBloc>().add(NoticeChanged(value));
                    },
                    style: const TextStyle(
                      color: AppColors.white07,
                    ),
                    cursorColor: AppColors.primaryColor,
                    decoration: const InputDecoration(
                      label: Text('Why do you want to apply?'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    state.cvAlreadyAdded == true
                        ? 'You already have CV uploaded. You can choose another one or apply with the existing one.'
                        : 'Choose a file for your CV',
                    style: AppStyles.textStyleBody,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      if (state.filePickerResult != null)
                        Expanded(
                          flex: 1,
                          child: Text(
                            state.filePickerResult!.files.first.name,
                            style: AppStyles.textStyleBody,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      else
                        const Text(
                          'No file chosen',
                          style: AppStyles.textStyleBody,
                        ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: AppColors.primaryColor),
                          onPressed: () {
                            context.read<ApplyToOpenRoleBloc>().add(ChooseFilePressed());
                          },
                          child: const Text(
                            'Choose a file',
                            style: AppStyles.buttonTextStyle,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: () {
                        context.read<ApplyToOpenRoleBloc>().add(
                              ApplyButtonPressed(
                                context.read<AppBloc>().state.user.id,
                                _projectOpenRole.id,
                              ),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.primaryColor,
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: const Text(
                        'Apply',
                        style: AppStyles.buttonTextStyle,
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
