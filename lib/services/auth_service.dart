import 'dart:io';
import 'dart:convert';
import 'package:akusitumbuh/models/dokter_anak_model.dart';
import 'package:akusitumbuh/models/orang_tua_model.dart';
import 'package:akusitumbuh/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _ref = FirebaseFirestore.instance;

  Future<String?> register({
    required String role,
    required String email,
    required String password,
    OrangTuaModel? orangTua,
    DokterAnakModel? dokterAnak,
  }) async {
    final userCheck = await _ref
        .collection('users')
        .where("email", isEqualTo: email)
        .limit(1)
        .get();

    if (userCheck.docs.isNotEmpty) return "Email telah di gunakan";

    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = UserModel(
        email: email,
        role: role,
        photo: '',
        isNew: true,
        createdAt: DateTime.now(),
      );
      await _ref
          .collection('users')
          .doc(cred.user!.uid)
          .set(user.toFirestore());

      if (role == "Orang Tua") {
        await _ref
            .collection('orang_tua')
            .doc(cred.user!.uid)
            .set(orangTua!.toFirestore());
      } else {
        await _ref
            .collection('dokter_anak')
            .doc(cred.user!.uid)
            .set(dokterAnak!.toFirestore());
      }

      return null;
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = cred.user!.uid;
      final userDoc = await _ref.collection('users').doc(uid).get();

      if (!userDoc.exists) {
        await logout();
        return "Pengguna tidak ditemukan";
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', uid);
      await prefs.setString('userLevel', userDoc["role"]);

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<UserModel> getAccount() async {
    final uid = _auth.currentUser!.uid;
    final doc = await _ref.collection('users').doc(uid).get();
    return UserModel.fromFirestore(doc);
  }

  Future<dynamic> getProfile(String role) async {
    final uid = _auth.currentUser!.uid;
    if (role == "Orang Tua") {
      final doc = await _ref.collection('orang_tua').doc(uid).get();
      return OrangTuaModel.fromFirestore(doc);
    } else {
      final doc = await _ref.collection('dokter_anak').doc(uid).get();
      return DokterAnakModel.fromFirestore(doc);
    }
  }

  Future<UserModel> getPhotoDokter(String id) async {
    final doc = await _ref.collection('users').doc(id).get();
    return UserModel.fromFirestore(doc);
  }

  Future<List<DokterAnakModel>> getAllDoctors() async {
    final snapshot = await _ref.collection('dokter_anak').get();
    return snapshot.docs
        .map((doc) => DokterAnakModel.fromFirestore(doc))
        .toList();
  }

  Future<String?> updateProfile({
    required String role,
    DokterAnakModel? dokterAnak,
    OrangTuaModel? orangTua,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return ("Pengguna belum login");

    try {
      if (role == "Orang Tua") {
        await _ref
            .collection('orang_tua')
            .doc(user.uid)
            .update(orangTua!.toFirestore());
      } else {
        await _ref
            .collection('dokter_anak')
            .doc(user.uid)
            .update(dokterAnak!.toFirestore());
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateStatus() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("Pengguna belum login");

    await _ref.collection('users').doc(user.uid).update({"isNew": false});
  }

  Future<String?> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final user = _auth.currentUser!;
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );

      print(user.email);
      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code.contains('credential')) {
        return "Password lama salah";
      }

      if (e.code == 'weak-password') {
        return "Password baru terlalu lemah";
      }

      if (e.code == 'requires-recent-login') {
        return "Silakan login ulang";
      }

      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> uploadPhoto(File image) async {
    try {
      final uid = _auth.currentUser!.uid;

      final bytes = await image.readAsBytes();

      final base64Image = base64Encode(bytes);

      await _ref.collection('users').doc(uid).update({"photo": base64Image});
      print("✅ Photo saved to Firestore!");
      return null;
    } catch (e) {
      print("❌ UPLOAD ERROR: $e");
      return "❌ UPLOAD ERROR: $e";
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await _auth.signOut();
  }
}
