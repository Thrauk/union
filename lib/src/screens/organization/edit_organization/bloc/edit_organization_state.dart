part of 'edit_organization_bloc.dart';

class EditOrganizationState extends Equatable {
  const EditOrganizationState({
    this.name = const ShortTextValidator.pure(),
    this.location = const ShortTextValidator.pure(),
    this.description = const LongTextValidator.pure(),
    this.selectedCategory,
    this.isPublic = false,
    this.organization = Organization.empty,
    this.isLoading = true,
    this.selectedImage,
    this.status = FormzStatus.pure,
    this.submissionSuccess = false,
  });

  final ShortTextValidator name;
  final ShortTextValidator location;
  final LongTextValidator description;
  final String? selectedCategory;
  final bool isPublic;
  final File? selectedImage;
  final Organization organization;
  final bool isLoading;
  final FormzStatus status;
  final bool submissionSuccess;

  EditOrganizationState copyWith({
    ShortTextValidator? name,
    ShortTextValidator? location,
    LongTextValidator? description,
    String? selectedCategory,
    bool? isPublic,
    File? selectedImage,
    Organization? organization,
    bool? isLoading,
    FormzStatus? status,
    bool? submissionSuccess,
  }) {
    return EditOrganizationState(
      name: name ?? this.name,
      location: location ?? this.location,
      description: description ?? this.description,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isPublic: isPublic ?? this.isPublic,
      selectedImage: selectedImage ?? this.selectedImage,
      organization: organization ?? this.organization,
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      submissionSuccess: submissionSuccess ?? this.submissionSuccess,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        name,
        location,
        description,
        selectedCategory,
        isPublic,
        selectedImage,
        organization,
        isLoading,
        status,
        submissionSuccess,
      ];
}
