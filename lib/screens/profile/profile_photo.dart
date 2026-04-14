import 'dart:io';
import 'package:akusitumbuh/extensions/extension.dart';
import 'package:akusitumbuh/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePhoto extends StatefulWidget {
  final String? photo;
  final VoidCallback refresh;
  const ProfilePhoto({super.key, this.photo, required this.refresh});

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  bool _showCameraIcon = false;
  File? _image;
  final ImagePicker _picker = ImagePicker();

   Future<void> _pickImage() async {

    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 500,
      maxHeight: 500,
      imageQuality: 60,
    );

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileSize = await file.length();

      print("📁 File size: ${fileSize / 1024} KB");

      if (fileSize > 500 * 1024) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gambar terlalu besar, pilih gambar lain')),
        );
        return;
      }

      setState(() {
        _image = file;
      });
    }
  }

 @override
  Widget build(BuildContext context) {
    final AuthService service = AuthService();
    return GestureDetector(
      onTap: () {
        setState(() {
          _showCameraIcon = !_showCameraIcon;
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 10),
            ),
            child: widget.photo == null
                ? CircularProgressIndicator(color: Color(0xFF96838D))
                : CircleAvatar(
                    radius: 55,
                    backgroundImage: (widget.photo.toString().isNotEmpty)
                        ? widget.photo!.toImageProvider()
                        : AssetImage('assets/images/default-profile.png')
                              as ImageProvider,
                  ),
          ),

          AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: _showCameraIcon ? 1 : 0,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: 0.4),
              ),
            ),
          ),

          AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: _showCameraIcon ? 1 : 0,
            child: AnimatedScale(
              duration: Duration(milliseconds: 300),
              scale: _showCameraIcon ? 1 : 0,
              curve: Curves.easeOutBack,
              child: IgnorePointer(
                ignoring: !_showCameraIcon,
                child: Container(
                  width: 37,
                  height: 37,
                  decoration: BoxDecoration(
                    color: Color(0xFFCCDDFB),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      print("klik kamera!");

                      await _pickImage();

                      if (_image != null) {
                        await service.uploadPhoto(_image!);
                        widget.refresh();
                      setState(() {
                        _showCameraIcon = false;
                      });
                      }
                    },
                    icon: Icon(Icons.camera_alt, color: Colors.white, size: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
