part of 'app_bottom_nav_bar_cubit.dart';

@immutable
class AppBottomNavBarState {
  const AppBottomNavBarState({this.index = 0});

  final int index;

  AppBottomNavBarState copyWith({int? index}) {
    return AppBottomNavBarState(
      index: index ?? this.index,
    );
  }

  List<Object?> get props => <int>[index];
}

