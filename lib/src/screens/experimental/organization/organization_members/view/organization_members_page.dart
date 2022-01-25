import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/experimental/organization/organization_members/bloc/organization_members_bloc.dart';
import 'package:union_app/src/screens/experimental/organization/organization_members/view/widgets/organization_members_list_view.dart';
import 'package:union_app/src/screens/widgets/app_bar/simple_app_bar.dart';
import 'package:union_app/src/screens/widgets/app_bottom_nav_bar/app_bottom_nav_bar.dart';

import '../../../../../theme.dart';

class OrganizationMembersPage extends StatelessWidget {
  const OrganizationMembersPage({Key? key, required this.organizationId}) : super(key: key);

  static Route<void> route(String organizationId) {
    return MaterialPageRoute<void>(
      builder: (_) => OrganizationMembersPage(
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
      appBar: const SimpleAppBar(title: 'Members'),
      body: BlocProvider<OrganizationMembersBloc>(
        create: (_) => OrganizationMembersBloc(
          uid: uid,
          organizationId: organizationId,
        )..add(LoadData()),
        child: BlocBuilder<OrganizationMembersBloc, OrganizationMembersState>(
          builder: (BuildContext context, OrganizationMembersState state) {
            if (!state.isLoaded) {
              return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            } else {
              return OrganizationsMembersListView(
                memberList: state.members,
                isOwner: state.isOwned,
              );
            }
          },
        ),
      ),
    );
  }
}
