import 'package:akusitumbuh/extensions/extension.dart';
import 'package:akusitumbuh/models/dokter_anak_model.dart';
import 'package:akusitumbuh/models/user_model.dart';
import 'package:akusitumbuh/screens/profile/edit_profile.dart';
import 'package:akusitumbuh/screens/profile/edit_pw.dart';
import 'package:akusitumbuh/screens/profile/field_data.dart';
import 'package:akusitumbuh/services/auth_service.dart';
import 'package:akusitumbuh/widgets/metal_text.dart';
import 'package:akusitumbuh/widgets/unordered_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart' as inset;
import 'package:akusitumbuh/screens/profile/profile_photo.dart';

class DokterScreen extends StatefulWidget {
  final String userID;
  final String userLevel;
  const DokterScreen({
    super.key,
    required this.userID,
    required this.userLevel,
  });

  @override
  State<DokterScreen> createState() => _DokterScreenState();
}

class _DokterScreenState extends State<DokterScreen> {
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
                            children: [
                              FieldData(
                                width: 80,
                                margin: 0,
                                label: 'Email',
                                value: data.email,
                              ),
                              _buildLine(),
                              FieldData(
                                width: 80,
                                margin: 0,
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
                          final DokterAnakModel data =
                              snapshot.data as DokterAnakModel;
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
                                    dokterAnak: data,
                                  );
                                },
                              );
                              if (result == true) {
                                refresh();
                              }
                            },
                            children: [
                              FieldData(
                                margin: 0,
                                width: 120,
                                label: 'Nama Lengkap',
                                value: data.fullname,
                              ),
                              _buildLine(),

                              FieldData(
                                margin: 0,
                                width: 120,
                                label: 'Nomor STR',
                                value: data.noSTR,
                              ),
                              _buildLine(),

                              FieldData(
                                margin: 0,
                                width: 120,
                                label: 'Tempat Praktik',
                                value: data.tempatPraktik,
                              ),
                              _buildLine(),

                              FieldData(
                                margin: 0,
                                width: 120,
                                label: 'Jam Praktik',
                                value:
                                    "${data.jamMulai.toHHmm()} - ${data.jamSelesai.toHHmm()} WIB",
                              ),
                              _buildLine(),
                              const SizedBox(height: 15),
                              _buildField2(
                                label: 'Pengalaman',
                                child: MetalText(text: '${data.pengalaman}'),
                              ),
                              _buildField2(
                                label: 'Profil',
                                child: MetalText(text: data.profile),
                              ),
                              _buildField2(
                                label: 'Pendidikan',
                                child: Column(
                                  children: data.pendidikan
                                      .map((item) => UnorderedList(text: item))
                                      .toList(),
                                ),
                              ),
                              _buildField2(
                                label: 'Keahlian',
                                child: Column(
                                  children: data.keahlian
                                      .map((item) => UnorderedList(text: item))
                                      .toList(),
                                ),
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
    required List<Widget> children,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 15),
      decoration: inset.BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          inset.BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: Offset(0, -4),
            inset: true,
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...children.map((d) => d),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: onPressed,
              child: Icon(Icons.edit_square, color: Color(0xFF96838D)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField2({required String label, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.libreCaslonText(
              color: Color(0xFF96838D),
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(2),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF94A8CE), Color(0xFFF4D6E7)],
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(color: Colors.white),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLine() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF92A7CD), Color(0xFFF4D6E6)],
        ),
      ),
    );
  }
}
