import 'package:cloud_functions/cloud_functions.dart';

enum TriageRiskLevel { low, medium, high }

class SummarizeRecordResponse {
  const SummarizeRecordResponse({required this.summaryId});

  factory SummarizeRecordResponse.fromJson(Map<String, dynamic> json) {
    return SummarizeRecordResponse(summaryId: json['summaryId'] as String);
  }

  final String summaryId;
}

class TriageAssessResponse {
  const TriageAssessResponse({
    required this.sessionId,
    required this.riskLevel,
    required this.advice,
  });

  factory TriageAssessResponse.fromJson(Map<String, dynamic> json) {
    final rawRisk = (json['riskLevel'] as String?)?.toLowerCase() ?? 'medium';
    return TriageAssessResponse(
      sessionId: json['sessionId'] as String,
      riskLevel: TriageRiskLevel.values.firstWhere(
        (level) => level.name == rawRisk,
        orElse: () => TriageRiskLevel.medium,
      ),
      advice: json['advice'] as String? ?? '',
    );
  }

  final String sessionId;
  final TriageRiskLevel riskLevel;
  final String advice;
}

class GenerateErScriptResponse {
  const GenerateErScriptResponse({
    required this.erScriptId,
    required this.text,
  });

  factory GenerateErScriptResponse.fromJson(Map<String, dynamic> json) {
    return GenerateErScriptResponse(
      erScriptId: json['erScriptId'] as String,
      text: json['text'] as String? ?? '',
    );
  }

  final String erScriptId;
  final String text;
}

class ScheduleReminderResponse {
  const ScheduleReminderResponse({required this.ok});

  factory ScheduleReminderResponse.fromJson(Map<String, dynamic> json) {
    return ScheduleReminderResponse(ok: json['ok'] as bool? ?? false);
  }

  final bool ok;
}

class TrialMatch {
  const TrialMatch({
    required this.trialId,
    required this.title,
    required this.score,
  });

  factory TrialMatch.fromJson(Map<String, dynamic> json) {
    return TrialMatch(
      trialId: json['trialId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      score: (json['score'] as num?)?.toDouble() ?? 0,
    );
  }

  final String trialId;
  final String title;
  final double score;
}

class MatchTrialsResponse {
  const MatchTrialsResponse({required this.matchId, required this.match});

  factory MatchTrialsResponse.fromJson(Map<String, dynamic> json) {
    return MatchTrialsResponse(
      matchId: json['matchId'] as String,
      match: TrialMatch.fromJson(json['match'] as Map<String, dynamic>),
    );
  }

  final String matchId;
  final TrialMatch match;
}

class AydaApi {
  AydaApi({FirebaseFunctions? functions})
      : _functions = functions ?? FirebaseFunctions.instanceFor(region: 'us-central1');

  final FirebaseFunctions _functions;

  Future<SummarizeRecordResponse> summarizeRecord({
    required String recordId,
    String lang = 'en',
  }) async {
    final callable = _functions.httpsCallable('summarizeRecord');
    final result = await callable<Map<String, dynamic>>({
      'recordId': recordId,
      'lang': lang,
    });
    return SummarizeRecordResponse.fromJson(result.data);
  }

  Future<TriageAssessResponse> triageAssess({
    required String ownerUid,
    required List<String> symptoms,
    required String duration,
    Map<String, dynamic>? vitals,
    String lang = 'en',
  }) async {
    final callable = _functions.httpsCallable('triageAssess');
    final result = await callable<Map<String, dynamic>>({
      'ownerUid': ownerUid,
      'symptoms': symptoms,
      'duration': duration,
      if (vitals != null) 'vitals': vitals,
      'lang': lang,
    });
    return TriageAssessResponse.fromJson(result.data);
  }

  Future<GenerateErScriptResponse> generateErScript({
    String? sessionId,
    String? recordId,
  }) async {
    final callable = _functions.httpsCallable('generateERScript');
    final result = await callable<Map<String, dynamic>>({
      if (sessionId != null) 'sessionId': sessionId,
      if (recordId != null) 'recordId': recordId,
    });
    return GenerateErScriptResponse.fromJson(result.data);
  }

  Future<ScheduleReminderResponse> scheduleReminder({
    required String reminderId,
  }) async {
    final callable = _functions.httpsCallable('scheduleReminder');
    final result = await callable<Map<String, dynamic>>({
      'reminderId': reminderId,
    });
    return ScheduleReminderResponse.fromJson(result.data);
  }

  Future<MatchTrialsResponse> matchTrials({
    required String profileId,
  }) async {
    final callable = _functions.httpsCallable('matchTrials');
    final result = await callable<Map<String, dynamic>>({
      'profileId': profileId,
    });
    return MatchTrialsResponse.fromJson(result.data);
  }
}

final aydaApi = AydaApi();
