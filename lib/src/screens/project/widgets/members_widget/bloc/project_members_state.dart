part of 'project_members_bloc.dart';

class ProjectMembersState extends Equatable {
  const ProjectMembersState({this.users = const <FullUser>[]});

  final List<FullUser> users;

  ProjectMembersState copyWith({List<FullUser>? users}) {
    return ProjectMembersState(users: users ?? this.users);
}

  @override
  List<Object?> get props => [users];
}
