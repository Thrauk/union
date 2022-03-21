import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';

part 'project_item_widget_event.dart';

part 'project_item_widget_state.dart';

class ProjectItemWidgetBloc extends Bloc<ProjectItemWidgetEvent, ProjectItemWidgetState> {
  ProjectItemWidgetBloc(this._projectRepository) : super(const ProjectItemWidgetState()) {
    on<GetDetails>(_getDetails);
    on<SetOwnerId>(_setOwnerId);
    on<OnTextPressed>(_modifyIsExpanded);
    on<LikePressed>(_likePressed);
    on<GetLikesNr>(_getLikesNr);
  }

  final FirebaseProjectRepository _projectRepository;

  Future<void> _getDetails(GetDetails event, Emitter<ProjectItemWidgetState> emit) async {
    final Map<String, String>? mapResult = await _projectRepository.getProjectUserDetails(event.ownerId);
    final bool isLiked = await _projectRepository.verifyIfUserLiked(event.projectId, event.loggedUid);
    emit(state.copyWith(ownerDisplayName: mapResult!['owner_name'], ownerPhotoUrl: mapResult['owner_photo'], isLiked: isLiked));
  }

  void _setOwnerId(SetOwnerId event, Emitter<ProjectItemWidgetState> emit) {
    emit(state.copyWith(ownerId: event.ownerId));
  }

  Future<void> _modifyIsExpanded(OnTextPressed event, Emitter<ProjectItemWidgetState> emit) async {
    final bool isExpanded = state.isExpanded == false;
    emit(state.copyWith(isExpanded: isExpanded));
  }

  Future<void> _likePressed(LikePressed event, Emitter<ProjectItemWidgetState> emit) async {
    if (state.isLiked == true) {
      _projectRepository.removeLikeFromProject(event.project.id, event.uid);
      emit(state.copyWith(isLiked: false, likesNr: state.likesNr - 1));
    } else {
      _projectRepository.addLikeToProject(event.project.id, event.uid);
      emit(state.copyWith(isLiked: true, likesNr: state.likesNr + 1));
    }
  }

  Future<void> _getLikesNr(GetLikesNr event, Emitter<ProjectItemWidgetState> emit) async {
    final int likes = await _projectRepository.getLikesNumber(event.projectId);
    emit(state.copyWith(likesNr: likes));
  }
}
