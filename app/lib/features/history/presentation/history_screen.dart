import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../upload/data/upload_record.dart';
import '../../upload/data/upload_repository.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  static const routeName = '/history';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = List.generate(
      8,
      (index) => HistoryEntry(
        documentId: 'demo-record-${(index + 1).toString().padLeft(3, '0')}',
        createdAt: DateTime.now().subtract(Duration(days: index)),
        sentimentScore: (0.78 - index * 0.03).clamp(0.0, 1.0).toDouble(),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary history'),
      ),
      body: StreamBuilder<List<UploadRecord>>(
        stream: repository.watchUploadsForUser(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final records = snapshot.data ?? const <UploadRecord>[];
          if (records.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'No uploads yet. Create metadata from the upload screen to populate your history.',
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(24),
            itemCount: records.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final record = records[index];
              final sentiment = record.sentimentScore;
              final trailing = sentiment != null
                  ? Text('${(sentiment * 100).round()}%')
                  : Text(record.status);
              return Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(20),
                  title: Text(
                    record.fileName.isEmpty
                        ? 'Upload ${record.id}'
                        : record.fileName,
                    style: theme.textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    'Created ${_formatDate(record.createdAt)} · ${record.storagePath}',
                  ),
                  trailing: trailing,
                  onTap: () => context.push('/summary/${record.id}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final entry = items[index];
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(20),
              title: Text(
                'Care summary ${entry.documentId}',
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Text(
                'Generated ${_formatDate(entry.createdAt)} · Sentiment ${(entry.sentimentScore * 100).round()}%',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}

class HistoryEntry {
  const HistoryEntry({
    required this.documentId,
    required this.createdAt,
    required this.sentimentScore,
  });

  final String documentId;
  final DateTime createdAt;
  final double sentimentScore;
}

String _formatDate(DateTime date) {
  return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}
