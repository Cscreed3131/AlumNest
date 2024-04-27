// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBWCPrmBLSse7EmTSCrVKxQwUE98MIH5SY',
    appId: '1:930461040442:web:829158996dc4696c525a03',
    messagingSenderId: '930461040442',
    projectId: 'alumnest-d3326',
    authDomain: 'alumnest-d3326.firebaseapp.com',
    storageBucket: 'alumnest-d3326.appspot.com',
    measurementId: 'G-23K5JBF78Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB77LG1iUizDJ3-_MKMTOVqfwlLJI9yHaY',
    appId: '1:930461040442:android:81123f3449f814b7525a03',
    messagingSenderId: '930461040442',
    projectId: 'alumnest-d3326',
    storageBucket: 'alumnest-d3326.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDZaV_5lRrddeuQZT1GoHa8JGJecWUwAyY',
    appId: '1:930461040442:ios:96e4af94fe185915525a03',
    messagingSenderId: '930461040442',
    projectId: 'alumnest-d3326',
    storageBucket: 'alumnest-d3326.appspot.com',
    iosBundleId: 'com.example.alumnest',
  );
}
