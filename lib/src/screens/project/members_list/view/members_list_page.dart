import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firebase_project_repository/barrel.dart';
import 'package:union_app/src/screens/project/widgets/members_widget/bloc/project_members_bloc.dart';
import 'package:union_app/src/screens/project/widgets/members_widget/member_item_widget.dart';
import 'package:union_app/src/screens/widgets/app_bar/simple_app_bar.dart';

class MembersListPage extends StatelessWidget {
  const MembersListPage({Key? key, required this.users, required this.project}) : super(key: key);

  final Project project;
  final List<FullUser> users;

  static Route<void> route(List<FullUser> users, Project project) {
    return MaterialPageRoute<void>(builder: (_) => MembersListPage(users: users, project: project));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Members'),
      body: BlocProvider<ProjectMembersBloc>(
        create: (BuildContext context) => ProjectMembersBloc(FirebaseProjectRepository())..add(SetMembers(users)),
        child: BlocBuilder<ProjectMembersBloc, ProjectMembersState>(
          buildWhen: (ProjectMembersState previous, ProjectMembersState current) {
            return previous.users != current.users;
          },
          builder: (BuildContext context, ProjectMembersState state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListView.builder(
                  itemCount: state.users.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return MemberItemWidget(user: state.users[index], ownerId: project.ownerId, projectId: project.id ?? '');
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
