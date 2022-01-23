import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/experimental/organization/create_organization/bloc/create_organization_bloc.dart';
import 'package:union_app/src/screens/experimental/organization/create_organization/view/components/create_organization_choices.dart';
import 'package:union_app/src/screens/experimental/organization/create_organization/view/components/create_organization_form.dart';
import 'package:union_app/src/screens/widgets/app_bar/simple_app_bar.dart';

class CreateOrganizationPage extends StatelessWidget {
  const CreateOrganizationPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const CreateOrganizationPage());
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateOrganizationBloc>(
      create: (BuildContext context) =>
          CreateOrganizationBloc(),
      child: Scaffold(
        appBar: SimpleAppBar(title: 'Create organization'),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                CreateOrganizationForm(),
                CreateOrganizationChoices(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}