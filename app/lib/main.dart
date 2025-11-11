import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // In development it's fine to print; in production handle appropriately
    // If firebase_options.dart is missing, flutterfire configure must be run.
    // ignore: avoid_print
    print('Firebase initialization error: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ayda AI',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3A60C0)),
      ),
      home: const Scaffold(
        appBar: AppBar(title: Text('Ayda AI — Frontend (placeholder)')),
        body: Center(child: Text('This is a placeholder Flutter app.')),
      ),
    );
  }
}
