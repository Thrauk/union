import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:union_app/src/models/chat/chat_message.dart';

class NotificationRepository {
  factory NotificationRepository() {
    return _singleton;
  }

  NotificationRepository._internal() {
    FirebaseMessaging.onBackgroundMessage(_messageHandler);
  }

  static final NotificationRepository _singleton =
  NotificationRepository._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


  // Handler for app closed or in background state
  Future<void> _messageHandler(RemoteMessage message) async {
    print('background message ${message.notification!.body}');
  }

  Future<void> sendChatNotification(ChatMessage message) async {
    _firebaseMessaging.sendMessage();
  }


  // MUST BE REMOVED IN THE FUTURE AT ALL COSTS
  Future<void> printDevToken() async {
    String? message = await _firebaseMessaging.getToken();
    if(message != null) {
      print(message);
    }
  }






}
