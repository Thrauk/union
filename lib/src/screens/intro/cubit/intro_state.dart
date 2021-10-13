part of 'intro_cubit.dart';

@immutable
class IntroState extends Equatable {
  const IntroState({
    this.currentPage = 0,
    required this.maxPageNumber,
  });

  final int currentPage;
  final int maxPageNumber;

  @override
  List<Object> get props => <Object>[currentPage];

  IntroState copyWith({
    int? currentPage,
  }) {
    return IntroState(
      currentPage: currentPage ?? this.currentPage,
      maxPageNumber: maxPageNumber,
    );
  }
}
