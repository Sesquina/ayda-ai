import 'package:flutter/material.dart';

import '../../../core/theme/ayda_theme.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reminders')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reminder schedule', style: AydaText.h1),
            const SizedBox(height: 12),
            Text(
              'Upcoming reminders will appear here once scheduleReminder is fully wired.',
              style: AydaText.body,
            ),
          ],
        ),
      ),
    );
  }
}
