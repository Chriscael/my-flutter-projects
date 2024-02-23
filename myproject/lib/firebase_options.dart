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
      return web;
    }
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
    apiKey: 'AIzaSyAtD2h8G6i5UgJms70hTLYg3HkX4beUwZw',
    appId: '1:93451160982:web:9ab5205d21e716053c21b7',
    messagingSenderId: '93451160982',
    projectId: 'myproject-f8085',
    authDomain: 'myproject-f8085.firebaseapp.com',
    storageBucket: 'myproject-f8085.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDl7xKweo5DmYcVSI_AXuoN_ccLnUpDlIw',
    appId: '1:93451160982:android:51e3aaad54e63f023c21b7',
    messagingSenderId: '93451160982',
    projectId: 'myproject-f8085',
    storageBucket: 'myproject-f8085.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDGNE6V6R_NP_kLYsA3qWDF-enZ16wpZSA',
    appId: '1:93451160982:ios:e7dcb56015ae6e233c21b7',
    messagingSenderId: '93451160982',
    projectId: 'myproject-f8085',
    storageBucket: 'myproject-f8085.appspot.com',
    iosBundleId: 'com.example.myproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDGNE6V6R_NP_kLYsA3qWDF-enZ16wpZSA',
    appId: '1:93451160982:ios:f069b47cd3efe7b03c21b7',
    messagingSenderId: '93451160982',
    projectId: 'myproject-f8085',
    storageBucket: 'myproject-f8085.appspot.com',
    iosBundleId: 'com.example.myproject.RunnerTests',
  );
}