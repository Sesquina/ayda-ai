import 'package:flutter/material.dart';

import '../../../core/theme/ayda_theme.dart';

class TrialProfileScreen extends StatelessWidget {
  const TrialProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trial profile')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Participant profile', style: AydaText.h1),
            const SizedBox(height: 12),
            Text(
              'Form inputs for diagnosis, stage, biomarkers, and preferences will live here.',
              style: AydaText.body,
            ),
          ],
        ),
      ),
    );
  }
}
