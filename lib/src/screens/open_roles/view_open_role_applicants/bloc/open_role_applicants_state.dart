part of 'open_role_applicants_bloc.dart';

class OpenRoleApplicantsState extends Equatable {
  const OpenRoleApplicantsState({this.usersList = const <FullUser>[]});

  final List<FullUser> usersList;

  OpenRoleApplicantsState copyWith({List<FullUser>? usersList}) {
    return OpenRoleApplicantsState(usersList: usersList ?? this.usersList);
  }

  @override
  List<Object?> get props => [usersList];
}
