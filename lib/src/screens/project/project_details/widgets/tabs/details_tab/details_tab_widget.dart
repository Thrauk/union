import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/project/members_list/view/members_list_page.dart';
import 'package:union_app/src/screens/project/project_details/bloc/project_details_bloc.dart';
import 'package:union_app/src/screens/project/widgets/members_widget/members_widget.dart';
import 'package:union_app/src/screens/widgets/chips/chip_with_text.dart';
import 'package:union_app/src/theme.dart';

class DetailsTabWidget extends StatelessWidget {
  const DetailsTabWidget({Key? key, required Project project, required bool isMember})
      : _project = project,
        _isMember = isMember,
        super(key: key);

  final Project _project;
  final bool _isMember;

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
                if (state.membersList.isNotEmpty && _isMember)
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MembersListPage.route(state.membersList, _project)).then(
                            (_) {
                              if (_project.membersUid != null) context.read<ProjectDetailsBloc>().add(GetMembers(_project.id));
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
                Text(_project.shortDescription, style: AppStyles.textStyleBody),
                const SizedBox(height: 24),
                const Text('Details', style: AppStyles.textStyleHeading1),
                const SizedBox(height: 16),
                Text(_project.details, style: AppStyles.textStyleBody),
                const SizedBox(height: 16),
                if (_project.tags!.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Text(
                      'Tags',
                      style: AppStyles.textStyleHeading1,
                    ),
                  ),
                if (_project.tags!.isNotEmpty)
                  Wrap(
                    spacing: 4,
                    children: _project.tags!
                        .map(
                          (dynamic tag) => ChipWithText(label: tag as String),
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
