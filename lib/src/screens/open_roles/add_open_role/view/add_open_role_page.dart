import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_open_role_repository.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/open_roles/add_open_role/bloc/add_open_role_bloc.dart';
import 'package:union_app/src/screens/open_roles/add_open_role/widgets/buttons/post_button_widget.dart';
import 'package:union_app/src/screens/open_roles/add_open_role/widgets/buttons/remote_switch_button_widget.dart';
import 'package:union_app/src/screens/open_roles/add_open_role/widgets/form_fields/country_input_widget.dart';
import 'package:union_app/src/screens/open_roles/add_open_role/widgets/form_fields/location_input_widget.dart';
import 'package:union_app/src/screens/open_roles/add_open_role/widgets/form_fields/specifications_input_widget.dart';
import 'package:union_app/src/screens/open_roles/add_open_role/widgets/form_fields/title_input_widget.dart';
import 'package:union_app/src/screens/open_roles/add_open_role/widgets/radio_buttons/is_paid_radio_buttons.dart';
import 'package:union_app/src/screens/widgets/app_bar/simple_app_bar.dart';
import 'package:union_app/src/theme.dart';

class AddOpenRolePage extends StatelessWidget {
  const AddOpenRolePage({Key? key, required this.projectId}) : super(key: key);

  final String projectId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddOpenRoleBloc>(
      create: (BuildContext context) => AddOpenRoleBloc(FirebaseProjectOpenRoleRepository()),
      child: Scaffold(
        appBar: const SimpleAppBar(title: 'Add open role'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const TitleInputWidget(),
                const SpecificationsInputWidget(),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 2),
                  child: Text(
                    'Location',
                    style: AppStyles.textStyleHeading1,
                  ),
                ),
                const CountryInputWidget(),
                const CityInputWidget(),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 2),
                  child: Text(
                    'Remote work',
                    style: AppStyles.textStyleHeading1,
                  ),
                ),
                const RemoteSwitchButtonWidget(),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 2),
                  child: Text(
                    'Payment',
                    style: AppStyles.textStyleHeading1,
                  ),
                ),
                const IsPaidRadioButtonsWidget(),
                Row(
                  children: <Widget>[
                    Expanded(flex: 1, child: PostButtonWidget(projectId: projectId)),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(HomePage.route()),
                        child: const Center(
                          child: Text(
                            'Cancel',
                            style: AppStyles.textStyleHeading1,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}