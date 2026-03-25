import 'package:akusitumbuh/models/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrangTuaModel extends BaseModel {
  final String _childName;
  final String _jenisKelamin;
  final DateTime _ttl;

  OrangTuaModel({
    super.docId,
    required String childName,
    required String jenisKelamin,
    required DateTime ttl,
    super.createdAt,
  }) : _childName = childName,
       _jenisKelamin = jenisKelamin,
       _ttl = ttl;

  String get childName => _childName;
  String get jenisKelamin => _jenisKelamin;
  DateTime get ttl => _ttl;


  factory OrangTuaModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrangTuaModel(
      docId: doc.id,
      childName: data['childName'] ?? '-',
      jenisKelamin: data['jenisKelamin'] ?? '-',
      ttl: (data['ttl'] as Timestamp).toDate(),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'childName': _childName,
      'jenisKelamin': _jenisKelamin,
      'ttl': _ttl,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

}
