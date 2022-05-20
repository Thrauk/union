import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';
import 'package:union_app/src/screens/app/bloc/app_bloc.dart';
import 'package:union_app/src/screens/user_profile/edit_profile/edit_profile.dart';
import 'package:union_app/src/screens/user_profile/edit_profile/widgets/toggle/open_for_collaboration_switch.dart';
import 'package:union_app/src/screens/widgets/app_bar/simple_app_bar.dart';
import 'package:union_app/src/screens/widgets/github/github_link_widget/github_link_widget.dart';
import 'package:union_app/src/theme.dart';


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
      appBar: const SimpleAppBar(title: 'Edit Profile'),
      body: BlocProvider<EditProfileBloc>(
        create: (_) => EditProfileBloc(
          uid: uid,
          userServiceRepository: FirebaseUserRepository(),
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
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          context.read<EditProfileBloc>().add(SelectImage());
                        },
                        child: EditableAvatarWidget(
                          photoUrl: state.photoUrl,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const DisplayNameInputWidget(),
                      const SizedBox(height: 15),
                      const JobTitleInputWidget(),
                      const SizedBox(height: 15),
                      const LocationInputWidget(),
                      const SizedBox(height: 15),
                      const DescriptionInputWidget(),
                      OpenForCollaborationSwitch(
                        value: state.isOpenForCollaborations,
                        onChange: (bool switchValue) {
                          context.read<EditProfileBloc>().add(IsOpenForCollaborationChanged(switchValue));
                        },
                      ),
                      const Align(alignment: Alignment.centerLeft, child: Text('Resume', style: AppStyles.textStyleHeading1)),
                      FileUploader(userId: state.fullUser.id),
                      const SizedBox(height: 15),
                      const GithubLinkWidget(),
                      const SizedBox(height: 15),

                      const SubmitButtonWidget(),
                    ],
                  )
                : Container();
          },
        ),
      ),
    );
  }
}
