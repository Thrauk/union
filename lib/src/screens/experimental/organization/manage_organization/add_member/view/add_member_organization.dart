import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/experimental/organization/manage_organization/add_member/bloc/add_member_organization_bloc.dart';
import 'package:union_app/src/screens/experimental/organization/manage_organization/add_member/view/widget/result_list_view.dart';
import 'package:union_app/src/screens/experimental/organization/manage_organization/add_member/view/widget/search_bar_widget.dart';

import '../../../../../../theme.dart';

class AddMemberOrganization extends StatelessWidget {
  const AddMemberOrganization({Key? key, required this.organizationId}) : super(key: key);

  static Route<void> route(String organizationId) {
    return MaterialPageRoute<void>(
        builder: (_) => AddMemberOrganization(
              organizationId: organizationId,
            ));
  }

  final String organizationId;

  @override
  Widget build(BuildContext context) {
    final String uid = context.select((AppBloc bloc) => bloc.state.user.id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text('Search', style: AppStyles.textStyleBodyBig),
      ),
      body: BlocProvider<AddMemberOrganizationBloc>(
        create: (_) => AddMemberOrganizationBloc(
          organizationId: organizationId,
          uid: uid,
        )..add(LoadOrganization(organizationId: organizationId)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<AddMemberOrganizationBloc, AddMemberOrganizationState>(
            builder: (BuildContext context, AddMemberOrganizationState state) {
              if (!state.isOrganizationLoaded) {
                return const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: <Widget>[
                  const SearchBarWidget(),
                  if (state.isLoaded) ResultListView(memberList: state.userList,) else const CircularProgressIndicator(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
