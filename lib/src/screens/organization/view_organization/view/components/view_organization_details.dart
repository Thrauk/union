import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/models/organization/organization.dart';
import 'package:union_app/src/screens/organization/edit_organization/view/edit_organization_page.dart';
import 'package:union_app/src/screens/organization/manage_organization/add_member/view/add_member_organization.dart';
import 'package:union_app/src/screens/organization/organization_members/view/organization_members_page.dart';
import 'package:union_app/src/screens/organization/view_organization/bloc/view_organization_bloc.dart';
import 'package:union_app/src/screens/organization/view_organization/view/components/view_organization_member_area.dart';
import 'package:union_app/src/screens/project/create_project/create_project.dart';
import 'package:union_app/src/screens/project/widgets/project_item_widget/view/project_item_widget.dart';
import 'package:union_app/src/theme.dart';


class ViewOrganizationDetails extends StatelessWidget {
  const ViewOrganizationDetails({
    Key? key,
    required this.organization,
    required this.isOwned,
    required this.isMember,
    required this.isPublic,
    this.projects = const <Project>[],
  }) : super(key: key);

  final Organization organization;
  final bool isOwned;
  final bool isMember;
  final bool isPublic;
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
            if (organization.photoUrl != '')
              SizedBox(
                height: 120,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: organization.photoUrl,
                  fit: BoxFit.fitWidth,
                ),
              )
            else
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    height: 120,
                    width: double.infinity,
                    color: AppColors.primaryColor,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.group,
                      color: AppColors.black09,
                      size: 35,
                    ),
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        organization.name,
                        style: AppStyles.textStyleHeading2,
                      ),
                      // if (isOwned)
                      //   const Icon(
                      //     Icons.person,
                      //     color: AppColors.primaryColor,
                      //   ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(organization.description, style: AppStyles.textStyleBody),
                  const SizedBox(height: 12),
                  Row(
                    children: <Widget>[
                      if (organization.type == 'Public')
                        const Icon(
                          Icons.lock_open,
                          color: AppColors.white07,
                          size: 20,
                        )
                      else
                        const Icon(
                          Icons.lock_outlined,
                          color: AppColors.white07,
                          size: 20,
                        ),
                      const SizedBox(width: 2),
                      Text(
                        organization.type,
                        style: AppStyles.textStyleBodySmall,
                      ),
                      const Text(' • ', style: AppStyles.textStyleBodySmall),
                      Text(
                        organization.category,
                        style: AppStyles.textStyleBodySmall,
                      ),
                      const Text(' • ', style: AppStyles.textStyleBodySmall),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(OrganizationMembersPage.route(organization.id));
                        },
                        child: Text(
                          organization.members.length > 1
                              ? '${organization.members.length} members'
                              : '${organization.members.length} member',
                          style: AppStyles.textStyleBodySmallW08,
                        ),
                      ),
                    ],
                  ),
                  if (isMember || isPublic)
                    ViewOrganizationMemberArea(
                      isMember: isMember,
                      isOwner: isOwned,
                    ),
                  if (isOwned)
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Wrap(
                        spacing: 8,
                        children: <Widget>[
                          ElevatedButton.icon(
                            icon: const Icon(
                              Icons.analytics,
                              color: AppColors.primaryColor,
                              size: 20.0,
                            ),
                            label: const Text(
                              'Create project',
                              style: AppStyles.textStyleBodySmallW08,
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(CreateProjectPage.route(organizationId: organization.id))
                                  .then((dynamic response) => context.read<ViewOrganizationBloc>().add(LoadData()));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.backgroundLight1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            icon: const Icon(
                              Icons.person_add_alt_1_sharp,
                              color: AppColors.primaryColor,
                              size: 20.0,
                            ),
                            label: const Text(
                              'Add members',
                              style: AppStyles.textStyleBodySmallW08,
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(AddMemberOrganization.route(organization.id))
                                  .then((dynamic response) => context.read<ViewOrganizationBloc>().add(LoadData()));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.backgroundLight1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            icon: const Icon(
                              Icons.edit,
                              color: AppColors.primaryColor,
                              size: 20.0,
                            ),
                            label: const Text(
                              'Edit',
                              style: AppStyles.textStyleBodySmallW08,
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(EditOrganizationPage.route(organization.id))
                                  .then((dynamic response) => context.read<ViewOrganizationBloc>().add(LoadData()));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.backgroundLight1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            icon: const Icon(
                              Icons.delete,
                              color: AppColors.primaryColor,
                              size: 20.0,
                            ),
                            label: const Text(
                              'Delete organization',
                              style: AppStyles.textStyleBodySmallW08,
                            ),
                            onPressed: () {
                              context.read<ViewOrganizationBloc>().add(DeleteOrganization());
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.backgroundLight1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  else if(isMember)
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Row(
                        children: <Widget>[
                          ElevatedButton.icon(
                            icon: const Icon(
                              Icons.analytics,
                              color: AppColors.primaryColor,
                              size: 20.0,
                            ),
                            label: const Text(
                              'Create project',
                              style: AppStyles.textStyleBodySmallW08,
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(CreateProjectPage.route(organizationId: organization.id))
                                  .then((dynamic response) => context.read<ViewOrganizationBloc>().add(LoadData()));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.backgroundLight1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                ],
              ),
            ),
            if (isMember || isPublic)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text('Projects', style: AppStyles.textStyleHeading1),
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: projects.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProjectItemWidget(
                          project: projects[index],
                        );
                      },
                    ),
                  ],
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.lock, color: AppColors.primaryColor),
                      SizedBox(height: 8),
                      Text('The posts of this organizations are private', style: AppStyles.textStyleBody),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
