import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';

part 'apply_to_open_role_event.dart';

part 'apply_to_open_role_state.dart';

class ApplyToOpenRoleBloc extends Bloc<ApplyToOpenRoleEvent, ApplyToOpenRoleState> {
  ApplyToOpenRoleBloc(this._firebaseProjectOpenRoleRepository) : super(const ApplyToOpenRoleState()) {
    on<ApplyButtonPressed>(_applyButtonPressed);
    on<NoticeChanged>(_noticeChanged);
    on<ChooseFilePressed>(_chooseFilePressed);
    on<VerifyIfUserHasCv>(_getUserCvIfPresent);
  }

  final FirebaseProjectOpenRoleRepository _firebaseProjectOpenRoleRepository;

  Future<FutureOr<void>> _applyButtonPressed(ApplyButtonPressed event, Emitter<ApplyToOpenRoleState> emit) async {
    try {
      await _firebaseProjectOpenRoleRepository.addUidToOpenRole(
          ProjectOpenRoleApplication(uid: event.uid, notice: state.notice), event.openRoleId,
          filePickerResult: state.filePickerResult, userCVPath: state.cvUrl);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      print('_applyButtonPressed $e');
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  FutureOr<void> _noticeChanged(NoticeChanged event, Emitter<ApplyToOpenRoleState> emit) {
    final LongText notice = LongText.dirty(event.value);
    emit(state.copyWith(notice: event.value, status: Formz.validate([notice])));
  }

  Future<FutureOr<void>> _chooseFilePressed(ChooseFilePressed event, Emitter<ApplyToOpenRoleState> emit) async {
    final FilePickerResult? filePicked = await FilePicker.platform.pickFiles(type : FileType.custom, allowMultiple: false, withData: true, allowedExtensions: ['pdf']);
    if (filePicked != null)
      emit(state.copyWith(filePickerResult: filePicked));
  }

  Future<FutureOr<void>> _getUserCvIfPresent(VerifyIfUserHasCv event, Emitter<ApplyToOpenRoleState> emit) async {
    final String? maybeUserCvUrl = await _firebaseProjectOpenRoleRepository.getUserCvIfPresent(event.uid);
    emit(state.copyWith(cvAlreadyAdded: maybeUserCvUrl != null, cvUrl: maybeUserCvUrl));
  }
}
