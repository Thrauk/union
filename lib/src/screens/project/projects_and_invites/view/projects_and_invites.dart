import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/project/projects_invites/view/projects_invites_page.dart';
import 'package:union_app/src/screens/project/user_projects/user_projects.dart';
import 'package:union_app/src/theme.dart';

class ProjectsAndInvitesPage extends StatelessWidget {
  const ProjectsAndInvitesPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ProjectsAndInvitesPage());
  }

  @override
  Widget build(BuildContext context) {
    final String loggedUid = context.read<AppBloc>().state.user.id;

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.backgroundLight,
            bottom: const TabBar(
              indicatorColor: AppColors.primaryColor,
              labelColor: AppColors.white09,
              unselectedLabelColor: AppColors.white05,
              labelStyle: AppStyles.textStyleBody,
              tabs: <Widget>[
                Tab(text: 'Projects'),
                Tab(text: 'Invites'),
              ],
            ),
          ),
          body: TabBarView(children: <Widget>[
            UserProjectsPage(uid: loggedUid),
            UserProjectsInvites(uid: loggedUid),
          ]),
        ),
      ),
    );
  }
}
