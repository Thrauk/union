part of 'project_list_bloc.dart';

abstract class ProjectListEvent extends Equatable {
  const ProjectListEvent();
  @override
  List<Object?> get props => <Object?>[];
}

class Initialize extends ProjectListEvent {}
