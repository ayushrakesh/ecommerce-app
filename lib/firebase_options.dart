// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCoJtzH0nXw-KCMzAAqKAC1ezqqUXNMhEY',
    appId: '1:84607501984:android:b6c670059a7d35a3766bc5',
    messagingSenderId: '84607501984',
    projectId: 'ticket-booking-38655',
    storageBucket: 'ticket-booking-38655.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBRtUs-cF056cJLdrAelF8bG3jZI9rFk7I',
    appId: '1:84607501984:ios:5d952279a9f62e7f766bc5',
    messagingSenderId: '84607501984',
    projectId: 'ticket-booking-38655',
    storageBucket: 'ticket-booking-38655.appspot.com',
    androidClientId: '84607501984-7a4ip068rjhjjo34j5n7fg6ubu5r6o9r.apps.googleusercontent.com',
    iosClientId: '84607501984-v3qa2l8sqhb47mk7pk9cue37hi0mq00u.apps.googleusercontent.com',
    iosBundleId: 'com.example.ecommerceApp',
  );
}
