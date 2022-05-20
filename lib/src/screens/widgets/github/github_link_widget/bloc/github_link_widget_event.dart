part of 'github_link_widget_bloc.dart';


class GithubLinkWidgetEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class Initialize extends GithubLinkWidgetEvent {}

class LinkPressed extends GithubLinkWidgetEvent {}

class UnlinkPressed extends GithubLinkWidgetEvent {}

class LinkFailed extends GithubLinkWidgetEvent {}

class UnlinkFailed extends GithubLinkWidgetEvent {}
class LinkSuccess extends GithubLinkWidgetEvent {}

class UnlinkSuccess extends GithubLinkWidgetEvent {}

