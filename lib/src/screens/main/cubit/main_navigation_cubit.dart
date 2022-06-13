import 'package:bloc/bloc.dart';

part 'main_navigation_state.dart';

class MainNavigationCubit extends Cubit<MainNavigationState> {
  MainNavigationCubit() : super(const MainNavigationState());

  void onIndexChanged(int index) {
    emit(state.copyWith(index: index));
  }
}
