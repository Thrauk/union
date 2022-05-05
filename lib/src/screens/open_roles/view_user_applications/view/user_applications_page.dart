import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/open_roles/view_user_applications/bloc/view_user_applications_bloc.dart';
import 'package:union_app/src/screens/project/project_details/widgets/open_role_item_widget.dart';
import 'package:union_app/src/screens/widgets/app_bar/simple_app_bar.dart';
import 'package:union_app/src/screens/widgets/empty_page/empty_page_widget.dart';

class UserApplicationsPage extends StatelessWidget {
  const UserApplicationsPage({Key? key, required this.uid}) : super(key: key);

  final String uid;

  static Route<void> route(String uid) {
    return MaterialPageRoute<void>(builder: (_) => UserApplicationsPage(uid: uid));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ViewUserApplicationsBloc>(
      child: _UserApplicationsPage(uid: uid),
      create: (_) => ViewUserApplicationsBloc(
        FirebaseOpenRoleApplicationsRepository(),
      )..add(
          GetApplications(uid),
        ),
    );
  }
}

class _UserApplicationsPage extends StatelessWidget {
  const _UserApplicationsPage({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewUserApplicationsBloc, ViewUserApplicationsState>(
      buildWhen: (ViewUserApplicationsState previous, ViewUserApplicationsState current) {
        return previous.openRoles != current.openRoles || previous.status != current.status;
      },
      builder: (BuildContext context, ViewUserApplicationsState state) {
        return Scaffold(
          appBar: const SimpleAppBar(title: 'Applications'),
          body: state.status != PageStatus.initial
              ? Column(
                  children: <Widget>[
                    Expanded(
                      child: state.openRoles.isNotEmpty
                          ? ListView.builder(
                              itemCount: state.openRoles.length,
                              itemBuilder: (BuildContext context, int index) {
                                return OpenRoleItemWidget(
                                  projectOpenRole: state.openRoles[index],
                                  showApplyButton: uid != context.read<AppBloc>().state.user.id,
                                );
                              },
                            )
                          : const EmptyPageWidget(message: 'No applications yet!'),
                    )
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
