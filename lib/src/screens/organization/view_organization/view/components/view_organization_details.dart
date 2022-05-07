import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/models/organization/organization.dart';
import 'package:union_app/src/screens/organization/edit_organization/view/edit_organization_page.dart';
import 'package:union_app/src/screens/organization/manage_organization/add_member/view/add_member_organization.dart';
import 'package:union_app/src/screens/organization/view_organization/bloc/view_organization_bloc.dart';
import 'package:union_app/src/screens/organization/view_organization/view/components/view_organization_member_area.dart';
import 'package:union_app/src/screens/organization/view_organization/view/widgets/organization_info.dart';
import 'package:union_app/src/screens/organization/view_organization/view/widgets/organization_owner_menu.dart';
import 'package:union_app/src/screens/organization/view_organization/view/widgets/organization_posts_area.dart';
import 'package:union_app/src/screens/organization/view_organization/view/widgets/widgets.dart';
import 'package:union_app/src/screens/organization/view_organization_requests/view/view_organization_requests.dart';
import 'package:union_app/src/screens/project/create_project/create_project.dart';

import '../widgets/organization_header_image.dart';

class ViewOrganizationDetails extends StatelessWidget {
  const ViewOrganizationDetails({
    Key? key,
    required this.organization,
    required this.isOwned,
    required this.isMember,
    required this.isPublic,
    this.isRequested = false,
    this.projects = const <Project>[],
  }) : super(key: key);

  final Organization organization;
  final bool isOwned;
  final bool isMember;
  final bool isPublic;
  final bool isRequested;
  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            OrganizationHeaderImage(
              photoUrl: organization.photoUrl,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  OrganizationInfo(organization: organization),
                  ViewOrganizationMemberArea(
                    isMember: isMember,
                    isOwner: isOwned,
                    isPublic: isPublic,
                    isRequested: isRequested,
                    onLeaveJoinPressed: () {
                      if (isMember) {
                        context.read<ViewOrganizationBloc>().add(LeaveOrganization());
                      } else {
                        context.read<ViewOrganizationBloc>().add(JoinOrganization());
                      }
                    },
                    onRequestPressed: () {
                      context.read<ViewOrganizationBloc>().add(RequestJoin());
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: _MenuSelect(
                      organization: organization,
                      isOwned: isOwned,
                      isPublic: isPublic,
                      isMember: isMember,
                    ),
                  ),
                ],
              ),
            ),
            OrganizationPostsArea(
              projects: projects,
              isPublic: isPublic,
              isMember: isMember,
            )
          ],
        ),
      ),
    );
  }
}

class _MenuSelect extends StatelessWidget {
  const _MenuSelect({
    Key? key,
    required this.organization,
    required this.isOwned,
    required this.isMember,
    required this.isPublic,
  }) : super(key: key);

  final Organization organization;
  final bool isOwned;
  final bool isMember;
  final bool isPublic;

  @override
  Widget build(BuildContext context) {
    if (isOwned)
      return OrganizationOwnerMenu(
        onCreateProjectPressed: () {
          Navigator.of(context)
              .push(CreateProjectPage.route(organizationId: organization.id))
              .then((dynamic response) => context.read<ViewOrganizationBloc>().add(LoadData()));
        },
        onAddMemberPressed: () {
          Navigator.of(context)
              .push(AddMemberOrganization.route(organization.id))
              .then((dynamic response) => context.read<ViewOrganizationBloc>().add(LoadData()));
        },
        onEditPressed: () {
          Navigator.of(context)
              .push(EditOrganizationPage.route(organization.id))
              .then((dynamic response) => context.read<ViewOrganizationBloc>().add(LoadData()));
        },
        onDeletePressed: () {
          context.read<ViewOrganizationBloc>().add(DeleteOrganization());
        },
        onViewRequests: () {
          Navigator.of(context)
              .push(ViewOrganizationRequests.route(organization.id))
              .then((dynamic response) => context.read<ViewOrganizationBloc>().add(LoadData()));
        },
      );
    else if (isMember)
      return OrganizationMemberMenu(
        onCreateProjectPressed: () {
          Navigator.of(context)
              .push(CreateProjectPage.route(organizationId: organization.id))
              .then((dynamic response) => context.read<ViewOrganizationBloc>().add(LoadData()));
        },
      );
    else
      return Container();
  }
}
