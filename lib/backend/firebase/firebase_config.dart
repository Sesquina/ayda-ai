import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDThmwYlOudVlGWxrvT8MWNZgnQPoZ2imc",
            authDomain: "aydaai-1a95f.firebaseapp.com",
            projectId: "aydaai-1a95f",
            storageBucket: "aydaai-1a95f.firebasestorage.app",
            messagingSenderId: "1083305661141",
            appId: "1:1083305661141:web:622c1bd3034396744bc85c",
            measurementId: "G-GBL1R60VYT"));
  } else {
    await Firebase.initializeApp();
  }
}
