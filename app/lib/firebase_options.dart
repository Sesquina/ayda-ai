import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      case TargetPlatform.linux:
        return web;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not set for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDThmwYlOudVlGWxrvT8MWNZgnQPoZ2imc',
    authDomain: 'aydaai-1a95f.firebaseapp.com',
    databaseURL: 'https://aydaai-1a95f-default-rtdb.firebaseio.com',
    projectId: 'aydaai-1a95f',
    storageBucket: 'aydaai-1a95f.firebasestorage.app',
    messagingSenderId: '1083305661141',
    appId: '1:1083305661141:web:622c1bd3034396744bc85c',
    measurementId: 'G-GBL1R60VYT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDThmwYlOudVlGWxrvT8MWNZgnQPoZ2imc',
    appId: '1:1083305661141:android:622c1bd3034396744bc85c',
    messagingSenderId: '1083305661141',
    projectId: 'aydaai-1a95f',
    databaseURL: 'https://aydaai-1a95f-default-rtdb.firebaseio.com',
    storageBucket: 'aydaai-1a95f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDThmwYlOudVlGWxrvT8MWNZgnQPoZ2imc',
    appId: '1:1083305661141:ios:622c1bd3034396744bc85c',
    messagingSenderId: '1083305661141',
    projectId: 'aydaai-1a95f',
    databaseURL: 'https://aydaai-1a95f-default-rtdb.firebaseio.com',
    storageBucket: 'aydaai-1a95f.firebasestorage.app',
    iosClientId: '1083305661141-ios-client.apps.googleusercontent.com',
    iosBundleId: 'com.aydaai.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDThmwYlOudVlGWxrvT8MWNZgnQPoZ2imc',
    appId: '1:1083305661141:ios:622c1bd3034396744bc85c',
    messagingSenderId: '1083305661141',
    projectId: 'aydaai-1a95f',
    databaseURL: 'https://aydaai-1a95f-default-rtdb.firebaseio.com',
    storageBucket: 'aydaai-1a95f.firebasestorage.app',
    iosClientId: '1083305661141-macos-client.apps.googleusercontent.com',
    iosBundleId: 'com.aydaai.desktop',
  );
}
