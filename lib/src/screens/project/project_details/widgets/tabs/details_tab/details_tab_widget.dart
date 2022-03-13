import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/article/article_details/article_details_page.dart';
import 'package:union_app/src/screens/project/members_list/view/members_list_page.dart';
import 'package:union_app/src/screens/project/project_details/bloc/project_details_bloc.dart';
import 'package:union_app/src/screens/project/widgets/members_widget/members_widget.dart';
import 'package:union_app/src/theme.dart';

class DetailsTabWidget extends StatelessWidget {
  const DetailsTabWidget({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(
      buildWhen: (ProjectDetailsState previous, ProjectDetailsState current) {
        return previous.membersList != current.membersList;
      },
      builder: (BuildContext context, ProjectDetailsState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 8),
                if (state.membersList.isNotEmpty &&
                    state.membersList.where((FullUser element) => element.id == context.read<AppBloc>().state.user.id) != null)
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MembersListPage.route(state.membersList, project)).then(
                            (_) {
                              if (project.membersUid != null)
                                context.read<ProjectDetailsBloc>().add(GetMembers(project.id));
                            },
                          );
                        },
                        child: MembersWidget(
                          membersList: state.membersList,
                        ),
                      ),
                    ],
                  ),
                const Text('Short Description', style: AppStyles.textStyleHeading1),
                const SizedBox(height: 16),
                Text(project.shortDescription, style: AppStyles.textStyleBody),
                const SizedBox(height: 24),
                const Text('Details', style: AppStyles.textStyleHeading1),
                const SizedBox(height: 16),
                Text(project.details, style: AppStyles.textStyleBody),
                const SizedBox(height: 16),
                if (project.tags!.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Text(
                      'Tags',
                      style: AppStyles.textStyleHeading1,
                    ),
                  ),
                if (project.tags!.isNotEmpty)
                  Wrap(
                    spacing: 4,
                    children: project.tags!
                        .map(
                          (dynamic tag) => TagWidget(label: tag as String),
                        )
                        .toList()
                        .cast<Widget>(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
