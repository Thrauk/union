import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:union_app/src/repository/storage/firebase_user_service/firebase_user_service.dart';
import 'package:union_app/src/screens/app/bloc/app_bloc.dart';
import 'package:union_app/src/screens/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:union_app/src/screens/edit_profile/widgets/buttons/buttons.dart';
import 'package:union_app/src/screens/edit_profile/widgets/editable_avatar.dart';
import 'package:union_app/src/screens/edit_profile/widgets/form_fields/form_fields.dart';
import 'package:union_app/src/screens/home/widgets/widgets.dart';
import 'package:union_app/src/screens/widgets/app_drawer.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const EditProfilePage());
  }

  static Page page() => const MaterialPage<void>(child: EditProfilePage());

  @override
  Widget build(BuildContext context) {
    final String uid = context.select((AppBloc bloc) => bloc.state.user.id);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: const Center(child: Text('Edit profile'))),
      body: BlocProvider<EditProfileBloc>(
        create: (_) => EditProfileBloc(
          uid: uid,
          userServiceRepository: FirebaseUserServiceRepository(),
        ),
        child: BlocListener<EditProfileBloc, EditProfileState>(
          listener: (BuildContext context, EditProfileState state) {
            if (state.status.isSubmissionFailure) {

            } else if (state.status.isSubmissionSuccess) {
              Navigator.of(context).pop<void>();
            }
          },
          child: const _EditProfilePage(),
        ),
      ),
    );
  }
}

class _EditProfilePage extends StatelessWidget {
  const _EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<EditProfileBloc, EditProfileState>(
          builder: (BuildContext context, EditProfileState state) {
            return state.profileLoaded == true
                  ? Column(
                      children:  <Widget>[
                        GestureDetector(
                          onTap: () {
                            context.read<EditProfileBloc>().add(SelectImage());
                          },
                          child: EditableAvatarWidget(
                            photoUrl: state.photoUrl,
                          ),
                        ),
                        SizedBox(height: 15),
                        DisplayNameInputWidget(),
                        SizedBox(height: 15),
                        JobTitleInputWidget(),
                        SizedBox(height: 15),
                        LocationInputWidget(),
                        SizedBox(height: 15),
                        DescriptionInputWidget(),
                        SizedBox(height: 15),
                        SubmitButtonWidget(),
                      ],
                    )
                  : Container();
          },
        ),
      ),
    );
  }
}
