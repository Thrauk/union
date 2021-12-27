part of 'add_open_role_bloc.dart';

class AddOpenRoleState extends Equatable {
  const AddOpenRoleState(
      {this.title = const ShortText.pure(),
      this.specifications = const LongText.pure(),
      this.isPaid = false,
      this.isRemotePossible = false,
      this.country = const ShortText.pure(),
      this.location = const ShortText.pure(),
      this.city = const ShortText.pure(),
      this.status = FormzStatus.pure});

  final ShortText title;
  final LongText specifications;
  final bool isPaid;
  final bool isRemotePossible;
  final ShortText country;
  final ShortText city;
  final ShortText location;
  final FormzStatus status;

  AddOpenRoleState copyWith(
      {ShortText? title,
      LongText? specifications,
      bool? isPaid,
      bool? isRemotePossible,
      ShortText? country,
      ShortText? city,
      FormzStatus? status}) {
    return AddOpenRoleState(
      title: title ?? this.title,
      specifications: specifications ?? this.specifications,
      isPaid: isPaid ?? this.isPaid,
      isRemotePossible: isRemotePossible ?? this.isRemotePossible,
      country: country ?? this.country,
      city: city ?? this.city,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [title, specifications, isPaid, city, country];
}
