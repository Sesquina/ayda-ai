import 'package:flutter/material.dart';

import '../../../core/theme/ayda_theme.dart';

class ERScriptScreen extends StatelessWidget {
  const ERScriptScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ER handoff')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ER script for $id', style: AydaText.h1),
            const SizedBox(height: 12),
            Text(
              'Once implemented this will render the generated ER script with copy and print actions.',
              style: AydaText.body,
            ),
          ],
        ),
      ),
    );
  }
}
