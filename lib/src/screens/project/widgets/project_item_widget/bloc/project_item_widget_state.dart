part of 'project_item_widget_bloc.dart';

@immutable
class ProjectItemWidgetState extends Equatable {
  const ProjectItemWidgetState(
      {this.ownerDisplayName = '',
      this.ownerPhotoUrl = '',
      this.ownerId = '',
      this.isExpanded = false,
      this.isLiked = false,
      this.likesNr = 0});

  final String? ownerDisplayName;
  final String? ownerPhotoUrl;
  final String? ownerId;
  final bool? isExpanded;
  final bool isLiked;
  final int likesNr;

  ProjectItemWidgetState copyWith({
    String? ownerDisplayName,
    String? ownerPhotoUrl,
    String? ownerId,
    bool? isExpanded,
    bool? isLiked,
    int? likesNr,
  }) {
    return ProjectItemWidgetState(
      ownerDisplayName: ownerDisplayName ?? this.ownerDisplayName,
      ownerPhotoUrl: ownerPhotoUrl ?? this.ownerPhotoUrl,
      ownerId: ownerId ?? this.ownerId,
      isExpanded: isExpanded ?? this.isExpanded,
      isLiked: isLiked ?? this.isLiked,
      likesNr: likesNr ?? this.likesNr,
    );
  }

  @override
  List<Object?> get props => <Object?>[ownerDisplayName, ownerPhotoUrl, ownerId, isExpanded, isLiked, likesNr];
}
