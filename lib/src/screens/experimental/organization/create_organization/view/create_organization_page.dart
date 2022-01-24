import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/experimental/organization/create_organization/bloc/create_organization_bloc.dart';
import 'package:union_app/src/screens/experimental/organization/create_organization/view/components/create_organization_choices.dart';
import 'package:union_app/src/screens/experimental/organization/create_organization/view/components/create_organization_form.dart';
import 'package:union_app/src/screens/widgets/app_bar/simple_app_bar.dart';

import 'components/create_organization_image.dart';
import 'components/create_organization_submit.dart';

class CreateOrganizationPage extends StatelessWidget {
  const CreateOrganizationPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const CreateOrganizationPage());
  }


  @override
  Widget build(BuildContext context) {
    final String uid = context.select((AppBloc bloc) => bloc.state.user.id);
    return BlocProvider<CreateOrganizationBloc>(
      create: (BuildContext context) =>
          CreateOrganizationBloc(uid: uid),
      child: BlocListener<CreateOrganizationBloc, CreateOrganizationState>(
        listener: (BuildContext context, CreateOrganizationState state) {
          if(state.submissionSuccess) {
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          appBar: const SimpleAppBar(title: 'Create organization'),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: const <Widget>[
                  CreateOrganizationImage(),
                  SizedBox(height: 10),
                  CreateOrganizationForm(),
                  CreateOrganizationChoices(),
                  SizedBox(height: 15),
                  CreateOrganizationSubmit(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
