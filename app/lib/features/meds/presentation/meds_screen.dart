import 'package:flutter/material.dart';

import '../../../core/theme/ayda_theme.dart';

class MedsScreen extends StatelessWidget {
  const MedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medication list')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Medications', style: AydaText.h1),
            const SizedBox(height: 12),
            Text(
              'Future work: display meds, allow adding schedules, and sync to reminders.',
              style: AydaText.body,
            ),
          ],
        ),
      ),
    );
  }
}
