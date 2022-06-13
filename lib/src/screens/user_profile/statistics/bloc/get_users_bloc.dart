import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firebase_user/barrel.dart';

part 'get_users_state.dart';

part 'get_users_event.dart';

class GetUsersBloc extends Bloc<GetUsersEvent, GetUsersState> {
  GetUsersBloc(this._userRepository) : super(const GetUsersState()) {
    on<GetUsers>(_getFollowers);
  }

  final FirebaseUserRepository _userRepository;

  Future<FutureOr<void>> _getFollowers(GetUsers event, Emitter<GetUsersState> emit) async {
    try {
      final List<FullUser> followers = await _userRepository.queryUsersByUids(event.uids);
      emit(state.copyWith(users: followers, pageStatus: PageStatus.SUCCESSFUL));
    } catch (e) {
      emit(state.copyWith(pageStatus: PageStatus.FAILED));
    }
  }
}
