import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/project/invite_users/bloc/invite_users_to_project_bloc.dart';
import 'package:union_app/src/screens/widgets/app_bar/simple_app_bar.dart';
import 'package:union_app/src/screens/widgets/buttons/union_classic_button.dart';
import 'package:union_app/src/screens/widgets/exceptions/barrel.dart';
import 'package:union_app/src/screens/widgets/search_bar_widget/search_bar_widget.dart';
import 'package:union_app/src/screens/widgets/user_item/user_item_widget.dart';
import 'package:union_app/src/theme.dart';

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
        create: (BuildContext context) => InviteUsersToProjectBloc(),
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
    final List projectMembers = _project.membersUid ?? <FullUser>[];

    return BlocBuilder<InviteUsersToProjectBloc, InviteUsersToProjectState>(
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
                            endWidget: !projectMembers.contains(user.id)
                                ? UnionClassicButton(
                                    minimumSize: const Size(0, 28),
                                    text: 'Send request',
                                    textStyle: AppStyles.buttonTextStyle.copyWith(fontSize: 14),
                                    onPressed: () {
                                      context
                                          .read<InviteUsersToProjectBloc>()
                                          .add(InvitePressed(state.resultedUsers[index].id));
                                    },
                                  )
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
