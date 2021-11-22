import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/repository/storage/firebase_storage/firebase_storage_repository.dart';
import 'repository/authentication/auth.dart';

import 'screens/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final FirebaseStorageRepository storageRepository =
      FirebaseStorageRepository();
  final FirebaseAuthRepository authenticationRepository =
      FirebaseAuthRepository(storageRepository: storageRepository);

  await authenticationRepository.user.first;
  runApp(App(authenticationRepository: authenticationRepository));
}
