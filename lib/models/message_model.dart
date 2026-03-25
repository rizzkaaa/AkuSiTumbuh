// lib/models/message_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String docId;
  final String senderId;
  final String senderName;
  final String senderRole; // 'dokter' atau 'orang_tua'
  final String text;
  final Timestamp timestamp;
  final bool isRead;

  const MessageModel({
    required this.docId,
    required this.senderId,
    required this.senderName,
    required this.senderRole,
    required this.text,
    required this.timestamp,
    required this.isRead,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map, String docId) {
    return MessageModel(
      docId: docId,
      senderId: map['senderId'] ?? '',
      senderName: map['senderName'] ?? '',
      senderRole: map['senderRole'] ?? '',
      text: map['text'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),
      isRead: map['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toMap() => {
        'senderId': senderId,
        'senderName': senderName,
        'senderRole': senderRole,
        'text': text,
        'timestamp': timestamp,
        'isRead': isRead,
      };
}

class ChatRoomModel {
  final String id;
  final String dokterId;
  final String dokterNama;
  final String orangTuaId;
  final String orangTuaNama;
  final String lastMessage;
  final Timestamp lastMessageTime;
  final int unreadCount;

  const ChatRoomModel({
    required this.id,
    required this.dokterId,
    required this.dokterNama,
    required this.orangTuaId,
    required this.orangTuaNama,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
  });

  factory ChatRoomModel.fromMap(Map<String, dynamic> map, String id) {
    return ChatRoomModel(
      id: id,
      dokterId: map['dokterId'] ?? '',
      dokterNama: map['dokterNama'] ?? '',
      orangTuaId: map['orangTuaId'] ?? '',
      orangTuaNama: map['orangTuaNama'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
      lastMessageTime: map['lastMessageTime'] ?? Timestamp.now(),
      unreadCount: map['unreadCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
        'dokterId': dokterId,
        'dokterNama': dokterNama,
        'orangTuaId': orangTuaId,
        'orangTuaNama': orangTuaNama,
        'lastMessage': lastMessage,
        'lastMessageTime': lastMessageTime,
        'unreadCount': unreadCount,
      };
}