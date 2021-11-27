import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:union_app/src/models/form_inputs/project_body.dart';
import 'package:union_app/src/models/form_inputs/project_title.dart';
import 'package:union_app/src/models/form_inputs/tag_name.dart';
import 'package:union_app/src/screens/project/create_project/create_project.dart';

part 'create_project_state.dart';

class CreateProjectCubit extends Cubit<CreateProjectState> {
  CreateProjectCubit() : super(CreateProjectState());

  void titleChanged(String value) {
    final ProjectTitle title = ProjectTitle.dirty(value);
    emit(state.copyWith(title: title, status: Formz.validate([title])));
  }

  void shortDescriptionChanged(String value) {
    final ProjectBody shortDescription = ProjectBody.dirty(value);
    emit(state.copyWith(
        shortDescription: shortDescription,
        status: Formz.validate([shortDescription])));
  }

  void detailsChanged(String value) {
    final ProjectBody details = ProjectBody.dirty(value);
    emit(state.copyWith(details: details, status: Formz.validate([details])));
  }

  void addTagPressed(String value) {
    final TagName tag = TagName.dirty(value);
    if (Formz.validate([tag]).isValid) {
      final List<TagName> tagList = state.tagItems + [tag];
      emit(state.copyWith(tagItems: tagList));
    } else {
      emit(state.copyWith(status: FormzStatus.invalid));
    }
  }

  void removeTagPressed(String val) {
    print('e aicea');
    final List<TagName> tagList = state.tagItems;
    tagList.removeWhere((TagName element) => element.value == val);
    emit(state.copyWith(tagItems: tagList));
  }
}
