import 'package:akusitumbuh/models/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel extends BaseModel {
  final List<String> _users;
  final LastMessageModel lastMessage;
  final Map<String, bool> typing;
  final Map<String, int> unread;

  ChatModel({
    super.docId,
    required List<String> users,
    required this.lastMessage,
    required this.typing,
    required this.unread,
  }) : _users = users;

  List<String> get users => _users;

  factory ChatModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ChatModel(
      docId: doc.id,
      users: List<String>.from(data['users']),
      lastMessage: LastMessageModel.fromMap(
      Map<String, dynamic>.from(data['lastMessage'] ?? {}),
    ),
      typing: Map<String, bool>.from(data['typing'] ?? {}),
      unread: Map<String, int>.from(data['unread'] ?? {}),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'users': _users,
       'lastMessage': lastMessage.toMap(),
      'typing': typing,
      'unread': unread,
    };
  }
}

class LastMessageModel {
  final String idPengirim;
  final String text;
  final DateTime time;
  final int status;

  LastMessageModel({
    required this.idPengirim,
    required this.text,
    required this.time,
    required this.status,
  });

  factory LastMessageModel.fromMap(Map<String, dynamic> data) {
    return LastMessageModel(
      idPengirim: data['idPengirim'] ?? '',
      text: data['text'] ?? '',
      time: (data['time'] as Timestamp?)!.toDate(),
      status: data['status'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idPengirim': idPengirim,
      'text': text,
      'time': time,
      'status': status,
    };
  }
}

class MessageModel extends BaseModel {
  final String _idPengirim;
  final String _text;
  final int _status;

  MessageModel({
    required String idPengirim,
    required String text,
    required int status,
    super.createdAt,
  }) : _idPengirim = idPengirim,
       _text = text,
       _status = status;

  String get idPengirim => _idPengirim;
  String get text => _text;
  int get status => _status;

  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MessageModel(
      idPengirim: data['idPengirim'],
      text: data['text'],
      status: data['status'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'idPengirim': _idPengirim,
      'text': _text,
      'status': _status,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
