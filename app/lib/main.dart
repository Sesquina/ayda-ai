import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/router.dart';
import 'core/theme/ayda_theme.dart';
import 'core/theme.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/history/presentation/history_screen.dart';
import 'features/summary/presentation/summary_screen.dart';
import 'features/upload/presentation/upload_screen.dart';
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
    return MaterialApp(
      title: 'Ayda AI',
      theme: AydaTheme.lightTheme,
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (_) => const LoginScreen(),
        UploadScreen.routeName: (_) => const UploadScreen(),
        SummaryScreen.routeName: (_) => const SummaryScreen(),
        HistoryScreen.routeName: (_) => const HistoryScreen(),
      },
    );
  }
}
