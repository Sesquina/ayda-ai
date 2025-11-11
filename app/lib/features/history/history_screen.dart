import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24)))),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.insert_drive_file),
                    title: Text('Record ${index + 1}'),
                    subtitle: const Text('Mini summary preview...'),
                    trailing: TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/summary'),
                        child: const Text('View Full Summary')),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
