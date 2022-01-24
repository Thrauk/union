import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/experimental/organization/joined_organizations/bloc/joined_organizations_bloc.dart';
import 'package:union_app/src/screens/experimental/organization/joined_organizations/view/widgets/organizations_list_view.dart';
import 'package:union_app/src/screens/widgets/app_bottom_nav_bar/app_bottom_nav_bar.dart';

import '../../../../../theme.dart';

class JoinedOrganizationsPage extends StatelessWidget {
  const JoinedOrganizationsPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const JoinedOrganizationsPage());
  }

  @override
  Widget build(BuildContext context) {
    final String uid = context.select((AppBloc bloc) => bloc.state.user.id);
    return Scaffold(
      bottomNavigationBar: const CustomNavBar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text('Organizations', style: AppStyles.textStyleBodyBig),
      ),
      body: BlocProvider<JoinedOrganizationsBloc>(
        create: (_) => JoinedOrganizationsBloc(uid: uid)..add(LoadData()),
        child: BlocBuilder<JoinedOrganizationsBloc, JoinedOrganizationsState>(
          builder: (BuildContext context, JoinedOrganizationsState state) {
            if (!state.isLoaded) {
              return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            } else {
              return OrganizationsListView(
                organizationsList: state.organizationList,
              );
            }
          },
        ),
      ),
    );
  }
}
