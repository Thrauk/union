import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:union_app/src/models/chat/chat_message.dart';
import 'package:union_app/src/repository/notification/firebase_push_token_repository.dart';

class NotificationRepository {
  factory NotificationRepository() {
    return _singleton;
  }

  NotificationRepository._internal() {
    platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  }

  static final NotificationRepository _singleton = NotificationRepository._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebasePushTokenRepository _firebasePushTokenRepository = FirebasePushTokenRepository();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'union.com.message_channel',
    'Union chat',
    channelDescription: 'New message',
    playSound: true,
    enableVibration: true,
    importance: Importance.max,
    priority: Priority.high,
  );
  final IOSNotificationDetails iOSPlatformChannelSpecifics = const IOSNotificationDetails();
  late final NotificationDetails platformChannelSpecifics;

  Future<void> showNotification(RemoteNotification message) async {
    print(message.body);
    await _flutterLocalNotificationsPlugin.show(
      0,
      message.title,
      message.body,
      platformChannelSpecifics,
      // PAYLOAD TO BE SENT ON TAP. ON TAP NOT IMPLEMENTED FOR THE MOMENT!!
      //payload: json.encode(message),
    );
  }

  Future<void> initialize() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    /*
      IOS NOT ADDED YET BECAUSE TESTING IS NOT YET POSSIBLE!!!
     */
  }

  Future<void> sendChatNotification(ChatMessage message) async {
    _firebaseMessaging.sendMessage();
  }

  void registerNotification(String uid) {
    _firebaseMessaging.requestPermission();

    _firebaseMessaging.getToken().then((String? token) {
      print(token);
      if (token != null) {
        _firebasePushTokenRepository.addPushToken(uid, token);
      }
    });
  }

  // MUST BE REMOVED IN THE FUTURE AT ALL COSTS
  Future<void> printDevToken() async {
    String? message = await _firebaseMessaging.getToken();
    if (message != null) {
      print(message);
    }
  }
}
