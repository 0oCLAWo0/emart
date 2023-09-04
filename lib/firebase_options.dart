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
    apiKey: 'AIzaSyC3HH0490j6RoxKswEQLzE94ns6P1YELGA',
    appId: '1:443733551951:web:3ed43750cfa65f70f5f33a',
    messagingSenderId: '443733551951',
    projectId: 'e-mart-729d3',
    authDomain: 'e-mart-729d3.firebaseapp.com',
    storageBucket: 'e-mart-729d3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBSg904ZTtNwimR9iA4S6XD2rg7Itfvt64',
    appId: '1:443733551951:android:20699360b935ea95f5f33a',
    messagingSenderId: '443733551951',
    projectId: 'e-mart-729d3',
    storageBucket: 'e-mart-729d3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCmTPbeAXlVBSMLSlcS7TP-_v3YJPnuy-s',
    appId: '1:443733551951:ios:a0d61b30835c127df5f33a',
    messagingSenderId: '443733551951',
    projectId: 'e-mart-729d3',
    storageBucket: 'e-mart-729d3.appspot.com',
    iosClientId: '443733551951-j5mocphredkt4sftpkkgh6ke57ht62iq.apps.googleusercontent.com',
    iosBundleId: 'com.example.emart',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCmTPbeAXlVBSMLSlcS7TP-_v3YJPnuy-s',
    appId: '1:443733551951:ios:9721b6e5cfe4453df5f33a',
    messagingSenderId: '443733551951',
    projectId: 'e-mart-729d3',
    storageBucket: 'e-mart-729d3.appspot.com',
    iosClientId: '443733551951-99musvgfillmalst9b4mlcej3vt7qnnr.apps.googleusercontent.com',
    iosBundleId: 'com.example.emart.RunnerTests',
  );
}
