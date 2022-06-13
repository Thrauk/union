import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/app/app.dart';

import 'organization_members_list_element.dart';

class OrganizationsMembersListView extends StatelessWidget {
  const OrganizationsMembersListView({
    Key? key,
    this.memberList = const <FullUser>[],
    this.isOwner = false,
  }) : super(key: key);

  final List<FullUser> memberList;
  final bool isOwner;

  @override
  Widget build(BuildContext context) {
    final String uid = context.select((AppBloc bloc) => bloc.state.user.id);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListView.builder(
        itemCount: memberList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return OrganizationMembersListElement(
            isOwner: isOwner,
            loggedUid: uid,
            user: memberList[index],
          );
        },
      ),
    );
  }
}
