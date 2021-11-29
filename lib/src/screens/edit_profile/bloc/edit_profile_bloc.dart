import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/storage/firebase_user_service/firebase_user_service.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc({required FirebaseUserServiceRepository userServiceRepository,
    required String uid})
      : _userServiceRepository = userServiceRepository,
        _uid = uid,
        super(const EditProfileState()) ;

  final FirebaseUserServiceRepository _userServiceRepository;
  final String _uid;




  @override
  Future<void> close() {
    return super.close();
  }

}
