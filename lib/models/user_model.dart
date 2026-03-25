import 'package:akusitumbuh/models/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends BaseModel {
  final String _email;
  final String _role;
  final String _photo;
  final bool _isNew;

  UserModel({
    super.docId,
    required String email,
    required String role,
    required String photo,
    required bool isNew,
    super.createdAt,
  }) : _email = email,
       _role = role,
       _photo = photo,
       _isNew = isNew;

  String get email => _email;
  String get role => _role;
  String get photo => _photo;
  bool get isNew => _isNew;

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      docId: doc.id,
      email: data['email'] ?? '-',
      role: data['role'] ?? 'Orang Tua',
      photo: data['photo'] ?? '-',
      isNew: data['isNew'] ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': _email,
      'role': _role,
      'photo': _photo,
      'isNew': _isNew,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
