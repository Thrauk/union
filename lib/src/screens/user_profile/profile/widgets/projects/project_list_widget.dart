import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/user_profile/profile/widgets/projects/project_list_element_widget.dart';

import 'bloc/project_list_bloc.dart';

class ProjectListWidget extends StatelessWidget {
  const ProjectListWidget({
    Key? key,
    required this.uid,
    required this.user,
  }) : super(key: key);

  final String uid;
  final FullUser user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProjectListBloc>(
        create: (_) => ProjectListBloc(uid: uid)..add(Initialize()),
        child: BlocBuilder<ProjectListBloc, ProjectListState>(
          builder: (BuildContext context, ProjectListState state) {
            return ListView.builder(
                itemCount: state.projectList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ProjectListElementWidget(
                    user: user,
                    project: state.projectList[index],
                  );
                });
          },
        ));
  }
}
