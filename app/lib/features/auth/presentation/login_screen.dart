import 'package:flutter/material.dart';

import '../../common/widgets/ayda_primary_button.dart';
import '../../upload/presentation/upload_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Ayda AI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Caregiver insights at your fingertips',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(
              'Sign in to explore the caregiver assistant experience. ',
              style: theme.textTheme.bodyMedium,
            ),
            const Spacer(),
            AydaPrimaryButton(
              label: 'Continue with Email',
              icon: Icons.mail_outline,
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  UploadScreen.routeName,
                );
              },
            ),
            const SizedBox(height: 12),
            AydaPrimaryButton(
              label: 'Continue with Google',
              icon: Icons.account_circle_outlined,
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  UploadScreen.routeName,
                );
              },
            ),
            const SizedBox(height: 32),
            Text(
              'Authentication is mocked for now. Hook up Firebase Auth to enable real sign-in.',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
