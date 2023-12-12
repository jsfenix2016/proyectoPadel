import 'dart:io';
import 'dart:math';

import 'package:Klasspadel/Common/FireBase/firebase_options.dart';
import 'package:Klasspadel/Common/FireBase/firebase_service.dart';
import 'package:Klasspadel/Common/notification_service.dart';
import 'package:Klasspadel/Common/preferer_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

//import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  showFlutterNotification(message);
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

void showFlutterNotification(RemoteMessage message) {
  // RedirectViewNotifier.manageNotifications(message);
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp();

  await FirebaseMessaging.instance.getInitialMessage();

  onActionSelected("get_apns_token");
  FirebaseMessaging.onMessage.listen(showFlutterNotification);
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> updateFirebaseToken() async {
  onActionSelected("get_apns_token");
}

Future<void> onActionSelected(String value) async {
  switch (value) {
    case 'subscribe':
      {
        print(
          'FlutterFire Messaging Example: Subscribing to topic "fcm_test".',
        );
        await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
        print(
          'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.',
        );
      }
      break;
    case 'unsubscribe':
      {
        print(
          'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".',
        );
        await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
        print(
          'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.',
        );
      }
      break;
    case 'get_apns_token':
      {
        if (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.macOS) {
          print('FlutterFire Messaging Example: Getting APNs token...');
          String? token = await FirebaseMessaging.instance.getAPNSToken();
          print('FlutterFire Messaging Example: Got APNs token: $token');

          PreferenceUser prefs = PreferenceUser();
          if (token != null) {
            prefs.setFCM = token;
          }
        } else {
          String? token = await FirebaseMessaging.instance.getToken();
          PreferenceUser prefs = PreferenceUser();
          prefs.setFCM = token!;
          // final MainController mainController = Get.put(MainController());
          // var user = await mainController.getUserData();

          // if (user.telephone != "" && token != null) {
          //   var firebaseTokenApi = FirebaseTokenApi(
          //       phoneNumber: user.telephone.replaceAll("+34", ""),
          //       fcmToken: token);
          //   FirebaseService().saveData(firebaseTokenApi);
          // }

          print(
            'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.',
          );
        }
      }
      break;
    default:
      break;
  }
}
