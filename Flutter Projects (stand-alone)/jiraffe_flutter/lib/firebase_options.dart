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
        // throw UnsupportedError(
        //   'DefaultFirebaseOptions have not been configured for windows - '
        //   'you can reconfigure this by running the FlutterFire CLI again.',
        // );
        return windows;
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
    apiKey: 'AIzaSyBQmXV9vv2I9tdv0tKJsjGuWU6lP5FP6TE',
    appId: '1:1042099229332:web:e7b0e39e926cbd49f69a81',
    messagingSenderId: '1042099229332',
    projectId: 'jiraffe-flutter',
    authDomain: 'jiraffe-flutter.firebaseapp.com',
    storageBucket: 'jiraffe-flutter.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA6UGvXyETRdSwLKABT4TfvMw_DTf51QMo',
    appId: '1:1042099229332:android:b6b5ed7648c409faf69a81',
    messagingSenderId: '1042099229332',
    projectId: 'jiraffe-flutter',
    storageBucket: 'jiraffe-flutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAvHD16SoAQo44zd9wh2-zKMie39C04d7g',
    appId: '1:1042099229332:ios:a4ce0b9382eb74d1f69a81',
    messagingSenderId: '1042099229332',
    projectId: 'jiraffe-flutter',
    storageBucket: 'jiraffe-flutter.appspot.com',
    iosBundleId: 'com.example.jiraffeFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAvHD16SoAQo44zd9wh2-zKMie39C04d7g',
    appId: '1:1042099229332:ios:68f319980c709226f69a81',
    messagingSenderId: '1042099229332',
    projectId: 'jiraffe-flutter',
    storageBucket: 'jiraffe-flutter.appspot.com',
    iosBundleId: 'com.example.jiraffeFlutter.RunnerTests',
  );

  static const FirebaseOptions windows= FirebaseOptions(  // same as a web app
    apiKey: 'AIzaSyBQmXV9vv2I9tdv0tKJsjGuWU6lP5FP6TE',
    appId: '1:1042099229332:web:e7b0e39e926cbd49f69a81',
    messagingSenderId: '1042099229332',
    projectId: 'jiraffe-flutter',
    authDomain: 'jiraffe-flutter.firebaseapp.com',
    storageBucket: 'jiraffe-flutter.appspot.com',
  );
}
