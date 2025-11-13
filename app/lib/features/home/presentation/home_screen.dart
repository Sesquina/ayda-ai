import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/ayda_theme.dart';
import '../../common/widgets/ayda_primary_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayda')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            Text('Hi there 👋', style: AydaText.h1),
            const SizedBox(height: 8),
            Text(
              'What would you like to do today?',
              style: AydaText.body,
            ),
            const SizedBox(height: 24),
            AydaPrimaryButton(
              label: 'Upload medical record',
              onPressed: () => context.go('/upload'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => context.go('/triage'),
              child: const Text('Check symptoms'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => context.go('/history'),
              child: const Text('View summaries'),
            ),
            const SizedBox(height: 32),
            Text('Quick links', style: AydaText.h2),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _QuickLink(
                  label: 'Medication list',
                  icon: Icons.medication_outlined,
                  onTap: () => context.go('/meds'),
                ),
                _QuickLink(
                  label: 'Reminders',
                  icon: Icons.notifications_active_outlined,
                  onTap: () => context.go('/reminders'),
                ),
                _QuickLink(
                  label: 'Family updates',
                  icon: Icons.forum_outlined,
                  onTap: () => context.go('/family-updates'),
                ),
                _QuickLink(
                  label: 'Clinical trials',
                  icon: Icons.biotech_outlined,
                  onTap: () => context.go('/trials'),
                ),
                _QuickLink(
                  label: 'Admin dashboard',
                  icon: Icons.admin_panel_settings_outlined,
                  onTap: () => context.go('/admin'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickLink extends StatelessWidget {
  const _QuickLink({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: AydaColors.primary),
                const SizedBox(height: 12),
                Text(label, style: AydaText.body),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
