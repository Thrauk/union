import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';
import 'package:union_app/src/screens/open_roles/view_open_role_applicants/bloc/open_role_applicants_bloc.dart';
import 'package:union_app/src/screens/open_roles/view_open_role_applicants/widgets/applicant_item_widget.dart';
import 'package:union_app/src/screens/widgets/app_bar/simple_app_bar.dart';
import 'package:union_app/src/screens/widgets/exceptions/empty_page_widget.dart';
import 'package:union_app/src/theme.dart';

class OpenRoleApplicantsPage extends StatelessWidget {
  const OpenRoleApplicantsPage({Key? key, required this.openRole}) : super(key: key);

  final ProjectOpenRole openRole;

  static Route<void> route(ProjectOpenRole openRole) {
    return MaterialPageRoute<void>(builder: (_) => OpenRoleApplicantsPage(openRole: openRole));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OpenRoleApplicantsBloc>(
      child: _OpenRoleApplicantsPage(openRole: openRole),
      create: (BuildContext context) {
        return OpenRoleApplicantsBloc(FirebaseProjectOpenRoleRepository())..add(GetApplicantsList(openRole.id));
      },
    );
  }
}

class _OpenRoleApplicantsPage extends StatelessWidget {
  const _OpenRoleApplicantsPage({Key? key, required this.openRole}) : super(key: key);

  final ProjectOpenRole openRole;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpenRoleApplicantsBloc, OpenRoleApplicantsState>(
      buildWhen: (OpenRoleApplicantsState previous, OpenRoleApplicantsState current) {
        return previous.applicationsItems != current.applicationsItems || previous.status != current.status;
      },
      builder: (BuildContext context, OpenRoleApplicantsState state) {
        return Scaffold(
          appBar: const SimpleAppBar(
            title: 'Applicants',
          ),
          body: state.applicationsItems.isNotEmpty
              ? Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.applicationsItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ApplicantItemWidget(
                            applicationItem: state.applicationsItems[index],
                            openRole: openRole,
                          );
                        },
                      ),
                    )
                  ],
                )
              : state.status == StatusEnum.loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : const EmptyPageWidget(message: 'No applicants yet!'),
        );
      },
    );
  }
}
