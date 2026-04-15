import 'package:akusitumbuh/models/konsultansi_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference get _chatRef => _db.collection('chat');

  String get _uid => _auth.currentUser!.uid;

  Stream<List<ChatModel>> getListChat() {
    return _chatRef
        .where('users', arrayContains: _uid)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((e) => ChatModel.fromFirestore(e)).toList(),
        );
  }

  Future<String> getChatRoom(String otherUserId) async {
    final query = await _chatRef.where('users', arrayContains: _uid).get();

    for (var doc in query.docs) {
      final data = doc.data() as Map<String, dynamic>;
      List users = data['users'];

      if (users.contains(otherUserId)) {
        return doc.id;
      }
    }

    final newChat = await _chatRef.add({
      'users': [_uid, otherUserId],
    });

    return newChat.id;
  }

  Future<void> addMessage({
    required String chatId,
    required MessageModel message,
  }) async {
    final doc = _chatRef.doc(chatId);

    await doc.collection('message').add(message.toFirestore());

    final chat = await doc.get();
    final data = chat.data() as Map<String, dynamic>;
    final users = List<String>.from(data['users']);

    Map<String, dynamic> unread = Map<String, dynamic>.from(
      data['unread'] ?? {},
    );

    for (var u in users) {
      if (u != _uid) {
        unread[u] = (unread[u] ?? 0) + 1;
      }
    }

    await doc.update({
      'lastMessage': {
        'idPengirim': message.idPengirim,
        'text': message.text,
        'time': FieldValue.serverTimestamp(),
        'status': message.status,
      },
      'unread': unread,
    });
  }

  Future<void> resetUnread(String chatId) async {
    await _chatRef.doc(chatId).update({'unread.$_uid': 0});
    await markLastAsRead(chatId);

    final snapshot = await _chatRef
        .doc(chatId)
        .collection('message')
        .where('idPengirim', isNotEqualTo: _uid)
        .get();

    final batch = _db.batch();

    for (var doc in snapshot.docs) {
      final data = doc.data();

      if (data['status'] != 1) {
        batch.update(doc.reference, {'status': 1});
      }
    }

    await batch.commit();
  }

  Future<void> markLastAsRead(String chatId) async {
    final doc = _chatRef.doc(chatId);

    final snap = await doc.get();
    final data = snap.data() as Map<String, dynamic>;

    final last = data['lastMessage'];

    if (last['idPengirim'] != _uid) {
      await doc.update({'lastMessage.status': 1});
    }
  }
  
  Stream<int> getUnreadCount(String chatId) {
    return _chatRef.doc(chatId).snapshots().map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final unread = data['unread'] ?? {};
      return unread[_uid] ?? 0;
    });
  }

  Stream<List<MessageModel>> getMessages(String chatId) {
    return _chatRef
        .doc(chatId)
        .collection('message')
        .orderBy('createdAt')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((e) => MessageModel.fromFirestore(e)).toList(),
        );
  }

  Future<void> setTyping(String chatId, bool isTyping) async {
    await _chatRef.doc(chatId).update({'typing.$_uid': isTyping});
  }

  Stream<bool> getTyping(String chatId, String otherUserId) {
    return _chatRef.doc(chatId).snapshots().map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final typing = data['typing'] ?? {};
      return typing[otherUserId] ?? false;
    });
  }

  // Future<void> deleteChat(String chatId) async {
  //   final messages = await _chatRef.doc(chatId).collection('message').get();

  //   for (var doc in messages.docs) {
  //     await doc.reference.delete();
  //   }

  //   await _chatRef.doc(chatId).delete();
  // }

  // Future<void> deleteAllChat() async {
  //   final chats = await _chatRef.where('users', arrayContains: _uid).get();

  //   for (var chat in chats.docs) {
  //     await deleteChat(chat.id);
  //   }
  // }

  Future<void> deleteSelectedChats(List<String> chatIds) async {
  final batch = FirebaseFirestore.instance.batch();

  for (var chatId in chatIds) {
    final chatRef = _chatRef.doc(chatId);

    // ambil semua message di subcollection
    final messages = await chatRef.collection('message').get();

    for (var doc in messages.docs) {
      batch.delete(doc.reference);
    }

    // hapus chat utama
    batch.delete(chatRef);
  }

  await batch.commit();
}
}
