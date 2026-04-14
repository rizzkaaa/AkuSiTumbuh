import 'package:akusitumbuh/screens/chat/chat_screen.dart';
import 'package:akusitumbuh/services/chat_service.dart';
import 'package:akusitumbuh/widgets/gradient_backgtound3.dart';
import 'package:akusitumbuh/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class PaymentSuccess extends StatelessWidget {
  final String dokterID;
  PaymentSuccess({super.key, required this.dokterID});

  final ChatService _service = ChatService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackgtound3(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Lottie.asset(
                  'assets/lottie/check.json',
                  // width: 150,
                  // height: 150,
                  repeat: true,
                ),
              ),
              Text(
                'Pembayaran Berhasil',
                style: GoogleFonts.libreBodoni(
                  color: Color(0xFF996781),
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Transaksi kamu telah berhasil diproses',
                style: GoogleFonts.nanumMyeongjo(color: Color(0xFF686868)),
              ),
              const SizedBox(height: 50),
              GradientButton(
                label: 'Mulai Konsultasi',
                onTap: () async {
                  final roomchatID = await _service.getChatRoom(dokterID);
                  if (context.mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          partnerID: dokterID,
                          roomChatID: roomchatID,
                        ),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
