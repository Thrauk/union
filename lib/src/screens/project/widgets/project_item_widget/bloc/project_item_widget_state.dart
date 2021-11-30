part of 'project_item_widget_bloc.dart';

@immutable
class ProjectItemWidgetState extends Equatable {
  const ProjectItemWidgetState(
      {this.ownerDisplayName = '', this.ownerPhotoUrl = '', this.ownerId = ''});

  final String? ownerDisplayName;
  final String? ownerPhotoUrl;
  final String? ownerId;

  ProjectItemWidgetState copyWith({
    String? ownerDisplayName,
    String? ownerPhotoUrl,
    String? ownerId,
  }) {
    return ProjectItemWidgetState(
      ownerDisplayName: ownerDisplayName ?? this.ownerDisplayName,
      ownerPhotoUrl: ownerPhotoUrl ?? this.ownerPhotoUrl,
      ownerId: ownerId ?? this.ownerId,
    );
  }

  @override
  List<Object?> get props => <String?>[ownerDisplayName, ownerPhotoUrl, ownerId];
}
