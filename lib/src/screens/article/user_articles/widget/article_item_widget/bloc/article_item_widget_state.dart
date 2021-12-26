part of 'article_item_widget_bloc.dart';

@immutable
class ArticleItemWidgetState extends Equatable {
  const ArticleItemWidgetState(
      {this.ownerDisplayName = '', this.ownerPhotoUrl = '', this.ownerId = '', this.isExpanded = false});

  final String? ownerDisplayName;
  final String? ownerPhotoUrl;
  final String? ownerId;
  final bool? isExpanded;

  ArticleItemWidgetState copyWith({
    String? ownerDisplayName,
    String? ownerPhotoUrl,
    String? ownerId,
    bool? isExpanded,
  }) {
    return ArticleItemWidgetState(
      ownerDisplayName: ownerDisplayName ?? this.ownerDisplayName,
      ownerPhotoUrl: ownerPhotoUrl ?? this.ownerPhotoUrl,
      ownerId: ownerId ?? this.ownerId,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  @override
  List<Object?> get props => <Object?>[ownerDisplayName, ownerPhotoUrl, ownerId, isExpanded];
}

