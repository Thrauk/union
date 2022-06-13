part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  const EditProfileState(
      {this.fullUser = FullUser.empty,
      this.displayName = const DisplayName.pure(),
      this.jobTitle = const ShortText.pure(),
      this.location = const ShortText.pure(),
      this.description = const LongText.pure(),
      this.status = FormzStatus.pure,
      this.profileLoaded = false,
      this.photoUrl,
      this.isOpenForCollaborations = false});

  final FullUser fullUser;
  final DisplayName displayName;
  final ShortText jobTitle;
  final ShortText location;
  final LongText description;
  final FormzStatus status;
  final bool profileLoaded;
  final String? photoUrl;
  final bool isOpenForCollaborations;

  EditProfileState copyWith({
    FullUser? fullUser,
    DisplayName? displayName,
    ShortText? jobTitle,
    ShortText? location,
    LongText? description,
    FormzStatus? status,
    bool? profileLoaded,
    String? photoUrl,
    bool? isOpenForCollaborations,
  }) {
    return EditProfileState(
      fullUser: fullUser ?? this.fullUser,
      displayName: displayName ?? this.displayName,
      jobTitle: jobTitle ?? this.jobTitle,
      location: location ?? this.location,
      description: description ?? this.description,
      status: status ?? this.status,
      profileLoaded: profileLoaded ?? this.profileLoaded,
      photoUrl: photoUrl ?? this.photoUrl,
      isOpenForCollaborations: isOpenForCollaborations ?? this.isOpenForCollaborations,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        fullUser,
        displayName,
        jobTitle,
        location,
        description,
        status,
        profileLoaded,
        photoUrl,
        isOpenForCollaborations
      ];
}
