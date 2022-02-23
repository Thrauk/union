part of 'create_organization_bloc.dart';

class CreateOrganizationState extends Equatable {
  const CreateOrganizationState({
    this.validators = const FormzValidatorCollection(validators: initialValidators),
    this.status = FormzStatus.pure,
    this.selectedCategory,
    this.categoryError,
    this.isPublic = true,
    this.selectedImage,
    this.submissionSuccess = false,
  });

  final FormzValidatorCollection validators;
  final FormzStatus status;
  final String? selectedCategory;
  final String? categoryError;
  final bool isPublic;
  final File? selectedImage;
  final bool submissionSuccess;

  CreateOrganizationState copyWith({
    FormzValidatorCollection? validators,
    FormzStatus? status,
    String? selectedCategory,
    String? categoryError,
    bool? isPublic,
    File? selectedImage,
    bool? submissionSuccess,
  }) {
    return CreateOrganizationState(
      validators: validators ?? this.validators,
      status: status ?? this.status,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categoryError: categoryError ?? this.categoryError,
      isPublic: isPublic ?? this.isPublic,
      selectedImage: selectedImage ?? this.selectedImage,
      submissionSuccess: submissionSuccess ?? this.submissionSuccess,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        validators,
        status,
        selectedCategory,
        isPublic,
        selectedImage,
        categoryError,
        submissionSuccess,
      ];
}
