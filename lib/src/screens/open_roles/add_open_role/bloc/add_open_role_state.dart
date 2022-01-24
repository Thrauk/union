// ignore_for_file: avoid_field_initializers_in_const_classes

part of 'add_open_role_bloc.dart';

class AddOpenRoleState extends Equatable {
  AddOpenRoleState(
      {this.title = const ShortText.pure(),
      this.specifications = const LongText.pure(),
      this.isPaid = false,
      this.isRemotePossible = false,
      this.country = const ShortText.pure(),
      this.location = const ShortText.pure(),
      this.city = const ShortText.pure(),
      this.selectedExperienceLevel = 'Not specified',
      this.status = FormzStatus.pure});

  final List<String> experienceLevels = <String>['Not specified', 'Junior', 'Middle', 'Experienced'];
  final ShortText title;
  final LongText specifications;
  final bool isPaid;
  final bool isRemotePossible;
  final ShortText country;
  final ShortText city;
  final ShortText location;
  final FormzStatus status;
  final String selectedExperienceLevel;

  AddOpenRoleState copyWith(
      {ShortText? title,
      LongText? specifications,
      String? selectedExperienceLevel,
      bool? isPaid,
      bool? isRemotePossible,
      ShortText? country,
      ShortText? city,
      FormzStatus? status}) {
    return AddOpenRoleState(
      title: title ?? this.title,
      specifications: specifications ?? this.specifications,
      selectedExperienceLevel: selectedExperienceLevel ?? this.selectedExperienceLevel,
      isPaid: isPaid ?? this.isPaid,
      isRemotePossible: isRemotePossible ?? this.isRemotePossible,
      country: country ?? this.country,
      city: city ?? this.city,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [title, specifications, isPaid, city, country, isRemotePossible, status, selectedExperienceLevel];
}
