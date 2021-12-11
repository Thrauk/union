import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_repository.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/project/project_details/project_details.dart';
import 'package:union_app/src/screens/project/widgets/project_item_widget/bloc/project_item_widget_bloc.dart';
import 'package:union_app/src/theme.dart';

class ProjectItemWidget extends StatelessWidget {
  const ProjectItemWidget({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProjectItemWidgetBloc>(
      child: _ProjectItemWidget(project: project),
      create: (_) => ProjectItemWidgetBloc(FirebaseProjectRepository())
        ..add(SetOwnerId(context.read<AppBloc>().state.user.id)),
    );
  }
}

class _ProjectItemWidget extends StatelessWidget {
  const _ProjectItemWidget({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectItemWidgetBloc, ProjectItemWidgetState>(
      buildWhen:
          (ProjectItemWidgetState previous, ProjectItemWidgetState current) {
        return (previous.ownerDisplayName != current.ownerDisplayName) ||
            (previous.ownerPhotoUrl != current.ownerPhotoUrl ||
                previous.isExpanded != current.isExpanded);
      },
      builder: (BuildContext context, ProjectItemWidgetState state) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ProjectDetailsPage(
                  project: project,
                ),
              ),
            );
          },
          child: Card(
            color: AppColors.backgroundLight,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: state.ownerPhotoUrl != ''
                                  ? NetworkImage(state.ownerPhotoUrl!)
                                  : const AssetImage('assets/icons/user.png')
                                      as ImageProvider),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        state.ownerDisplayName!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white09,
                        ),
                      ),
                      const Spacer(),
                      const Image(
                          image: AssetImage('assets/icons/three_dots.png'))
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    project.title!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 14,
                      color: AppColors.white09,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Wrap(children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 14,
                        maxHeight: 14 * 3,
                      ),
                      child: GestureDetector(
                        child: Text(
                          project.shortDescription,
                          overflow: state.isExpanded == false
                              ? TextOverflow.ellipsis
                              : TextOverflow.visible,
                          style: const TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 14,
                            color: AppColors.white07,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
