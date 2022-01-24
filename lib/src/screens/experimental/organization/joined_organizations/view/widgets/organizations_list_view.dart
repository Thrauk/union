import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/experimental/models/organization.dart';
import 'package:union_app/src/screens/experimental/organization/joined_organizations/view/widgets/organizations_list_view_element.dart';

class OrganizationsListView extends StatelessWidget {
  const OrganizationsListView({
    Key? key,
    this.organizationsList = const <Organization>[],
  }) : super(key: key);

  final List<Organization> organizationsList;

  @override
  Widget build(BuildContext context) {
    final String uid = context.select((AppBloc bloc) => bloc.state.user.id);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListView.builder(
        itemCount: organizationsList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return OrganizationListViewElement(organization: organizationsList[index], loggedUid: uid,);
        },
      ),
    );
  }
}
