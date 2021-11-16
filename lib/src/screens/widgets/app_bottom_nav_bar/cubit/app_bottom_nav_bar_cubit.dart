import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_bottom_nav_bar_state.dart';

class AppBottomNavBarCubit extends Cubit<AppBottomNavBarState> {
  AppBottomNavBarCubit() : super(const AppBottomNavBarState());

  void navigate(int index) {
    emit(state.copyWith(index: index));
  }
}
