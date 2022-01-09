import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:union_app/src/models/form_inputs/project_body.dart';
import 'package:union_app/src/models/form_inputs/project_title.dart';
import 'package:union_app/src/models/form_inputs/tag_name.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_repository.dart';

part 'edit_project_event.dart';

part 'edit_project_state.dart';

class EditProjectBloc extends Bloc<EditProjectEvent, EditProjectState> {
  EditProjectBloc(Project project, this._projectRepository) : super(EditProjectState(project: project)) {
    on<TitleChanged>(_titleChanged);
    on<DetailsChanged>(_detailsChanged);
    on<ShortDescriptionChanged>(_shortDescriptionChanged);
    on<AddTagButtonPressed>(_addTagPressed);
    on<RemoveTagButtonPressed>(_removeTagPressed);
    on<SaveButtonPressed>(_saveButtonPressed);
    on<TagChanged>(_tagChanged);
  }

  final FirebaseProjectRepository _projectRepository;

  void _titleChanged(TitleChanged event, Emitter<EditProjectState> emit) {
    final ProjectTitle title = ProjectTitle.dirty(event.value);
    emit(state.copyWith(project: state.project.copyWith(title: event.value), status: Formz.validate([title])));
  }

  void _shortDescriptionChanged(ShortDescriptionChanged event, Emitter<EditProjectState> emit) {
    final ProjectBody shortDescription = ProjectBody.dirty(event.value);
    emit(state.copyWith(
        project: state.project.copyWith(shortDescription: event.value), status: Formz.validate([shortDescription])));
  }

  void _detailsChanged(DetailsChanged event, Emitter<EditProjectState> emit) {
    final ProjectBody details = ProjectBody.dirty(event.value);
    emit(state.copyWith(project: state.project.copyWith(details: event.value), status: Formz.validate([details])));
  }

  void _addTagPressed(AddTagButtonPressed event, Emitter<EditProjectState> emit) {
    final TagName tag = TagName.dirty(event.value);
    if (!Formz.validate([tag]).isInvalid && !state.project.tags!.contains(tag.value)) {
      final List tagList = state.project.tags != null ? state.project.tags! + [tag.value] : [tag.value];
      emit(state.copyWith(project: state.project.copyWith(tags: tagList), tag: tag, status: Formz.validate([tag])));
    } else {
      emit(state.copyWith(tag: tag, status: Formz.validate([tag])));
    }
  }

  void _tagChanged(TagChanged event, Emitter<EditProjectState> emit) {
    final TagName tag = TagName.dirty(event.value);
    emit(state.copyWith(tag: tag, status: Formz.validate([tag])));
  }

  void _removeTagPressed(RemoveTagButtonPressed event, Emitter<EditProjectState> emit) {
    final List tagList = state.project.tags != null ? List.from(state.project.tags!.toList()) : List.from([]);
    tagList.removeWhere((element) => element == event.value);
    emit(state.copyWith(project: state.project.copyWith(tags: tagList), status: FormzStatus.valid));
  }

  void _saveButtonPressed(SaveButtonPressed event, Emitter<EditProjectState> emit) {
    if (state.status.isValid) {
      try {
        _projectRepository.updateProject(state.project);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        // TODO display on screen it's submission failure
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    } else if (state.status.isPure) {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }
  }
}
