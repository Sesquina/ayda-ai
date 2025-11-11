import 'package:flutter/material.dart';

import '../../../core/theme/ayda_theme.dart';

class FamilyUpdatesScreen extends StatelessWidget {
  const FamilyUpdatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Family updates')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Keep everyone aligned', style: AydaText.h1),
            const SizedBox(height: 12),
            Text(
              'Templates and previews for SMS or WhatsApp updates will appear here.',
              style: AydaText.body,
            ),
          ],
        ),
      ),
    );
  }
}
