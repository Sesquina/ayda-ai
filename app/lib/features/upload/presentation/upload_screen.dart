import 'package:flutter/material.dart';

import '../../common/widgets/ayda_primary_button.dart';
import '../../summary/presentation/summary_screen.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  static const routeName = '/upload';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload care notes'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, SummaryScreen.routeName),
            icon: const Icon(Icons.history_toggle_off),
            tooltip: 'View latest summary',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Drop PDF, DOCX, or text files to simulate an upload.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            color: theme.colorScheme.primary,
                            size: 72,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Upload to Firebase Storage',
                            style: theme.textTheme.headlineSmall,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'This step is mocked. Connect Firebase Storage and Cloud Firestore to persist caregiver notes.',
                            style: theme.textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          AydaPrimaryButton(
                            label: 'Simulate upload',
                            icon: Icons.upload_rounded,
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                SummaryScreen.routeName,
                                arguments: const SummaryScreenArguments(
                                  documentId: 'demo-record-001',
                                  storagePath: 'uploads/demo-record-001.txt',
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
