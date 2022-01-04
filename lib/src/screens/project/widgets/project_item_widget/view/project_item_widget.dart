import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_repository.dart';
import 'package:union_app/src/screens/project/project_details/view/project_details_page.dart';
import 'package:union_app/src/screens/project/widgets/project_item_widget/bloc/project_item_widget_bloc.dart';
import 'package:union_app/src/theme.dart';
import 'package:union_app/src/util/date_format_utils.dart';

class ProjectItemWidget extends StatelessWidget {
  const ProjectItemWidget({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProjectItemWidgetBloc>(
      child: _ProjectItemWidget(project: project),
      create: (_) => ProjectItemWidgetBloc(FirebaseProjectRepository())..add(GetDetails(project.ownerId)),
    );
  }
}

class _ProjectItemWidget extends StatelessWidget {
  const _ProjectItemWidget({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectItemWidgetBloc, ProjectItemWidgetState>(
      buildWhen: (ProjectItemWidgetState previous, ProjectItemWidgetState current) {
        return (previous.ownerDisplayName != current.ownerDisplayName) ||
            (previous.ownerPhotoUrl != current.ownerPhotoUrl || previous.isExpanded != current.isExpanded);
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
                      const Icon(Icons.analytics, color: AppColors.primaryColor,),
                      const SizedBox(width: 6),
                      Text(project.title!, overflow: TextOverflow.ellipsis, style: AppStyles.buttonTextStylePrimaryColor),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Created by ${state.ownerDisplayName}',
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.textStyleBodySmall,
                      ),
                      Text(
                        ' on ${DateFormatUtils.timestampToDate(project.timestamp)}',
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.textStyleBodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: 16,
                          maxHeight: 16 * 3,
                        ),
                        child: GestureDetector(
                          child: Text(
                            project.shortDescription,
                            overflow: state.isExpanded == false ? TextOverflow.ellipsis : TextOverflow.visible,
                            style: AppStyles.textStyleBody,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
