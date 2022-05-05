import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/organization/edit_organization/bloc/edit_organization_bloc.dart';
import 'package:union_app/src/screens/organization/edit_organization/view/components/components.dart';
import 'package:union_app/src/screens/widgets/widgets.dart';

import '../../data/organization_data.dart';

class EditOrganizationPage extends StatelessWidget {
  const EditOrganizationPage({Key? key, required this.organizationId}) : super(key: key);

  static Route<void> route(String organizationId) {
    return MaterialPageRoute<void>(
      builder: (_) => EditOrganizationPage(
        organizationId: organizationId,
      ),
    );
  }

  final String organizationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const SimpleAppBar(title: 'Edit organization'),
      body: BlocProvider<EditOrganizationBloc>(
        create: (BuildContext context) => EditOrganizationBloc(organizationId: organizationId)..add(LoadData()),
        child: _EditOrganizationPage(),
      ),
    );
  }
}

class _EditOrganizationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditOrganizationBloc, EditOrganizationState>(
      listener: (BuildContext context, EditOrganizationState state) {
        if(state.submissionSuccess) {
          Navigator.of(context).pop();
        }
      },
      builder: (BuildContext context, EditOrganizationState state) {
        return LoadingPlaceholder(
          isLoaded: !state.isLoading,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        context.read<EditOrganizationBloc>().add(ImageChanged());
                      },
                      child: ImageSelect(
                        placeholderImageUrl: state.organization.photoUrl,
                        image: state.selectedImage,
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    OrganizationEditForm(
                      organization: state.organization,
                      nameError: state.name.invalid,
                      locationError: state.location.invalid,
                      descriptionError: state.description.invalid,
                      onNameChanged: (String value) {
                        context.read<EditOrganizationBloc>().add(NameChanged(value: value));
                      },
                      onLocationChanged: (String value) {
                        context.read<EditOrganizationBloc>().add(LocationChanged(value: value));
                      },
                      onDescriptionChanged: (String value) {
                        context.read<EditOrganizationBloc>().add(DescriptionChanged(value: value));
                      },
                    ),
                    DropdownMenu(
                      selectedValue: state.selectedCategory,
                      items: organizationCategories,
                      onChanged: (String? value) {
                        context.read<EditOrganizationBloc>().add(CategoryChanged(value: value));
                      },
                      hint: 'Organization category',
                    ),
                    OrganizationTypeSwitch(
                      onChanged: (bool value) {
                        context.read<EditOrganizationBloc>().add(TypeChanged(value: value));
                      },
                      isPublic: state.isPublic,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: OrganizationEditButtons(
                    cancelOnPressed: () {
                      Navigator.of(context).pop();
                    },
                    saveOnPressed: () {
                      context.read<EditOrganizationBloc>().add(UpdateOrganization());
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
