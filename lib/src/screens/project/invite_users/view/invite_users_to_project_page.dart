import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/project/invite_users/bloc/invite_users_to_project_bloc.dart';
import 'package:union_app/src/screens/project/invite_users/widgets/barrel.dart';
import 'package:union_app/src/screens/widgets/app_bar/simple_app_bar.dart';
import 'package:union_app/src/screens/widgets/exceptions/barrel.dart';
import 'package:union_app/src/screens/widgets/search_bar_widget/search_bar_widget.dart';
import 'package:union_app/src/screens/widgets/user_item/user_item_widget.dart';

class InviteUsersToProjectPage extends StatelessWidget {
  const InviteUsersToProjectPage({Key? key, required Project project})
      : _project = project,
        super(key: key);

  final Project _project;

  static Route<void> route(Project project) {
    return MaterialPageRoute<void>(builder: (_) => InviteUsersToProjectPage(project: project));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: _project.title ?? ''),
      body: BlocProvider<InviteUsersToProjectBloc>(
        create: (BuildContext context) => InviteUsersToProjectBloc()..add(GetProjectInvites(_project.id)),
        child: _RequestJoinUsersPage(project: _project),
      ),
    );
  }
}

class _RequestJoinUsersPage extends StatelessWidget {
  const _RequestJoinUsersPage({Key? key, required Project project})
      : _project = project,
        super(key: key);

  final Project _project;

  @override
  Widget build(BuildContext context) {
    final List projectMembersUids = _project.membersUid ?? <String>[];
    final String loggedUid = context.read<AppBloc>().state.user.id;

    return BlocBuilder<InviteUsersToProjectBloc, InviteUsersToProjectState>(
      buildWhen: (InviteUsersToProjectState previous, InviteUsersToProjectState current) {
        return previous.invitedUsersUids != current.invitedUsersUids || previous.resultedUsers != current.resultedUsers;
      },
      builder: (BuildContext context, InviteUsersToProjectState state) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBarWidget(
                onSearchPressed: () {
                  context.read<InviteUsersToProjectBloc>().add(SearchIconPressed());
                },
                onTextChanged: (String value) {
                  context.read<InviteUsersToProjectBloc>().add(TextChanged(value));
                },
              ),
            ),
            if (state.pageStatus == PageStatus.FINAL)
              state.resultedUsers.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: state.resultedUsers.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final FullUser user = state.resultedUsers[index];
                          return UserItemWidget(
                            user: user,
                            endWidget: !projectMembersUids.contains(user.id)
                                ? (!state.invitedUsersUids.contains(user.id)
                                    ? InviteButton(
                                        onPressed: () {
                                          context.read<InviteUsersToProjectBloc>().add(
                                                InvitePressed(
                                                    receiverUid: user.id, senderUid: loggedUid, projectId: _project.id),
                                              );
                                        },
                                      )
                                    : DismissButton(onPressed: () {
                                        context
                                            .read<InviteUsersToProjectBloc>()
                                            .add(DismissPressed(projectId: _project.id, receiverUid: user.id));
                                      }))
                                : Container(),
                          );
                        },
                      ),
                    )
                  : Expanded(child: EmptyPageWidget(message: 'No users found for "${state.query}"')),
            if (state.pageStatus == PageStatus.FAILED) const SomethingWentWrongWidget()
          ],
        );
      },
    );
  }
}
