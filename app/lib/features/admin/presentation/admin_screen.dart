import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/ayda_theme.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final metricsRef = FirebaseFirestore.instance
        .collection('orgs')
        .doc('demo_org')
        .collection('metrics')
        .orderBy(FieldPath.documentId);

    return Scaffold(
      appBar: AppBar(title: const Text('Analytics Dashboard')),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: metricsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return _emptyState(context);
          }

          final docs = snapshot.data!.docs;
          final latest = docs.last.data();

          return Padding(
            padding: const EdgeInsets.all(24),
            child: ListView(
              children: [
                Text('Comprehension Dashboard', style: AydaText.h1),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _metricCard(
                      title: 'Avg Comprehension',
                      value: _percentage(latest['avgComprehension']),
                      helper: 'Target: ≥ 0.80',
                    ),
                    _metricCard(
                      title: 'Avg Reading Level',
                      value: _number(latest['avgReadingLevel'], suffix: ' grade'),
                      helper: 'Goal: 6th–8th grade',
                    ),
                    _metricCard(
                      title: 'Positive Feedback',
                      value: _percentage(latest['feedbackPositiveRate']),
                      helper: 'Thumbs-up responses / total',
                    ),
                    _metricCard(
                      title: 'Red Flags (monthly)',
                      value: _number(latest['redFlagsTotal']),
                      helper: 'Lower is better',
                    ),
                    _metricCard(
                      title: 'Active Caregivers',
                      value: _number(latest['caregiversCount']),
                      helper: 'Unique uploaders this month',
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text('Trend: Comprehension Over Time', style: AydaText.h2),
                const SizedBox(height: 12),
                SizedBox(
                  height: 240,
                  child: LineChart(
                    LineChartData(
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 44,
                            getTitlesWidget: (value, _) => Text(
                              '${(value * 100).toStringAsFixed(0)}%',
                              style: AydaText.caption,
                            ),
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, _) {
                              final index = value.toInt();
                              if (index < 0 || index >= docs.length) {
                                return const SizedBox.shrink();
                              }
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  docs[index].id,
                                  style: AydaText.caption,
                                ),
                              );
                            },
                          ),
                        ),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          barWidth: 3,
                          isCurved: true,
                          color: AydaColors.primary,
                          dotData: FlDotData(show: false),
                          spots: [
                            for (var i = 0; i < docs.length; i++)
                              FlSpot(i.toDouble(), (docs[i]['avgComprehension'] as num?)?.toDouble() ?? 0),
                          ],
                        ),
                      ],
                      minY: 0,
                      maxY: 1,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _metricCard({
    required String title,
    required String value,
    required String helper,
  }) {
    return SizedBox(
      width: 220,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AydaText.caption),
              const SizedBox(height: 12),
              Text(value, style: AydaText.h2),
              const SizedBox(height: 8),
              Text(helper, style: AydaText.caption),
            ],
          ),
        ),
      ),
    );
  }

  String _percentage(dynamic value) {
    if (value is num) {
      return '${(value * 100).toStringAsFixed(1)}%';
    }
    return '--';
  }

  String _number(dynamic value, {String suffix = ''}) {
    if (value is num) {
      final formatted = value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(1);
      return '$formatted$suffix';
    }
    return '--';
  }

  Widget _emptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.insights_outlined, size: 64, color: AydaColors.primary.withOpacity(0.4)),
            const SizedBox(height: 16),
            Text('No metrics yet', style: AydaText.h2),
            const SizedBox(height: 8),
            Text(
              'Upload records or seed demo data to showcase comprehension trends.',
              style: AydaText.body,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
