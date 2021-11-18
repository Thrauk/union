import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_project_state.dart';

class CreateProjectCubit extends Cubit<CreateProjectState> {
  CreateProjectCubit() : super(CreateProjectInitial());
}
