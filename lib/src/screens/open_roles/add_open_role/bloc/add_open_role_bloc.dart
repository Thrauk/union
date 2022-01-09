import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:union_app/src/models/form_inputs/form_inputs.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/storage/firebase_project_repository/firebase_project_open_role_repository.dart';

part 'add_open_role_event.dart';

part 'add_open_role_state.dart';

class AddOpenRoleBloc extends Bloc<AddOpenRoleEvent, AddOpenRoleState> {
  AddOpenRoleBloc(this._openRoleRepository) : super(const AddOpenRoleState()) {
    on<TitleChanged>(_titleChanged);
    on<CityChanged>(_cityChanged);
    on<CountryChanged>(_countryChanged);
    on<SpecificationsChanged>(_specificationsChanged);
    on<IsPaidChanged>(_isPaidChanged);
    on<PostButtonPressed>(_postButtonPressed);
    on<IsRemotePossibleChanged>(_isRemotePossibleChanged);
  }

  final FirebaseProjectOpenRoleRepository _openRoleRepository;

  void _titleChanged(TitleChanged event, Emitter<AddOpenRoleState> emit) {
    final ShortText title = ShortText.dirty(event.value);
    emit(state.copyWith(
        title: title,
        status: Formz.validate(
            [title, state.specifications, state.country, state.city])));
    print('_titleChanged ${state.status}');
  }

  void _cityChanged(CityChanged event, Emitter<AddOpenRoleState> emit) {
    final ShortText city = ShortText.dirty(event.value);
    emit(state.copyWith(
        city: city,
        status: Formz.validate(
            [city, state.title, state.country, state.specifications])));
    print('_cityChanged ${state.status}');
  }

  void _countryChanged(CountryChanged event, Emitter<AddOpenRoleState> emit) {
    final ShortText country = ShortText.dirty(event.value);
    emit(state.copyWith(
        country: country,
        status: Formz.validate(
            [country, state.title, state.specifications, state.city])));
    print('_countryChanged ${state.status}');


  }

  void _specificationsChanged(
      SpecificationsChanged event, Emitter<AddOpenRoleState> emit) {
    final LongText specifications = LongText.dirty(event.value);
    emit(state.copyWith(
        specifications: specifications,
        status: Formz.validate(
            [specifications, state.title, state.country, state.city])));
    print('_specificationsChanged ${state.status}');

  }

  void _isPaidChanged(IsPaidChanged event, Emitter<AddOpenRoleState> emit) {
    emit(state.copyWith(isPaid: event.value));
  }

  void _isRemotePossibleChanged(
      IsRemotePossibleChanged event, Emitter<AddOpenRoleState> emit) {
    emit(state.copyWith(isRemotePossible: event.value));
  }

  void _postButtonPressed(
      PostButtonPressed event, Emitter<AddOpenRoleState> emit) {
    try {
      if (state.status == FormzStatus.valid) {
        print(event.projectId);
        final ProjectOpenRole projectOpenRole = ProjectOpenRole(
            projectId: event.projectId,
            isRemotePossible: state.isRemotePossible,
            isPaid: state.isPaid,
            title: state.title.value,
            location: '${state.city.value} ${state.country.value}',
            specifications: state.specifications.value,
            timestamp: DateTime.now().microsecondsSinceEpoch);
        _openRoleRepository.createProjectOpenRole(projectOpenRole);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } else {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    } catch (e) {
      print('_postButtonPressed $e');
    }
  }
}
