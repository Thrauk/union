

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/experimental/models/organization.dart';
import 'package:union_app/src/screens/experimental/organization/manage_organization/add_member/bloc/add_member_organization_bloc.dart';
import 'package:union_app/src/screens/experimental/organization/manage_organization/add_member/view/widget/result_list_element.dart';

class ResultListView extends StatelessWidget {
  const ResultListView({
    Key? key,
    this.memberList = const <FullUser>[],
  }) : super(key: key);

  final List<FullUser> memberList;

  @override
  Widget build(BuildContext context) {
    final Organization organization = context.select((AddMemberOrganizationBloc bloc) => bloc.state.organization);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListView.builder(
        itemCount: memberList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return ResultListElement(
            isMember: organization.members.contains(memberList[index].id),
            user: memberList[index],
          );
        },
      ),
    );
  }
}
