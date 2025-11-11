import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/router.dart';
import 'core/theme/ayda_theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AydaApp());
}

class AydaApp extends StatelessWidget {
  const AydaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ayda AI',
      theme: AydaTheme.light(),
      routerConfig: appRouter,
    );
  }
}
