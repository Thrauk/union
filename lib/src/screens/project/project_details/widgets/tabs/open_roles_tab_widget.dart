import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/project/project_details/bloc/project_details_bloc.dart';
import 'package:union_app/src/screens/project/project_details/view/project_details_page.dart';
import 'package:union_app/src/screens/project/project_details/widgets/open_role_item_widget.dart';
import 'package:union_app/src/screens/widgets/empty_page/empty_page_widget.dart';

class OpenRolesTabWidget extends StatelessWidget {
  const OpenRolesTabWidget({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(
      buildWhen: (ProjectDetailsState previous, ProjectDetailsState current) {
        return previous.openRoles != current.openRoles;
      },
      builder: (BuildContext context, ProjectDetailsState state) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (state.openRoles.isNotEmpty)
                Flexible(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.openRoles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return OpenRoleItemWidget(
                          projectOpenRole: state.openRoles[index],
                          showApplyButton: isNotProjectOwner(project.ownerId, context.read<AppBloc>().state.user.id));
                    },
                  ),
                )
              else
                const EmptyPageWidget(message: 'No open roles yet!')
            ],
          ),
        );
      },
    );
  }
}
