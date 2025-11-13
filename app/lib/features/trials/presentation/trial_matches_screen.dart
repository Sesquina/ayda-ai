import 'package:flutter/material.dart';

import '../../../core/theme/ayda_theme.dart';

class TrialMatchesScreen extends StatelessWidget {
  const TrialMatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trial matches')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Saved matches', style: AydaText.h1),
            const SizedBox(height: 12),
            Text(
              'The trial matcher will populate this list with scored matches and links.',
              style: AydaText.body,
            ),
          ],
        ),
      ),
    );
  }
}
