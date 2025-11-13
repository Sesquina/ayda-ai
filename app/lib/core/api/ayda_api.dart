import 'package:cloud_functions/cloud_functions.dart';

enum TriageRiskLevel { low, medium, high }

class SummarySection {
  const SummarySection({required this.title, required this.body});

  factory SummarySection.fromJson(Map<String, dynamic> json) {
    return SummarySection(
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
    );
  }

  final String title;
  final String body;
}

class SummarizeRecordResponse {
  const SummarizeRecordResponse({
    required this.summaryId,
    required this.readingLevel,
    required this.comprehensionScore,
    required this.sections,
  });

  factory SummarizeRecordResponse.fromJson(Map<String, dynamic> json) {
    final rawSections = (json['sections'] as List<dynamic>? ?? [])
        .map((item) => SummarySection.fromJson(item as Map<String, dynamic>))
        .toList();
    return SummarizeRecordResponse(
      summaryId: json['summaryId'] as String? ?? '',
      readingLevel: (json['readingLevel'] as num?)?.toDouble() ?? 0,
      comprehensionScore: (json['comprehensionScore'] as num?)?.toDouble() ?? 0,
      sections: rawSections,
    );
  }

  final String summaryId;
  final double readingLevel;
  final double comprehensionScore;
  final List<SummarySection> sections;
}

class TriageSymptomsResponse {
  const TriageSymptomsResponse({
    required this.sessionId,
    required this.riskLevel,
    required this.advice,
  });

  factory TriageSymptomsResponse.fromJson(Map<String, dynamic> json) {
    final risk = (json['riskLevel'] as String? ?? 'medium').toLowerCase();
    final parsedLevel = TriageRiskLevel.values.firstWhere(
      (value) => value.name == risk,
      orElse: () => TriageRiskLevel.medium,
    );
    return TriageSymptomsResponse(
      sessionId: json['sessionId'] as String? ?? '',
      riskLevel: parsedLevel,
      advice: json['advice'] as String? ?? '',
    );
  }

  final String sessionId;
  final TriageRiskLevel riskLevel;
  final String advice;
}

class MedicationReminder {
  const MedicationReminder({
    required this.id,
    required this.medication,
    required this.schedule,
    required this.channel,
  });

  factory MedicationReminder.fromJson(Map<String, dynamic> json) {
    return MedicationReminder(
      id: json['id'] as String? ?? '',
      medication: json['medication'] as String? ?? '',
      schedule: json['schedule'] as String? ?? '',
      channel: json['channel'] as String? ?? 'push',
    );
  }

  final String id;
  final String medication;
  final String schedule;
  final String channel;
}

class GetMedicationRemindersResponse {
  const GetMedicationRemindersResponse({required this.reminders});

  factory GetMedicationRemindersResponse.fromJson(Map<String, dynamic> json) {
    final reminders = (json['reminders'] as List<dynamic>? ?? [])
        .map((item) => MedicationReminder.fromJson(item as Map<String, dynamic>))
        .toList();
    return GetMedicationRemindersResponse(reminders: reminders);
  }

  final List<MedicationReminder> reminders;
}

class ClinicalTrialMatch {
  const ClinicalTrialMatch({
    required this.trialId,
    required this.title,
    required this.score,
    required this.url,
  });

  factory ClinicalTrialMatch.fromJson(Map<String, dynamic> json) {
    return ClinicalTrialMatch(
      trialId: json['trialId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      score: (json['score'] as num?)?.toDouble() ?? 0,
      url: json['url'] as String? ?? '',
    );
  }

  final String trialId;
  final String title;
  final double score;
  final String url;
}

class MatchClinicalTrialsResponse {
  const MatchClinicalTrialsResponse({required this.matches});

  factory MatchClinicalTrialsResponse.fromJson(Map<String, dynamic> json) {
    final matches = (json['matches'] as List<dynamic>? ?? [])
        .map((item) => ClinicalTrialMatch.fromJson(item as Map<String, dynamic>))
        .toList();
    return MatchClinicalTrialsResponse(matches: matches);
  }

  final List<ClinicalTrialMatch> matches;
}

class AydaApi {
  AydaApi({FirebaseFunctions? functions})
      : _functions = functions ?? FirebaseFunctions.instanceFor(region: 'us-central1');

  final FirebaseFunctions _functions;

  Future<SummarizeRecordResponse> summarizeRecord({
    required String uid,
    required String text,
    String? orgId,
    String? recordId,
    String lang = 'en',
  }) async {
    final callable = _functions.httpsCallable('summarizeRecord');
    final result = await callable<Map<String, dynamic>>({
      'uid': uid,
      'text': text,
      if (orgId != null) 'orgId': orgId,
      if (recordId != null) 'recordId': recordId,
      'lang': lang,
    });
    return SummarizeRecordResponse.fromJson(result.data);
  }

  Future<TriageSymptomsResponse> triageSymptoms({
    required String uid,
    required List<String> symptoms,
    required String duration,
    Map<String, dynamic>? vitals,
    String? orgId,
    String lang = 'en',
  }) async {
    final callable = _functions.httpsCallable('triageSymptoms');
    final result = await callable<Map<String, dynamic>>({
      'uid': uid,
      'symptoms': symptoms,
      'duration': duration,
      if (vitals != null) 'vitals': vitals,
      if (orgId != null) 'orgId': orgId,
      'lang': lang,
    });
    return TriageSymptomsResponse.fromJson(result.data);
  }

  Future<GetMedicationRemindersResponse> getMedicationReminders({
    required String uid,
    String? orgId,
  }) async {
    final callable = _functions.httpsCallable('getMedicationReminders');
    final result = await callable<Map<String, dynamic>>({
      'uid': uid,
      if (orgId != null) 'orgId': orgId,
    });
    return GetMedicationRemindersResponse.fromJson(result.data);
  }

  Future<MatchClinicalTrialsResponse> matchClinicalTrials({
    required String profileId,
    String? uid,
    String? orgId,
  }) async {
    final callable = _functions.httpsCallable('matchClinicalTrials');
    final result = await callable<Map<String, dynamic>>({
      'profileId': profileId,
      if (uid != null) 'uid': uid,
      if (orgId != null) 'orgId': orgId,
    });
    return MatchClinicalTrialsResponse.fromJson(result.data);
  }
}

final aydaApi = AydaApi();
