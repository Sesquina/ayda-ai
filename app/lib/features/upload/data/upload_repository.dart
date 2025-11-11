import 'package:cloud_firestore/cloud_firestore.dart';

import 'upload_record.dart';

class UploadRepository {
  UploadRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const collectionName = 'uploads';

  CollectionReference<UploadRecord> get _collection => _firestore
      .collection(collectionName)
      .withConverter<UploadRecord>(
        fromFirestore: UploadRecord.fromFirestore,
        toFirestore: (record, _) => record.toMap(),
      );

  Future<UploadRecord> createUploadRecord({
    required String ownerId,
    required String fileName,
    required String storagePath,
    String status = UploadRecord.pendingStatus,
    String? notes,
    List<String> tags = const <String>[],
  }) async {
    final now = DateTime.now().toUtc();
    final record = UploadRecord(
      id: '',
      ownerId: ownerId,
      fileName: fileName,
      storagePath: storagePath,
      status: status,
      createdAt: now,
      updatedAt: now,
      notes: notes,
      tags: tags,
      summary: null,
      sentimentScore: null,
    );
    final docRef = await _collection.add(record);
    return record.copyWith(id: docRef.id);
  }

  Stream<List<UploadRecord>> watchUploadsForUser(String ownerId) {
    return _collection
        .where('ownerId', isEqualTo: ownerId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => doc.data().copyWith(id: doc.id))
              .toList(),
        );
  }

  Stream<UploadRecord?> watchUploadById(String documentId) {
    return _collection.doc(documentId).snapshots().map((snapshot) {
      final record = snapshot.data();
      return record?.copyWith(id: snapshot.id);
    });
  }
}
