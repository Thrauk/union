part of 'project_item_widget_bloc.dart';

@immutable
abstract class ProjectItemWidgetEvent {}

class GetDetails extends ProjectItemWidgetEvent {
  GetDetails(this.ownerId);

  final String ownerId;
}
class SetOwnerId extends ProjectItemWidgetEvent {
  SetOwnerId(this.ownerId);

  final String ownerId;
}

