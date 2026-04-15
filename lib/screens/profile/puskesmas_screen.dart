import 'package:akusitumbuh/extensions/extension.dart';
import 'package:akusitumbuh/models/puskesmas_model.dart';
import 'package:akusitumbuh/models/user_model.dart';
import 'package:akusitumbuh/screens/profile/edit_profile.dart';
import 'package:akusitumbuh/screens/profile/edit_pw.dart';
import 'package:akusitumbuh/screens/profile/field_data.dart';
import 'package:akusitumbuh/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart' as inset;
import 'package:akusitumbuh/screens/profile/profile_photo.dart';

class PuskesmasScreen extends StatefulWidget {
  final String userID;
  final String userLevel;
  const PuskesmasScreen({
    super.key,
    required this.userID,
    required this.userLevel,
  });

  @override
  State<PuskesmasScreen> createState() => _PuskesmasScreenState();
}

class _PuskesmasScreenState extends State<PuskesmasScreen> {
  final AuthService _service = AuthService();
  late Future<UserModel> userData;
  late Future<dynamic> profileData;

  @override
  void initState() {
    super.initState();
    userData = _service.getAccount();
    profileData = _service.getProfile(widget.userLevel);
  }

  void refresh() {
    setState(() {
      profileData = _service.getProfile(widget.userLevel);
    });
  }

  void refreshPhoto() {
    setState(() {
      userData = _service.getAccount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Text(
                widget.userLevel,
                style: GoogleFonts.kumarOne(
                  color: Color(0xFFCEAABD),
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),

              Expanded(
                child: ListView(
                  children: [
                    FutureBuilder(
                      future: userData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFFCEAABD),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("Error: ${snapshot.error}"),
                          );
                        } else {
                          final data = snapshot.data!;

                          return _buildCard(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(child: EditPw());
                                },
                              );
                            },
                            title: 'Data Akun',
                            data: [
                              FieldData(
                                width: 80,
                                label: 'Email',
                                value: data.email,
                              ),

                              FieldData(
                                width: 80,
                                label: 'Password',
                                isPwField: true,
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 15),

                    FutureBuilder(
                      future: profileData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFFCEAABD),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("Error: ${snapshot.error}"),
                          );
                        } else {
                          final PuskesmasModel data =
                              snapshot.data as PuskesmasModel;
                          return _buildCard(
                            onPressed: () async {
                              final result = await showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(50),
                                  ),
                                ),
                                builder: (context) {
                                  return EditProfile(
                                    role: widget.userLevel,
                                    puskesmas: data,
                                  );
                                },
                              );
                              if (result == true) {
                                refresh();
                              }
                            },
                            title: 'Data Anak',
                            data: [
                              FieldData(
                                width: 110,
                                label: 'Nama',
                                value: data.puskesmasName,
                              ),
                              FieldData(
                                width: 110,
                                label: 'Domisili',
                                value: data.domisili.fullAlamat.capitalize()
                              ),
                             
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        FutureBuilder<UserModel>(
          future: userData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            }

            return Positioned(
              top: -65,
              child: ProfilePhoto(
                photo: snapshot.data!.photo,
                refresh: refreshPhoto,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCard({
    required String title,
    required List<Widget> data,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: inset.BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          inset.BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: Offset(0, 4),
            inset: true,
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFCCDDFB), Color(0xFFE4E9FD), Color(0xFFFBDDED)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.libreCaslonText(
                  color: Color(0xFF96838D),
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.edit_square, color: Color(0xFF96838D)),
              ),
            ],
          ),
          ...data.map((d) => d),
        ],
      ),
    );
  }
}
