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
    apiKey: 'AIzaSyAlEmr9qbTbGlagkwfKmNVoDBKXSHzkkHo',
    appId: '1:289433090249:web:2efed9163f9b4a86313518',
    messagingSenderId: '289433090249',
    projectId: 'hmft-op-compvis',
    authDomain: 'hmft-op-compvis.firebaseapp.com',
    storageBucket: 'hmft-op-compvis.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA16Yob5nYUGEkH7YQ3QMZmCihlNqVOsy4',
    appId: '1:289433090249:android:d8725cc70a92d56b313518',
    messagingSenderId: '289433090249',
    projectId: 'hmft-op-compvis',
    storageBucket: 'hmft-op-compvis.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0HPxJ58_8N1IL1NzpmQlURqolh_FDCh8',
    appId: '1:289433090249:ios:3c9dd3529e35b7b9313518',
    messagingSenderId: '289433090249',
    projectId: 'hmft-op-compvis',
    storageBucket: 'hmft-op-compvis.appspot.com',
    iosClientId: '289433090249-4a7ttddlsuliko2k9sgk3gmlht9a552q.apps.googleusercontent.com',
    iosBundleId: 'com.example.mobileApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD0HPxJ58_8N1IL1NzpmQlURqolh_FDCh8',
    appId: '1:289433090249:ios:3c9dd3529e35b7b9313518',
    messagingSenderId: '289433090249',
    projectId: 'hmft-op-compvis',
    storageBucket: 'hmft-op-compvis.appspot.com',
    iosClientId: '289433090249-4a7ttddlsuliko2k9sgk3gmlht9a552q.apps.googleusercontent.com',
    iosBundleId: 'com.example.mobileApp',
  );
}
