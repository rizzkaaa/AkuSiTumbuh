import 'package:akusitumbuh/models/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel extends BaseModel {
  final String _userID;
  final String _usia;
  final double _tb;
  final double _bb;
  final String _status;

  HistoryModel({
    super.docId,
    required String userID,
    required String usia,
    required double tb,
    required double bb,
    required String status,
    super.createdAt,
  }) : _userID = userID,
       _usia = usia,
       _tb = tb,
       _bb = bb,
       _status = status;

  String get userID => _userID;
  String get usia => _usia;
  double get tb => _tb;
  double get bb => _bb;
  String get status => _status;

  factory HistoryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return HistoryModel(
      docId: doc.id,
      userID: data['userID'] ?? '-',
      usia: data['usia'] ?? '',
      tb: data['tb'] ?? 0,
      bb: data['bb'] ?? 0,
      status: data['status'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userID': _userID,
      'usia': _usia,
      'tb': _tb,
      'bb': _bb,
      'status': _status,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
