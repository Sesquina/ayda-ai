import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/ayda_theme.dart';

class TriageScreen extends StatelessWidget {
  const TriageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Symptom check')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tell us what is happening', style: AydaText.h1),
            const SizedBox(height: 12),
            Text(
              'This screen will collect symptoms, duration, and vitals before calling the triageAssess function.',
              style: AydaText.body,
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () => context.push('/er-script/temp-id'),
              child: const Text('Generate ER script (placeholder)'),
            ),
          ],
        ),
      ),
    );
  }
}
