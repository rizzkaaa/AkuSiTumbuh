import 'package:akusitumbuh/extensions/extension.dart';
import 'package:akusitumbuh/models/user_model.dart';
import 'package:akusitumbuh/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomePhoto extends StatefulWidget {
  const HomePhoto({super.key});

  @override
  State<HomePhoto> createState() => _HomePhotoState();
}

class _HomePhotoState extends State<HomePhoto> {
  final AuthService _service = AuthService();
  late Future<UserModel> userData;

  @override
  void initState() {
    super.initState();
    userData = _service.getAccount();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: userData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(color: Color(0xFF96838D));
        }

        return CircleAvatar(
          radius: 25,
          backgroundImage: (snapshot.data!.photo.toString().isNotEmpty)
              ? snapshot.data!.photo.toImageProvider()
              : AssetImage('assets/images/default-profile.png')
                    as ImageProvider,
        );
      },
    );
  }
}
