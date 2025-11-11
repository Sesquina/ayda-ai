import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../upload/data/upload_record.dart';
import '../../upload/data/upload_repository.dart';

class SummaryScreenArguments {
  const SummaryScreenArguments({
    required this.documentId,
  });

  final String documentId;
}

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key, this.recordId});

  static const routeName = '/summary';

  final String? recordId;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final summaryArgs = args is SummaryScreenArguments ? args : null;
    final targetId = summaryArgs?.documentId ?? recordId;

    if (targetId == null || targetId.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Session summary'),
        ),
        body: const Center(
          child: Text('No summary selected. Choose a record from history.'),
        ),
      );
    }

    final repository = UploadRepository();

    return StreamBuilder<UploadRecord?>(
      stream: repository.watchUploadById(targetId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final record = snapshot.data;
        if (record == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Session summary'),
            ),
            body: const Center(
              child: Text('Summary metadata not found. It may have been deleted.'),
            ),
          );
        }

        final theme = Theme.of(context);
        final highlights = record.tags.isNotEmpty
            ? record.tags
            : <String>[
                'Upload metadata saved. Awaiting Cloud Functions summarization.',
                'Add caregiver tags during upload to personalize insights.',
              ];
        final nextSteps = <String>[
          if (record.summary == null)
            'Trigger summarizeRecord Cloud Function once AI integration is ready.',
          'Share this summary with the care team after review.',
          'Collect caregiver feedback to refine recommendations.',
        ];

        return Scaffold(
          appBar: AppBar(
            title: const Text('Session summary'),
            actions: [
              IconButton(
                icon: const Icon(Icons.history),
                onPressed: () => context.push('/history'),
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
                  record.fileName.isEmpty
                      ? 'Upload ${record.id}'
                      : record.fileName,
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Created ${_formatDateTime(record.createdAt)} · Status ${record.status}',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(
                  'Storage path: ${record.storagePath}',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 24),
                _SummaryCard(
                  title: 'AI summary',
                  body: record.summary ??
                      'Summary pending. Once the Cloud Function completes, results will be displayed here.',
                ),
                const SizedBox(height: 16),
                if (record.notes != null && record.notes!.isNotEmpty) ...[
                  _SummaryCard(
                    title: 'Caregiver notes',
                    body: record.notes!,
                  ),
                  const SizedBox(height: 16),
                ],
                _HighlightsSection(highlights: highlights),
                const SizedBox(height: 16),
                _NextStepsSection(nextSteps: nextSteps),
                const SizedBox(height: 16),
                _SentimentIndicator(score: record.sentimentScore ?? 0.0),
              ],
            ),
          ),
        );
      },
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
    final displayScore = score.clamp(0.0, 1.0);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            SizedBox(
              height: 48,
              width: 48,
              child: CircularProgressIndicator(
                value: displayScore == 0 ? null : displayScore,
                backgroundColor: theme.colorScheme.secondary.withOpacity(0.2),
                valueColor:
                    AlwaysStoppedAnimation<Color>(theme.colorScheme.secondary),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayScore == 0
                        ? 'Sentiment pending'
                        : 'Overall sentiment ${(displayScore * 100).round()}%',
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    displayScore == 0
                        ? 'Awaiting AI-generated sentiment once the summary completes.'
                        : 'Positive momentum detected. Keep reinforcing uplifting routines.',
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

String _formatDateTime(DateTime timestamp) {
  return '${timestamp.year}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.day.toString().padLeft(2, '0')} ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
}
