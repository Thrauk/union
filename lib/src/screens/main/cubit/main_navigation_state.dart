part of 'main_navigation_cubit.dart';

class MainNavigationState {
  const MainNavigationState({this.index = 0});

  final int index;

  MainNavigationState copyWith({int? index}) {
    return MainNavigationState(
      index: index ?? this.index,
    );
  }

  List<Object?> get props => <int>[index];
}
