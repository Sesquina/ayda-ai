import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/ayda_theme.dart';

class TrialsScreen extends StatelessWidget {
  const TrialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clinical trials')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Find matching trials', style: AydaText.h1),
            const SizedBox(height: 12),
            Text(
              'Complete a patient profile and review matches once the matcher is wired up.',
              style: AydaText.body,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => context.push('/trial-profile'),
              child: const Text('Create trial profile'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => context.push('/trial-matches'),
              child: const Text('View saved matches'),
            ),
          ],
        ),
      ),
    );
  }
}
