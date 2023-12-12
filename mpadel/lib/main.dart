import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:Klasspadel/Common/FireBase/firebase_manager.dart';
import 'package:Klasspadel/Page/Home/Pageview/homeScreen.dart';
import 'package:Klasspadel/Page/test_pages.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:Klasspadel/Common/hive_constant_adapterInit.dart';

import 'package:Klasspadel/Common/language.dart';
import 'package:Klasspadel/Common/preferer_user.dart';
import 'package:Klasspadel/Common/router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import 'package:flutter_background_service_android/flutter_background_service_android.dart';

/// OPTIONAL when use custom notification
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';
PreferenceUser _prefs = PreferenceUser();
String? initApp;
IOWebSocketChannel? channelWeb;
const notificationChannelId = 'my_foreground';
final service = FlutterBackgroundService();
// this will be used for notification id, So you can update your custom notification with this id.
const notificationId = 888;

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

Future<void> initializeService() async {
  var textDescrip =
      'AlertFriends está activada y estamos comprobando que te encuentres bien';

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    "my_foreground", // id
    'AlertFriends – Personal Protection', // title
    description:
        'AlertFriends está activada y estamos comprobando que te encuentres bien.', // description
    importance: Importance.max, // importance must be at low or higher level
    playSound: true,
    showBadge: false,
    enableLights: true,
    // sound: RawResourceAndroidNotificationSound(sound)
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: "my_foreground",
      initialNotificationTitle: 'Klasspadel – Personal Protection',
      initialNotificationContent: textDescrip,
      foregroundServiceNotificationId: 778,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );

  // if (_prefs.getAcceptedNotification == PreferencePermission.allow ||
  //     _prefs.getDetectedFall ||
  //     _prefs.getAcceptedSendLocation == PreferencePermission.allow) {
  // service.startService();
  // }

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_bg_service_small');

  final List<DarwinNotificationCategory> darwinNotificationCategories =
      <DarwinNotificationCategory>[
    DarwinNotificationCategory(
      darwinNotificationCategoryText,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      darwinNotificationCategoryPlain,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          '90',
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ];
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {
      didReceiveLocalNotificationStream.add(
        ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        ),
      );
    },
    notificationCategories: darwinNotificationCategories,
  );

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      onDidReceiveBackgroundNotificationResponse(notificationResponse);
    },
    onDidReceiveBackgroundNotificationResponse:
        onDidReceiveBackgroundNotificationResponse,
  );

  final details =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  if (details != null && details.didNotificationLaunchApp) {
    print("object ${details.notificationResponse!.payload}");
    await inicializeHiveBD();
    await _prefs.initPrefs();
    onDidReceiveBackgroundNotificationResponse(details.notificationResponse!);
  }
}

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(
    NotificationResponse notificationResponse) async {
  switch (notificationResponse.notificationResponseType) {
    case NotificationResponseType.selectedNotification:
      break;
    case NotificationResponseType.selectedNotificationAction:
      if (notificationResponse.actionId != null &&
          notificationResponse.actionId!.contains("helpID")) {
        String taskIds =
            notificationResponse.actionId!.replaceAll("helpID_", "");
      }

      break;
  }
}

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();
  final log = preferences.getStringList('log') ?? <String>[];
  log.add(DateTime.now().toIso8601String());
  await preferences.setStringList('log', log);

  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // bring to foreground
  Timer.periodic(
    const Duration(seconds: 1),
    (timer) async {
      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService()) {
          /// OPTIONAL for use custom notification
          /// the notification id must be equals with AndroidConfiguration when you call configure() method.
          // flutterLocalNotificationsPlugin.show(
          //   888,
          //   'COOL SERVICE',
          //   'Awesome ${DateTime.now()}',
          //   const NotificationDetails(
          //     android: AndroidNotificationDetails(
          //         'my_foreground', 'MY FOREGROUND SERVICE',
          //         icon: 'launch_background',
          //         ongoing: true,
          //         importance: Importance.high),
          //   ),
          // );

          // if you don't using custom notification, uncomment this
          // service.setForegroundNotificationInfo(
          //   title: "My App Service",
          //   content: "Updated at ${DateTime.now()}",
          // );
        }
      }

      /// you can see this log in logcat
      print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

      // test using external plugin
      // final deviceInfo = DeviceInfoPlugin();
      // String? device;
      // if (Platform.isAndroid) {
      //   final androidInfo = await deviceInfo.androidInfo;
      //   device = androidInfo.model;
      // }

      // if (Platform.isIOS) {
      //   final iosInfo = await deviceInfo.iosInfo;
      //   device = iosInfo.model;
      // }

      // service.invoke(
      //   'update',
      //   {
      //     "current_date": DateTime.now().toIso8601String(),
      //     "device": "device",
      //   },
      // );
    },
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _prefs.initPrefs();
  await inicializeHiveBD();
  await initializeFirebase();

  // await initializeService();
  if (_prefs.getUrlTemp != "") {
    // var urlWS = _prefs.getUrlTemp.toString().split('https://');

    // channelWeb = IOWebSocketChannel.connect('wss://${urlWS.last}/websocket');

    // final inv = {
    //   'action': 'subscribe',
    //   'idUser': 1,
    // };

    // channelWeb?.sink.add(jsonEncode(inv));
    // channelWeb?.stream.listen((message) {
    //   // channelWeb?.sink.add('received!');
    //   print(message);
    //   channelWeb?.sink.close(status.goingAway);
    // });
  } else {
    // channelWeb =
    //     IOWebSocketChannel.connect('wss://${ConstantApi.baseApiWS}/websocket');

    // final inv = {
    //   'action': 'subscribe',
    //   'user': 3,
    // };
    // channelWeb?.sink.add(jsonEncode(inv));
    // channelWeb?.sink.add(jsonEncode(inv));
    // channelWeb?.stream.listen((message) {
    //   // channelWeb?.sink.add('received!');
    //   print(message);
    // });
  }

