import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:union_app/src/models/chat/chat_message.dart';
import 'package:union_app/src/repository/notification/firebase_push_token_repository.dart';

class NotificationRepository {
  factory NotificationRepository() {
    return _singleton;
  }

  NotificationRepository._internal();

  static final NotificationRepository _singleton =
  NotificationRepository._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebasePushTokenRepository _firebasePushTokenRepository = FirebasePushTokenRepository();


  // Handler for app closed or in background state
  Future<void> _messageHandler(RemoteMessage message) async {
    print('background message ${message.notification!.body}');
  }

  Future<void> sendChatNotification(ChatMessage message) async {
    _firebaseMessaging.sendMessage();
  }

  void registerNotification(String uid) {
    _firebaseMessaging.requestPermission();

    _firebaseMessaging.getToken().then((String? token) {
      print(token);
      if(token != null) {
        _firebasePushTokenRepository.addPushToken(uid, token);
      }
    });
  }


  // MUST BE REMOVED IN THE FUTURE AT ALL COSTS
  Future<void> printDevToken() async {
    String? message = await _firebaseMessaging.getToken();
    if(message != null) {
      print(message);
    }
  }






}
