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
    apiKey: 'AIzaSyDY5sq1__IQ1GoX8DK3rXMHlnAHkme4HM4',
    appId: '1:19517064028:web:93aae9d06624bb9872f799',
    messagingSenderId: '19517064028',
    projectId: 'notespad-869d4',
    authDomain: 'notespad-869d4.firebaseapp.com',
    storageBucket: 'notespad-869d4.appspot.com',
    measurementId: 'G-J0D08V42F9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD1mzRJVph9J0s3ZwHJdo8oLx0tXQj-G1M',
    appId: '1:19517064028:android:250ab7b895fbf57f72f799',
    messagingSenderId: '19517064028',
    projectId: 'notespad-869d4',
    storageBucket: 'notespad-869d4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBoQZAPbIWhVjEFTLupiWnDB9_qKhEFDOc',
    appId: '1:19517064028:ios:b836d92b4bafe95c72f799',
    messagingSenderId: '19517064028',
    projectId: 'notespad-869d4',
    storageBucket: 'notespad-869d4.appspot.com',
    iosBundleId: 'com.example.notingpad',
  );
}
