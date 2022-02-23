import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/repository/firestore/firestore.dart';
import 'package:union_app/src/repository/notification/notification_repository.dart';

import 'src/repository/authentication/auth.dart';
import 'src/screens/app/app.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  //print('background message ${message.notification!.body}');
  if (message.notification != null) {
    NotificationRepository().showNotification(message.notification!);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final FirebaseStorageRepository storageRepository = FirebaseStorageRepository();
  final FirebaseAuthRepository authenticationRepository = FirebaseAuthRepository(storageRepository: storageRepository);

  NotificationRepository().initialize();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  await authenticationRepository.user.first;
  runApp(App(authenticationRepository: authenticationRepository));
}
