import 'package:go_router/go_router.dart';
import '../features/auth/login_screen.dart';
import '../features/home/home_screen.dart';
import '../features/upload/upload_screen.dart';
import '../features/summary/summary_screen.dart';
import '../features/history/history_screen.dart';
import '../features/settings/settings_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/upload', builder: (context, state) => const UploadScreen()),
    GoRoute(
        path: '/summary', builder: (context, state) => const SummaryScreen()),
    GoRoute(
        path: '/history', builder: (context, state) => const HistoryScreen()),
    GoRoute(
        path: '/settings', builder: (context, state) => const SettingsScreen()),
  ],
);
