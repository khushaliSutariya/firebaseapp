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
    apiKey: 'AIzaSyBVkKhv0mSp1jTam3dt7e-rPxfMFCU5g-4',
    appId: '1:1015691485549:web:b2a3f145657f9f6a3afa64',
    messagingSenderId: '1015691485549',
    projectId: 'fir-app-67ba7',
    authDomain: 'fir-app-67ba7.firebaseapp.com',
    storageBucket: 'fir-app-67ba7.appspot.com',
    measurementId: 'G-41FJE9R2E1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNtgfSn7SDbMVGlnCB9Da2pkw29K_4kto',
    appId: '1:1015691485549:android:35f0fae7b223cecc3afa64',
    messagingSenderId: '1015691485549',
    projectId: 'fir-app-67ba7',
    storageBucket: 'fir-app-67ba7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdjXzWShnhyu-2VdYveNOV7xAjvjqP9tQ',
    appId: '1:1015691485549:ios:4cdcee382a75f2333afa64',
    messagingSenderId: '1015691485549',
    projectId: 'fir-app-67ba7',
    storageBucket: 'fir-app-67ba7.appspot.com',
    iosClientId: '1015691485549-b9rqg6r9l49nmup1250dgq5hc6k3kv1g.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCdjXzWShnhyu-2VdYveNOV7xAjvjqP9tQ',
    appId: '1:1015691485549:ios:58d94cb9635d18883afa64',
    messagingSenderId: '1015691485549',
    projectId: 'fir-app-67ba7',
    storageBucket: 'fir-app-67ba7.appspot.com',
    iosClientId: '1015691485549-mkusufvj0vr8hderl9prpu4j85emjscv.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseapp.RunnerTests',
  );
}
