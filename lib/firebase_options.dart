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
    apiKey: 'AIzaSyCR9194Eh5K5h6FqIUJ7W3p0EkJwvMPvUM',
    appId: '1:811930927115:web:8d09859040b7031570c70e',
    messagingSenderId: '811930927115',
    projectId: 'repel-a3a4e',
    authDomain: 'repel-a3a4e.firebaseapp.com',
    storageBucket: 'repel-a3a4e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCGl-FMJe1DMm3etuG10vt4equNmPLlJIw',
    appId: '1:811930927115:android:7fe56398791afbc570c70e',
    messagingSenderId: '811930927115',
    projectId: 'repel-a3a4e',
    storageBucket: 'repel-a3a4e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJ9_0kModGs-FWvb1OKCRIjwPGKzt8fQo',
    appId: '1:811930927115:ios:cf15527fb702e68a70c70e',
    messagingSenderId: '811930927115',
    projectId: 'repel-a3a4e',
    storageBucket: 'repel-a3a4e.appspot.com',
    iosBundleId: 'com.example.repel',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBJ9_0kModGs-FWvb1OKCRIjwPGKzt8fQo',
    appId: '1:811930927115:ios:7727058d65deb16870c70e',
    messagingSenderId: '811930927115',
    projectId: 'repel-a3a4e',
    storageBucket: 'repel-a3a4e.appspot.com',
    iosBundleId: 'com.example.repel.RunnerTests',
  );
}