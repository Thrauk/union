import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'view_user_applications_event.dart';
part 'view_user_applications_state.dart';

class ViewUserApplicationsBloc extends Bloc<ViewUserApplicationsEvent, ViewUserApplicationsState> {
  ViewUserApplicationsBloc() : super(ViewUserApplicationsInitial()) {
    on<ViewUserApplicationsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
