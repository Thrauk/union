import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:union_app/src/models/form_inputs/project_body.dart';
import 'package:union_app/src/models/form_inputs/project_title.dart';
import 'package:union_app/src/models/form_inputs/tag_name.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_repository.dart';

part 'create_project_event.dart';

part 'create_project_state.dart';

class CreateProjectBloc extends Bloc<CreateProjectEvent, CreateProjectState> {
  CreateProjectBloc(this._projectRepository) : super(const CreateProjectState()) {
    on<TitleChanged>(_titleChanged);
    on<DetailsChanged>(_detailsChanged);
    on<ShortDescriptionChanged>(_shortDescriptionChanged);
    on<AddTagButtonPressed>(_addTagPressed);
    on<RemoveTagButtonPressed>(_removeTagPressed);
    on<CreateButtonPressed>(_createButtonPressed);
  }

  final FirebaseProjectRepository _projectRepository;

  void _titleChanged(TitleChanged event, Emitter<CreateProjectState> emit) {
    final ProjectTitle title = ProjectTitle.dirty(event.value);
    emit(state.copyWith(title: title, status: Formz.validate([title, state.shortDescription, state.details])));
  }

  void _shortDescriptionChanged(ShortDescriptionChanged event, Emitter<CreateProjectState> emit) {
    final ProjectBody shortDescription = ProjectBody.dirty(event.value);
    emit(state.copyWith(
        shortDescription: shortDescription, status: Formz.validate([shortDescription, state.title, state.details])));
  }

  void _detailsChanged(DetailsChanged event, Emitter<CreateProjectState> emit) {
    final ProjectBody details = ProjectBody.dirty(event.value);
    emit(state.copyWith(details: details, status: Formz.validate([details, state.shortDescription, state.title])));
  }

  void _addTagPressed(AddTagButtonPressed event, Emitter<CreateProjectState> emit) {
    final TagName tag = TagName.dirty(event.value);
    if (!Formz.validate([tag]).isInvalid && !state.tagItems.contains(tag)) {
      final List<TagName> tagList = state.tagItems + [tag];
      emit(state.copyWith(tagItems: tagList, tag: tag, status: Formz.validate([tag])));
    } else {
      emit(state.copyWith(tag: tag, status: Formz.validate([tag])));
    }
  }

  // void _tagChanged(TagChanged event, Emitter<CreateProjectState> emit) {
  //   final TagName tag = TagName.dirty(event.value);
  //   // tag.list = state.tagItems;
  //   emit(state.copyWith(tag: tag, status: Formz.validate([tag])));
  // }

  void _removeTagPressed(RemoveTagButtonPressed event, Emitter<CreateProjectState> emit) {
    final List<TagName> tagList = List.from(state.tagItems);
    tagList.removeWhere((TagName element) => element.value == event.value);
    emit(state.copyWith(tagItems: tagList));
  }

  void _createButtonPressed(CreateButtonPressed event, Emitter<CreateProjectState> emit) {
    if (state.status.isValid) {
      final List<String> tags = state.tagItems.map((TagName e) => e.value).toList();
      try {
        final Project project = Project(
          title: state.title.value,
          shortDescription: state.shortDescription.value,
          details: state.details.value,
          tags: tags,
          ownerId: event.ownerId,
          timestamp: DateTime.now().microsecondsSinceEpoch,
        );
        _projectRepository.createProject(project);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
        print(state.status);
      } catch (_) {
        print(_);
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
