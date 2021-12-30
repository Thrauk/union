import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/storage/firebase_user/firebase_user.dart';

part 'element_event.dart';

part 'element_state.dart';

class ElementBloc extends Bloc<ElementEvent, ElementState> {
  ElementBloc({required String uid})
      : _uid = uid,
        super(const ElementState()) {
    on<Initialize>(_onInitialize);
    add(Initialize());
  }

  final String _uid;
  final FirebaseUserRepository _firebaseUserRepository = FirebaseUserRepository();

  Future<void> _onInitialize(Initialize event, Emitter<ElementState> emit) async {
    final FullUser user = await _firebaseUserRepository.getFullUserByUid(_uid);
    emit(state.copyWith(user: user));
  }
}
