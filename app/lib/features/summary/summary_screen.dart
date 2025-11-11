import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Summary of Record')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Main Findings',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: const Text('This is a summary placeholder.')),
            ),
            const SizedBox(height: 12),
            const Text('Doctor Notes Translated',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: const Text('Translated notes placeholder.'))),
            const Spacer(),
            Row(children: [
              TextButton(onPressed: () {}, child: const Text('👍')),
              TextButton(onPressed: () {}, child: const Text('👎')),
              const SizedBox(width: 8),
              const Text('Was this helpful?')
            ])
          ],
        ),
      ),
    );
  }
}
