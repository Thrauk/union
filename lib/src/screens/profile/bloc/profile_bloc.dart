import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/storage/storage.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required FirebaseUserServiceRepository userServiceRepository,
  required String uid})
      : _userServiceRepository = userServiceRepository,
        _uid = uid,
        super(const ProfileState()) {
    on<LoadProfile>(_onLoadProfile);
    on<ProfileChanged>(_onProfileChanged);
    _userSubscription = _userServiceRepository.fullUser(_uid).listen(
        (FullUser user) => add(ProfileChanged(user)),
    );
  }

  final FirebaseUserServiceRepository _userServiceRepository;
  final String _uid;
  late final StreamSubscription<FullUser> _userSubscription;

  void _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) {
    emit(state);
  }

  void _onProfileChanged(ProfileChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(fullUser: event.user));
  }


  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

}
