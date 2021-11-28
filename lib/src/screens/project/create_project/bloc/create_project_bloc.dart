import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:union_app/src/models/form_inputs/project_body.dart';
import 'package:union_app/src/models/form_inputs/project_title.dart';
import 'package:union_app/src/models/form_inputs/tag_name.dart';

part 'create_project_event.dart';

part 'create_project_state.dart';

class CreateProjectBloc extends Bloc<CreateProjectEvent, CreateProjectState> {
  CreateProjectBloc() : super(const CreateProjectState()) {
    on<TitleChanged>(_titleChanged);
    on<DetailsChanged>(_detailsChanged);
    on<ShortDescriptionChanged>(_shortDescriptionChanged);
    // on<TagChanged>(_tagChanged);
    on<AddTagButtonPressed>(_addTagPressed);
    on<RemoveTagButtonPressed>(_removeTagPressed);
  }

  void _titleChanged(TitleChanged event, Emitter<CreateProjectState> emit) {
    final ProjectTitle title = ProjectTitle.dirty(event.value);
    emit(state.copyWith(title: title, status: Formz.validate([title])));
  }

  void _shortDescriptionChanged(
      ShortDescriptionChanged event, Emitter<CreateProjectState> emit) {
    final ProjectBody shortDescription = ProjectBody.dirty(event.value);
    emit(state.copyWith(
        shortDescription: shortDescription,
        status: Formz.validate([shortDescription])));
  }

  void _detailsChanged(DetailsChanged event, Emitter<CreateProjectState> emit) {
    final ProjectBody details = ProjectBody.dirty(event.value);
    emit(state.copyWith(details: details, status: Formz.validate([details])));
  }

  void _addTagPressed(
      AddTagButtonPressed event, Emitter<CreateProjectState> emit) {
    final TagName tag = TagName.dirty(event.value);
    if (!Formz.validate([tag]).isInvalid && !state.tagItems.contains(tag)) {
      final List<TagName> tagList = state.tagItems + [tag];
      emit(state.copyWith(
          tagItems: tagList, tag: tag, status: Formz.validate([tag])));
    } else {
      emit(state.copyWith(tag: tag, status: Formz.validate([tag])));
    }
  }

  // void _tagChanged(TagChanged event, Emitter<CreateProjectState> emit) {
  //   final TagName tag = TagName.dirty(event.value);
  //   // tag.list = state.tagItems;
  //   emit(state.copyWith(tag: tag, status: Formz.validate([tag])));
  // }

  void _removeTagPressed(
      RemoveTagButtonPressed event, Emitter<CreateProjectState> emit) {
    print('e aicea');
    print(state.tagItems.toList());
    final List<TagName> tagList = List.from(state.tagItems);
    tagList.removeWhere((TagName element) => element.value == event.value);
    emit(state.copyWith(tagItems: tagList));
    print(state.tagItems.toList());
  }
}