// Establecer conexión WebSocket al servidor

  // // Enviar invitación a un usuario específico
  void sendInvitation(String senderId, String receiverId) {
    final invitationData = {
      'action': 'sendInvitation',
      'senderId': senderId,
      'receiverId': receiverId,
    };
    channelWeb?.sink.add(jsonEncode(invitationData));
  }

  // // Responder a una invitación
  void respondToInvitation(String receiverId, String response) {
    final responseData = {
      'action': 'respondToInvitation',
      'receiverId': receiverId,
      'response': response,
    };
    channelWeb?.sink.add(jsonEncode(responseData));
    channelWeb?.sink.close();
  }

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom,
    SystemUiOverlay.top,
  ]);
  await requestPermission(Permission.notification);

  initApp = _prefs.onBoarding == true ? '/' : 'loginScreen';
  runApp(
    GetMaterialApp(
      home: HomePage(typeUser: ""),
      translations: Languages(), // your translations
      locale: const Locale(
          'es', 'ES'), // translations will be displayed in that locale
      fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
    ),
  );
}

Future<bool> requestPermission(Permission permission) async {
  PermissionStatus status = await permission.request();

  if (status.isPermanentlyDenied) {
    return false;
  } else if (status.isDenied) {
    return false;
  } else {
    return true;
  }
}
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String text = "Stop Service";
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Service App'),
//         ),
//         body: Column(
//           children: [
//             StreamBuilder<Map<String, dynamic>?>(
//               stream: FlutterBackgroundService().on('update'),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }

//                 final data = snapshot.data!;
//                 String? device = data["device"];
//                 DateTime? date = DateTime.tryParse(data["current_date"]);
//                 return Column(
//                   children: [
//                     Text(device ?? 'Unknown'),
//                     Text(date.toString()),
//                   ],
//                 );
//               },
//             ),
//             ElevatedButton(
//               child: const Text("Foreground Mode"),
//               onPressed: () {
//                 service.invoke("setAsForeground");
//               },
//             ),
//             ElevatedButton(
//               child: const Text("Background Mode"),
//               onPressed: () {
//                 service.invoke("setAsBackground");
//               },
//             ),
//             ElevatedButton(
//               child: Text(text),
//               onPressed: () async {
//                 var isRunning = await service.isRunning();
//                 if (isRunning) {
//                   service.invoke("stopService");
//                 } else {
//                   service.startService();
//                 }

//                 if (!isRunning) {
//                   text = 'Stop Service';
//                 } else {
//                   text = 'Start Service';
//                 }
//                 setState(() {});
//               },
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {},
//           child: const Icon(Icons.play_arrow),
//         ),
//       ),
//     );
//   }

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initial});
  final String initial;
  @override
  Widget build(BuildContext context) {
    // notificationAlert(context);
    return FutureBuilder<void>(
        future: null,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: initial,
            routes: appRoute,
            theme: ThemeData(
              primaryColor: Colors.amber,
            ),
          );
        });
  }

  // COMPLETE: Change return type to Future<InitializationStatus>
  // Future<InitializationStatus> _initGoogleMobileAds() {
  //   // TODO: Initialize Google Mobile Ads SDK
  //   return MobileAds.instance.initialize();
  // }
}
