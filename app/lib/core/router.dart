import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/login_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/upload/presentation/upload_screen.dart';
import '../features/summary/presentation/summary_screen.dart';
import '../features/history/presentation/history_screen.dart';
import '../features/triage/presentation/triage_screen.dart';
import '../features/er_script/presentation/er_script_screen.dart';
import '../features/meds/presentation/meds_screen.dart';
import '../features/reminders/presentation/reminders_screen.dart';
import '../features/family_updates/presentation/family_updates_screen.dart';
import '../features/trials/presentation/trial_profile_screen.dart';
import '../features/trials/presentation/trial_matches_screen.dart';
import '../features/trials/presentation/trials_screen.dart';
import '../features/admin/presentation/admin_screen.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

GoRouter _buildRouter() {
  final refresh = GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges());

  return GoRouter(
    initialLocation: '/',
    refreshListenable: refresh,
    redirect: (context, state) {
      final loggedIn = FirebaseAuth.instance.currentUser != null;
      final loggingIn = state.subloc == '/login';

      if (!loggedIn) {
        return loggingIn ? null : '/login';
      }

      if (loggingIn) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/upload',
        name: 'upload',
        builder: (context, state) => const UploadScreen(),
      ),
      GoRoute(
        path: '/history',
        name: 'history',
        builder: (context, state) => const HistoryScreen(),
      ),
      GoRoute(
        path: '/summary/:id',
        name: 'summary',
        builder: (context, state) => SummaryScreen(recordId: state.pathParameters['id']),
      ),
      GoRoute(
        path: '/triage',
        name: 'triage',
        builder: (context, state) => const TriageScreen(),
      ),
      GoRoute(
        path: '/er-script/:id',
        name: 'er-script',
        builder: (context, state) => ERScriptScreen(id: state.pathParameters['id'] ?? 'unknown'),
      ),
      GoRoute(
        path: '/meds',
        name: 'meds',
        builder: (context, state) => const MedsScreen(),
      ),
      GoRoute(
        path: '/reminders',
        name: 'reminders',
        builder: (context, state) => const RemindersScreen(),
      ),
      GoRoute(
        path: '/family-updates',
        name: 'family-updates',
        builder: (context, state) => const FamilyUpdatesScreen(),
      ),
      GoRoute(
        path: '/trials',
        name: 'trials',
        builder: (context, state) => const TrialsScreen(),
      ),
      GoRoute(
        path: '/trial-profile',
        name: 'trial-profile',
        builder: (context, state) => const TrialProfileScreen(),
      ),
      GoRoute(
        path: '/trial-matches',
        name: 'trial-matches',
        builder: (context, state) => const TrialMatchesScreen(),
      ),
      GoRoute(
        path: '/admin',
        name: 'admin',
        builder: (context, state) => const AdminScreen(),
      ),
    ],
  );
}

final GoRouter appRouter = _buildRouter();
