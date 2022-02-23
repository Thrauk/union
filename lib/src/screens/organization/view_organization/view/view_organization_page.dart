import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/organization/view_organization/bloc/view_organization_bloc.dart';
import 'package:union_app/src/screens/widgets/app_bar/simple_app_bar.dart';
import 'package:union_app/src/screens/widgets/app_bottom_nav_bar/app_bottom_nav_bar.dart';
import 'package:union_app/src/theme.dart';

import 'components/view_organization_details.dart';


class ViewOrganizationPage extends StatelessWidget {
  const ViewOrganizationPage({Key? key, required this.organizationId}) : super(key: key);

  static Route<void> route(String organizationId) {
    return MaterialPageRoute<void>(
      builder: (_) =>
          ViewOrganizationPage(
            organizationId: organizationId,
          ),
    );
  }

  final String organizationId;

  @override
  Widget build(BuildContext context) {
    final String uid = context.select((AppBloc bloc) => bloc.state.user.id);
    return Scaffold(
      bottomNavigationBar: const CustomNavBar(),
      appBar: const SimpleAppBar(title: 'Organization'),
      body: BlocProvider<ViewOrganizationBloc>(
        create: (_) =>
        ViewOrganizationBloc(
          uid: uid,
          organizationId: organizationId,
        )
          ..add(LoadData()),
        child: BlocListener<ViewOrganizationBloc, ViewOrganizationState>(
          listener: (BuildContext context, ViewOrganizationState state) {
            if(state.isDeleted) {
              Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<ViewOrganizationBloc, ViewOrganizationState>(
            builder: (BuildContext context, ViewOrganizationState state) {
              if (!state.isLoaded) {
                return const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              } else {
                return ViewOrganizationDetails(
                  organization: state.organization,
                  isOwned: state.isOwned,
                  isMember: state.isMember,
                  isPublic: state.organization.type == 'Public',
                  projects: state.projects,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
