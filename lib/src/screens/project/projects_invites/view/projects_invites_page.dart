import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/project/projects_invites/bloc/user_projects_invites_bloc.dart';
import 'package:union_app/src/screens/project/projects_invites/widgets/invite_item_widget.dart';
import 'package:union_app/src/screens/widgets/exceptions/barrel.dart';
import 'package:union_app/src/theme.dart';

class UserProjectsInvites extends StatelessWidget {
  const UserProjectsInvites({Key? key, required String uid})
      : _uid = uid,
        super(key: key);

  final String _uid;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserProjectsInvitesBloc>(
      create: (BuildContext context) => UserProjectsInvitesBloc()..add(GetUserInvites(_uid)),
      child: _ProjectsInvitesPage(),
    );
  }
}

class _ProjectsInvitesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProjectsInvitesBloc, UserProjectsInvitesState>(
      buildWhen: (UserProjectsInvitesState previous, UserProjectsInvitesState current) {
        return previous.pageStatus != current.pageStatus || previous.invites != current.invites;
      },
      builder: (BuildContext context, UserProjectsInvitesState state) {
        if (state.pageStatus == PageStatus.INITIAL) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            ),
          );
        } else {
          return state.invites.isNotEmpty
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.invites.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InviteItemWidget(
                            project: state.invites[index].project,
                            sender: state.invites[index].sender,
                            onAcceptPressed: (Project project) {
                              context.read<UserProjectsInvitesBloc>().add(
                                  AcceptPressed(state.invites[index].id, project.id, context.read<AppBloc>().state.user.id));
                            },
                            onDeletePressed: (Project project) {
                              context.read<UserProjectsInvitesBloc>().add(DeletePressed(state.invites[index].id));
                            },
                          );
                        },
                      ),
                    )
                  ],
                )
              : const EmptyPageWidget(message: 'No projects invites yet!');
        }
      },
    );
  }
}
