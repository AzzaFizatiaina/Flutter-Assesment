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
    apiKey: 'AIzaSyBIsd3MP0x9O1L7ZSZBFLCSS2TMSEUIsRw',
    appId: '1:206646353090:web:03d5c4216fbe4f9557ef5b',
    messagingSenderId: '206646353090',
    projectId: 'attendance-3c89b',
    authDomain: 'attendance-3c89b.firebaseapp.com',
    storageBucket: 'attendance-3c89b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBQX5c1HmJ0yy-qKGmpXzPKpzMJ4ySENSw',
    appId: '1:206646353090:android:cc9d9cda8d73f80657ef5b',
    messagingSenderId: '206646353090',
    projectId: 'attendance-3c89b',
    storageBucket: 'attendance-3c89b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAeLPoIBTALehiK8JzciUyMD4sY5tXyK_4',
    appId: '1:206646353090:ios:f8db9d5ffe0bf90357ef5b',
    messagingSenderId: '206646353090',
    projectId: 'attendance-3c89b',
    storageBucket: 'attendance-3c89b.appspot.com',
    iosClientId: '206646353090-7dggg00vlh800uaoq5032h942qc4hmrq.apps.googleusercontent.com',
    iosBundleId: 'com.example.attendanceRecord',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAeLPoIBTALehiK8JzciUyMD4sY5tXyK_4',
    appId: '1:206646353090:ios:f8db9d5ffe0bf90357ef5b',
    messagingSenderId: '206646353090',
    projectId: 'attendance-3c89b',
    storageBucket: 'attendance-3c89b.appspot.com',
    iosClientId: '206646353090-7dggg00vlh800uaoq5032h942qc4hmrq.apps.googleusercontent.com',
    iosBundleId: 'com.example.attendanceRecord',
  );
}
