import 'package:akusitumbuh/models/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PuskesmasModel extends BaseModel {
  final String _puskesmasName;
  final String _domisili;

  PuskesmasModel({
    super.docId,
    required String puskesmasName,
    required String domisili,
    super.createdAt,
  }) : _puskesmasName = puskesmasName,
       _domisili = domisili;

  String get puskesmasName => _puskesmasName;
  String get domisili => _domisili;


  factory PuskesmasModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PuskesmasModel(
      docId: doc.id,
      puskesmasName: data['puskesmasName'] ?? '-',
      domisili: data['domisili'] ?? '-',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'puskesmasName': _puskesmasName,
      'domisili': _domisili,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

}
