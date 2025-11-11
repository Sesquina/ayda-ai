import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
                title: const Text('Language'),
                subtitle: const Text('English / Español'),
                trailing: DropdownButton(items: const [
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'es', child: Text('Español'))
                ], onChanged: (_) {})),
            ListTile(title: const Text('Sign out'), onTap: () {}),
          ],
        ),
      ),
    );
  }
}
