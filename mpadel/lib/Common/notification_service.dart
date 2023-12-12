// import 'dart:io';

// import 'package:awesome_notifications/awesome_notifications.dart';

// //import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rxdart/rxdart.dart';

// //import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// //final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// // FlutterLocalNotificationsPlugin();

// /// Streams are created so that app can respond to notification-related events
// /// since the plugin is initialised in the `main` function
// final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
//     BehaviorSubject<ReceivedNotification>();

// final BehaviorSubject<String> selectNotificationSubject =
//     BehaviorSubject<String>();

// const MethodChannel platform =
//     MethodChannel('dexterx.dev/flutter_local_notifications_example');

// class ReceivedNotification {
//   ReceivedNotification({
//     required this.id,
//     required this.title,
//     required this.body,
//     required this.payload,
//   });

//   final int id;
//   final String title;
//   final String body;
//   final String payload;
// }

// String selectedNotificationPayload = "";
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// // If you're going to use other Firebase services in the background, such as Firestore,
// // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
// // if (!StringUtils.isNullOrEmpty(message.notification?.title,
// // considerWhiteSpaceAsEmpty: true) ||
// // !StringUtils.isNullOrEmpty(message.notification?.body,
// // considerWhiteSpaceAsEmpty: true)) {
// // print('message also contained a notification: ${message.notification}');

// // String imageUrl;
// // imageUrl ??= message.notification.android?.imageUrl;
// // imageUrl ??= message.notification.apple?.imageUrl;

// // Map<String, dynamic> notificationAdapter = {
// // NOTIFICATION_CHANNEL_KEY: 'basic_channel',
// // NOTIFICATION_ID: message.data[NOTIFICATION_CONTENT][NOTIFICATION_ID] ??
// // message.messageId ??
// // Random().nextInt(2147483647),
// // NOTIFICATION_TITLE: message.data[NOTIFICATION_CONTENT]
// // [NOTIFICATION_TITLE] ??
// // message.notification?.title,
// // NOTIFICATION_BODY: message.data[NOTIFICATION_CONTENT]
// // [NOTIFICATION_BODY] ??
// // message.notification?.body,
// // NOTIFICATION_LAYOUT:
// // StringUtils.isNullOrEmpty(imageUrl) ? 'Default' : 'BigPicture',
// // NOTIFICATION_BIG_PICTURE: imageUrl
// // };

// // AwesomeNotifications().createNotificationFromJsonData(notificationAdapter);
// // } else {
// // AwesomeNotifications().createNotificationFromJsonData(message.data);
// // }
// }

// /// Create a [AndroidNotificationChannel] for heads up notifications
// AndroidNotificationChannel? channel;
// bool kIsWeb = false;
// String initialRoute = "home";

// /// Initialize the [FlutterLocalNotificationsPlugin] package.
// FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

// createPlantFoodNotification() async {
//   await AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: 1,
//       channelKey: 'basic_channel',
//       title:
//           '${Emojis.money_money_bag + Emojis.plant_cactus} Buy Plant Food!!!',
//       body: 'Florist at 123 Main St. has 2 in stock.',
//       bigPicture: 'asset://assets/images/iconPets.png',
//       notificationLayout: NotificationLayout.BigPicture,
//     ),
//   );
// }

// notificationMain() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   FirebaseMessaging messaging;
//   messaging = FirebaseMessaging.instance;
//   messaging.getToken().then((value) {
//     print(value);
//   });

// // Set the background messaging handler early on, as a named top-level function
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   if (!kIsWeb) {
//     channel = const AndroidNotificationChannel(
//       'high_importance_channel', // id
//       'High Importance Notifications', // title// description
//       importance: Importance.high,
//     );

//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//     /// Create an Android Notification Channel.
//     ///
//     /// We use this channel in the `AndroidManifest.xml` file to override the
//     /// default FCM channel to enable heads up notifications.
//     await flutterLocalNotificationsPlugin!
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel!);

//     /// Update the iOS foreground notification presentation options to allow
//     /// heads up notifications.
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }

//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');

//   /// Note: permissions aren't requested here just to demonstrate that can be
//   /// done later

//   final InitializationSettings initializationSettings =
//       InitializationSettings(android: initializationSettingsAndroid);
//   await flutterLocalNotificationsPlugin!.initialize(initializationSettings,
//       onSelectNotification: (String payload) async {
//     if (payload != null) {
//       debugPrint('notification payload: $payload');
//     }
//     selectedNotificationPayload = payload;
//     selectNotificationSubject.add(payload);
//   });
// }

// notificationAlert(BuildContext context) {
//   FirebaseMessaging.onMessage.listen((RemoteMessage event) {
//     print("message recieved");
//     print(event.notification!.body);
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Notification"),
//             content: Text(event.notification!.body!),
//             actions: [
//               TextButton(
//                 child: Text("Ok"),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               )
//             ],
//           );
//         });
//   });
//   FirebaseMessaging.onMessageOpenedApp.listen((message) {
//     print('Message clicked!');
//   });
// }
