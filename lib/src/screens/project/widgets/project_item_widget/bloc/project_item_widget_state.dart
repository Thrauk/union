part of 'project_item_widget_bloc.dart';

@immutable
class ProjectItemWidgetState extends Equatable {
  const ProjectItemWidgetState(
      {this.ownerDisplayName = '', this.ownerPhotoUrl = '', this.ownerId = '', this.isExpanded = false});

  final String? ownerDisplayName;
  final String? ownerPhotoUrl;
  final String? ownerId;
  final bool? isExpanded;

  ProjectItemWidgetState copyWith({
    String? ownerDisplayName,
    String? ownerPhotoUrl,
    String? ownerId,
    bool? isExpanded,
  }) {
    return ProjectItemWidgetState(
      ownerDisplayName: ownerDisplayName ?? this.ownerDisplayName,
      ownerPhotoUrl: ownerPhotoUrl ?? this.ownerPhotoUrl,
      ownerId: ownerId ?? this.ownerId,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  @override
  List<Object?> get props => <Object?>[ownerDisplayName, ownerPhotoUrl, ownerId, isExpanded];
}
