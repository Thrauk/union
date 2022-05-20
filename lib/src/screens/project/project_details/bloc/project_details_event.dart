part of 'project_details_bloc.dart';

abstract class ProjectDetailsEvent {
  const ProjectDetailsEvent();
}

class GetOpenRoles extends ProjectDetailsEvent {
  GetOpenRoles(this.projectId);

  final String projectId;
}

class GetMembers extends ProjectDetailsEvent {
  GetMembers(this.projectId);

  final String projectId;
}

class GetLinkedRepository extends ProjectDetailsEvent {
  GetLinkedRepository(this.repositoryName);

  final String repositoryName;
}
