import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/profile/widgets/projects/project_list_element_widget.dart';

import 'bloc/project_list_bloc.dart';

class ProjectListWidget extends StatelessWidget {
  const ProjectListWidget({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProjectListBloc>(
        create: (_) => ProjectListBloc(uid: uid),
            child : BlocBuilder<ProjectListBloc, ProjectListState>(
      builder: (BuildContext context, ProjectListState state) {
        return ListView.builder(
            itemCount: state.projectList.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return ProjectListElementWidget(user: state.user, project: state.projectList[index],);
            });
      },
    ));
  }
}
