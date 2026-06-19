import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FirebaseMessaging _messaging =
      FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin
      _localNotifications =
      FlutterLocalNotificationsPlugin();

  

  static Future<void> init() async {
    NotificationSettings settings =
        await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint(
      "Permission: ${settings.authorizationStatus}",
    );

    const AndroidInitializationSettings android =
        AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const InitializationSettings initSettings =
        InitializationSettings(
      android: android,
    );

    await _localNotifications.initialize(
      initSettings,
    );

    const AndroidNotificationChannel channel =
        AndroidNotificationChannel(
      'orders_channel',
      'Orders',
      description:
          'Order updates and notifications',
      importance: Importance.max,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        await _localNotifications.show(
          DateTime.now()
              .millisecondsSinceEpoch
              .remainder(100000),

          message.notification?.title ??
              "Maison Luxe",

          message.notification?.body ?? "",

          const NotificationDetails(
            android: AndroidNotificationDetails(
              'orders_channel',
              'Orders',
              importance: Importance.max,
              priority: Priority.high,
              playSound: true,
            ),
          ),
        );
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        debugPrint(
          "Notification Opened",
        );
      },
    );

    await saveFcmToken();
  }

  

  static Future<void> saveFcmToken() async {
    final user =
        FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final token =
        await _messaging.getToken();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set({
      'uid': user.uid,
      'email': user.email,
      'fcmToken': token,
      'updatedAt':
          FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    debugPrint(
      "FCM Token Saved To Firestore",
    );
  }

  

  static Future<void> addNotification({
  required String title,
  required String body,
}) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) return;

  await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('notifications')
      .add({
    'title': title,
    'body': body,
    'isRead': false,
    'createdAt': FieldValue.serverTimestamp(),
  });

  await _localNotifications.show(
    DateTime.now()
        .millisecondsSinceEpoch
        .remainder(100000),
    title,
    body,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'orders_channel',
        'Orders',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      ),
    ),
  );
}



static Future<void> markAsRead(
  String notificationId,
) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) return;

  await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('notifications')
      .doc(notificationId)
      .update({
    'isRead': true,
  });
}
}