import 'package:flutter/material.dart';

import '../../../core/theme/ayda_theme.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Organization admin')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Org metrics and controls', style: AydaText.h1),
            const SizedBox(height: 12),
            Text(
              'Future dashboard for API usage, audit logs, and role management.',
              style: AydaText.body,
            ),
          ],
        ),
      ),
    );
  }
}
