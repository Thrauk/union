import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_open_role_repository.dart';
import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_repository.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/open_roles/open_role_details/bloc/open_role_details_bloc.dart';
import 'package:union_app/src/screens/open_roles/open_role_details/widgets/buttons/apply_button_widget.dart';
import 'package:union_app/src/screens/open_roles/open_role_details/widgets/buttons/view_applicants_button_widget.dart';
import 'package:union_app/src/screens/widgets/app_bar/simple_app_bar.dart';
import 'package:union_app/src/theme.dart';
import 'package:union_app/src/util/date_format_utils.dart';

class OpenRolesDetailsPage extends StatelessWidget {
  const OpenRolesDetailsPage({Key? key, required this.projectOpenRole})
      : super(key: key);

  static Route<void> route(ProjectOpenRole projectOpenRole) {
    return MaterialPageRoute<void>(
        builder: (_) => OpenRolesDetailsPage(projectOpenRole: projectOpenRole));
  }

  final ProjectOpenRole projectOpenRole;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OpenRoleDetailsBloc>(
      create: (_) => OpenRoleDetailsBloc(
          FirebaseProjectRepository(), FirebaseProjectOpenRoleRepository())
        ..add(GetProjectDetails(projectOpenRole.projectId))
        ..add(VerifyIfUserAlreadyApplied(
            context.read<AppBloc>().state.user.id, projectOpenRole.id)),
      child: _OpenRolesDetailsPage(projectOpenRole: projectOpenRole),
    );
  }
}

class _OpenRolesDetailsPage extends StatelessWidget {
  const _OpenRolesDetailsPage({Key? key, required this.projectOpenRole})
      : super(key: key);

  final ProjectOpenRole projectOpenRole;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpenRoleDetailsBloc, OpenRoleDetailsState>(
      buildWhen: (OpenRoleDetailsState previous, OpenRoleDetailsState current) {
        return previous.project != current.project;
      },
      builder: (BuildContext context, OpenRoleDetailsState state) {
        return Scaffold(
          appBar: SimpleAppBar(title: projectOpenRole.title),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // const SizedBox(height: 8),
                // if(state.project.ownerId.isNotEmpty) ProjectItemWidget(project: state.project) else const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(projectOpenRole.title, style: AppStyles.textStyleHeading2),
                const SizedBox(height: 6),
                Text(
                  'posted on ${DateFormatUtils.timestampToDate(projectOpenRole.timestamp)}',
                  style: AppStyles.textStyleBody,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Icon(Icons.analytics, color: AppColors.white07),
                    const SizedBox(width: 6),
                    Text('${state.project.title}',
                        style: AppStyles.textStyleBodyBig),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.location_on,
                      color: AppColors.white07,
                    ),
                    const SizedBox(width: 6),
                    Text(projectOpenRole.location.split(' ').join(', '),
                        style: AppStyles.textStyleBody),
                    if (projectOpenRole.isRemotePossible == true)
                      const Text(
                        ' • ',
                        style: AppStyles.textStyleBodySmall,
                      ),
                    if (projectOpenRole.isRemotePossible == true)
                      const Text(
                        'Remote',
                        style: AppStyles.textStyleBody,
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                if (projectOpenRole.isPaid)
                  Row(
                    children: const <Widget>[
                      Icon(
                        Icons.payments,
                        color: AppColors.white07,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Paid',
                        style: AppStyles.textStyleBody,
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                const Text('Specifications',
                    style: AppStyles.textStyleHeading1),
                const SizedBox(height: 8),
                Text(projectOpenRole.specifications,
                    style: AppStyles.textStyleBody),
                const Spacer(),
                // TODO remove after test
                ViewApplicantsButtonWidget(openRole: projectOpenRole),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: state.project.ownerId ==
                          context.read<AppBloc>().state.user.id
                      ? ApplyButtonWidget(openRoleId: projectOpenRole.id)
                      : ViewApplicantsButtonWidget(openRole: projectOpenRole),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
