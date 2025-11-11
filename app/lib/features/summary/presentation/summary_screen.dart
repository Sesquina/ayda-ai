import 'package:flutter/material.dart';

import '../../history/presentation/history_screen.dart';

class SummaryScreenArguments {
  const SummaryScreenArguments({
    required this.documentId,
    required this.storagePath,
  });

  final String documentId;
  final String storagePath;
}

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  static const routeName = '/summary';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final summaryArgs = args is SummaryScreenArguments
        ? args
        : const SummaryScreenArguments(
            documentId: 'demo-record-001',
            storagePath: 'uploads/demo-record-001.txt',
          );

    final theme = Theme.of(context);
    final highlights = <String>[
      'Client completed all medication with minimal prompting.',
      'Notable mood lift after morning walk and music therapy.',
      'Mild confusion observed before dinner, resolved with reassurance.',
    ];

    final nextSteps = <String>[
      'Share medication adherence with care coordinator.',
      'Schedule additional music therapy sessions.',
      'Monitor evening routines for potential triggers.',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Session summary'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.pushNamed(
              context,
              HistoryScreen.routeName,
            ),
            tooltip: 'View history',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Summary for ${summaryArgs.documentId}',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Storage path: ${summaryArgs.storagePath}',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 24),
            _SummaryCard(
              title: 'Key takeaways',
              body: 'Caregiver support this shift focused on maintaining routine and reinforcing positive interactions. Overall sentiment is positive.',
            ),
            const SizedBox(height: 16),
            _HighlightsSection(highlights: highlights),
            const SizedBox(height: 16),
            _NextStepsSection(nextSteps: nextSteps),
            const SizedBox(height: 16),
            _SentimentIndicator(score: 0.82),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(
              body,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _HighlightsSection extends StatelessWidget {
  const _HighlightsSection({required this.highlights});

  final List<String> highlights;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.auto_awesome, color: theme.colorScheme.secondary),
                const SizedBox(width: 12),
                Text(
                  'Highlights',
                  style: theme.textTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (final highlight in highlights)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_outline, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        highlight,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NextStepsSection extends StatelessWidget {
  const _NextStepsSection({required this.nextSteps});

  final List<String> nextSteps;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.flag, color: theme.colorScheme.error),
                const SizedBox(width: 12),
                Text(
                  'Next steps',
                  style: theme.textTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (final step in nextSteps)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        step,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SentimentIndicator extends StatelessWidget {
  const _SentimentIndicator({required this.score});

  final double score;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            CircularProgressIndicator(
              value: score,
              backgroundColor: theme.colorScheme.secondary.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.secondary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overall sentiment ${(score * 100).round()}%',
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Positive momentum detected. Keep reinforcing uplifting routines.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
