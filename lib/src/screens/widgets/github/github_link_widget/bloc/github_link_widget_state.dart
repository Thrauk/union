part of 'github_link_widget_bloc.dart';

class GithubLinkWidgetState extends Equatable {
  const GithubLinkWidgetState({
    this.linkSuccess = false,
    this.isLinked = false,
    this.unlinkSuccess = false,
  });

  final bool linkSuccess;
  final bool isLinked;
  final bool unlinkSuccess;

  GithubLinkWidgetState copyWith({
    bool? linkSuccess,
    bool? isLinked,
    bool? unlinkSuccess,
  }) {
    return GithubLinkWidgetState(
      linkSuccess: linkSuccess ?? this.linkSuccess,
      isLinked: isLinked ?? this.isLinked,
      unlinkSuccess: unlinkSuccess ?? this.unlinkSuccess,
    );
  }

  @override
  List<Object> get props => <Object>[
        linkSuccess,
        isLinked,
        unlinkSuccess,
      ];
}
