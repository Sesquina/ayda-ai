import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../upload/data/upload_record.dart';
import '../../upload/data/upload_repository.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  static const routeName = '/history';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final theme = Theme.of(context);

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Summary history'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Sign in to view your upload history.',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    final repository = UploadRepository();

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

String _formatDate(DateTime date) {
  return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}
