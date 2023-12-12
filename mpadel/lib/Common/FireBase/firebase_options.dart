import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBp_dvT9jwErFTCRTHcJwjQQI0HfLLNSYM',
    appId: '1:509585336823:android:51d1249374216cabe8e6f2',
    messagingSenderId: '913124285548',
    projectId: 'klasspadel-a6702',
    authDomain: 'flutterfire-e2e-tests.firebaseapp.com',
    //databaseURL:
    //'https://flutterfire-e2e-tests-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'alertfriends-72e7a.appspot.com',
    measurementId: 'G-JN95N1JV2E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBp_dvT9jwErFTCRTHcJwjQQI0HfLLNSYM',
    appId: '1:913124285548:ios:a36b225cb89b19475b0c49',
    messagingSenderId: '913124285548',
    projectId: 'klasspadel-a6702',
    storageBucket: 'alertfriends-72e7a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA51Vk8sxn_oUTZuicvt7Q6KeTK626DUHo',
    appId: '1:913124285548:ios:a36b225cb89b19475b0c49',
    messagingSenderId: '913124285548',
    projectId: 'klasspadel-a6702',
    databaseURL:
        'https://flutterfire-e2e-tests-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'klasspadel-a6702.appspot.com',
    androidClientId:
        '406099696497-17qn06u8a0dc717u8ul7s49ampk13lul.apps.googleusercontent.com',
    iosClientId:
        '913124285548-ma1hvrei4q01en7fting61vgh73sqrr9.apps.googleusercontent.com',
    iosBundleId: 'io.flutter.plugins.firebase.messaging',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBp_dvT9jwErFTCRTHcJwjQQI0HfLLNSYM',
    appId: '1:406099696497:ios:1b423b89c63b82053574d0',
    messagingSenderId: '406099696497',
    projectId: 'flutterfire-e2e-tests',
    databaseURL:
        'https://flutterfire-e2e-tests-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutterfire-e2e-tests.appspot.com',
    androidClientId:
        '406099696497-17qn06u8a0dc717u8ul7s49ampk13lul.apps.googleusercontent.com',
    iosClientId:
        '406099696497-irb7edfevfkhi6t5s9kbuq1mt1og95rg.apps.googleusercontent.com',
    iosBundleId: 'io.flutter.plugins.firebase.messaging',
  );
}
