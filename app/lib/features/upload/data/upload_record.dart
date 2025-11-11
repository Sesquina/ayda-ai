import 'package:cloud_firestore/cloud_firestore.dart';

class UploadRecord {
  const UploadRecord({
    required this.id,
    required this.ownerId,
    required this.fileName,
    required this.storagePath,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.summary,
    this.sentimentScore,
    this.notes,
    this.tags = const <String>[],
  });

  final String id;
  final String ownerId;
  final String fileName;
  final String storagePath;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? summary;
  final double? sentimentScore;
  final String? notes;
  final List<String> tags;

  static const pendingStatus = 'pending';
  static const completedStatus = 'completed';
  static const failedStatus = 'failed';

  UploadRecord copyWith({
    String? id,
    String? ownerId,
    String? fileName,
    String? storagePath,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? summary,
    double? sentimentScore,
    String? notes,
    List<String>? tags,
  }) {
    return UploadRecord(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      fileName: fileName ?? this.fileName,
      storagePath: storagePath ?? this.storagePath,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      summary: summary ?? this.summary,
      sentimentScore: sentimentScore ?? this.sentimentScore,
      notes: notes ?? this.notes,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'fileName': fileName,
      'storagePath': storagePath,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'summary': summary,
      'sentimentScore': sentimentScore,
      'notes': notes,
      'tags': tags,
    };
  }

  static UploadRecord fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data() ?? <String, dynamic>{};
    final createdAtRaw = data['createdAt'];
    final updatedAtRaw = data['updatedAt'];
    return UploadRecord(
      id: snapshot.id,
      ownerId: data['ownerId'] as String? ?? '',
      fileName: data['fileName'] as String? ?? '',
      storagePath: data['storagePath'] as String? ?? '',
      status: data['status'] as String? ?? pendingStatus,
      createdAt: _timestampToDate(createdAtRaw),
      updatedAt: _timestampToDate(updatedAtRaw),
      summary: data['summary'] as String?,
      sentimentScore: (data['sentimentScore'] as num?)?.toDouble(),
      notes: data['notes'] as String?,
      tags: (data['tags'] as List<dynamic>?)
              ?.map((dynamic tag) => tag as String)
              .toList() ??
          const <String>[],
    );
  }

  static DateTime _timestampToDate(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    }
    if (value is DateTime) {
      return value;
    }
    return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
  }
}
