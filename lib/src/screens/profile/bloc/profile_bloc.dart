import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/authentication/auth.dart';
import 'package:union_app/src/repository/storage/storage.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(
      {required FirebaseUserRepository userRepository,
      required String uid,
      required AuthenticationRepository firebaseAuthRepository})
      : _userRepository = userRepository,
        _uid = uid,
        _authRepository = firebaseAuthRepository,
        super(const ProfileState()) {
    on<LoadProfile>(_onLoadProfile);
    on<OwnedProfile>(_onOwnedProfile);
    on<ProfileChanged>(_onProfileChanged);
    on<FollowOrUnfollow>(_onFollowOrUnfollow);
    on<SelectedProjectsPosts>(_onSelectedProjectsPosts);
    on<SelectedArticlesPosts>(_onSelectedArticlesPosts);

    if (_authRepository.currentUser.id == _uid) {
      add(OwnedProfile());
    }
    _userSubscription = _userRepository.fullUser(_uid).listen(
          (FullUser user) => add(ProfileChanged(user)),
        );
  }

  final FirebaseUserRepository _userRepository;
  final AuthenticationRepository _authRepository;
  final String _uid;
  late final StreamSubscription<FullUser> _userSubscription;

  void _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) {
    if (state.fullUser.followers != null && state.fullUser.followers!.contains(_authRepository.currentUser.id)) {
      emit(state.copyWith(followsUser: true));
    }
    emit(state.copyWith(selectedPosts: SelectedPosts.project));
  }

  void _onProfileChanged(ProfileChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(fullUser: event.user));
    add(LoadProfile());
  }

  void _onOwnedProfile(OwnedProfile event, Emitter<ProfileState> emit) {
    emit(state.copyWith(ownProfile: true));
  }

  void _onFollowOrUnfollow(FollowOrUnfollow event, Emitter<ProfileState> emit) {
    if(state.followsUser == true) {
      _userRepository.followService.unfollowUser(_authRepository.currentUser.id, _uid);
    } else {
      _userRepository.followService.followUser(_authRepository.currentUser.id, _uid);
    }
    emit(state.copyWith(followsUser: !state.followsUser));
  }

  void _onSelectedProjectsPosts(SelectedProjectsPosts event, Emitter<ProfileState> emit) {
    emit(state.copyWith(selectedPosts: SelectedPosts.project));
  }

  void _onSelectedArticlesPosts(SelectedArticlesPosts event, Emitter<ProfileState> emit) {
    emit(state.copyWith(selectedPosts: SelectedPosts.article));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
