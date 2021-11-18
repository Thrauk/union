import 'package:equatable/equatable.dart';

class Project extends Equatable {
  const Project(this.title, this.shortDescription, this.details, this.tags);

  final String? title;
  final String? shortDescription;
  final String? details;
  final List<String>? tags;

  @override
  List<Object?> get props => [title, shortDescription, details, tags];
}
