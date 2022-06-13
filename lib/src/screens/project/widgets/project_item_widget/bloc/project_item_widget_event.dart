part of 'project_item_widget_bloc.dart';

@immutable
abstract class ProjectItemWidgetEvent {}

class GetDetails extends ProjectItemWidgetEvent {
  GetDetails(this.ownerId, this.projectId, this.loggedUid);

  final String ownerId;
  final String projectId;
  final String loggedUid;
}

class SetOwnerId extends ProjectItemWidgetEvent {
  SetOwnerId(this.ownerId);

  final String ownerId;
}

class OnTextPressed extends ProjectItemWidgetEvent {
  OnTextPressed();
}

class LikePressed extends ProjectItemWidgetEvent {
  LikePressed(this.uid, this.project);

  final String uid;
  final Project project;
}

class GetLikesNr extends ProjectItemWidgetEvent {
  GetLikesNr(this.projectId);

  final String projectId;
}
