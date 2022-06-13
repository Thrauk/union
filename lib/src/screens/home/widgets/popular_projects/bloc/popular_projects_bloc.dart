import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_app/src/models/project/barrel.dart';

part 'popular_projects_event.dart';

part 'popular_projects_state.dart';

class PopularProjectsBloc extends Bloc<PopularProjectsEvent, PopularProjectsState> {
  PopularProjectsBloc() : super(const PopularProjectsState()) {
    on<GetPopularProjects>(_getPopularProjects);
  }

  FutureOr<void> _getPopularProjects(GetPopularProjects event, Emitter<PopularProjectsState> emit) {}
}
