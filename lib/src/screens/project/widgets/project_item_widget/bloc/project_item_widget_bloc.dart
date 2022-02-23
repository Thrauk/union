import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';

part 'project_item_widget_event.dart';

part 'project_item_widget_state.dart';

class ProjectItemWidgetBloc
    extends Bloc<ProjectItemWidgetEvent, ProjectItemWidgetState> {
  ProjectItemWidgetBloc(this._projectRepository) : super(const ProjectItemWidgetState()) {
    on<GetDetails>(_getDetails);
    on<SetOwnerId>(_setOwnerId);
    on<OnTextPressed>(_modifyIsExpanded);
  }

  final FirebaseProjectRepository _projectRepository;

  void _getDetails(GetDetails event, Emitter<ProjectItemWidgetState> emit) async {
    final Map<String, String>? mapResult = await _projectRepository.getProjectUserDetails(event.ownerId);
    emit(state.copyWith(ownerDisplayName: mapResult!['owner_name'], ownerPhotoUrl: mapResult['owner_photo']));
  }

  void _setOwnerId(SetOwnerId event, Emitter<ProjectItemWidgetState> emit) {
    emit(state.copyWith(ownerId: event.ownerId));
  }

  Future<void> _modifyIsExpanded(OnTextPressed event, Emitter<ProjectItemWidgetState> emit) async {
    final bool isExpanded = state.isExpanded == true ? false : true;
    emit(state.copyWith(isExpanded: isExpanded));
  }

}
