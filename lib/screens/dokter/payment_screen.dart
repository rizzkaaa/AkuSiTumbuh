import 'package:akusitumbuh/screens/dokter/payment_success.dart';
import 'package:akusitumbuh/widgets/custom_back_button.dart';
import 'package:akusitumbuh/widgets/gradient_background.dart';
import 'package:akusitumbuh/widgets/gradient_button_3d.dart';
import 'package:akusitumbuh/widgets/header_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentScreen extends StatefulWidget {
  final String dokterID;
  const PaymentScreen({super.key, required this.dokterID});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final List<String> banks = [
    'Bank Mandiri',
    'Bank BCA',
    'Bank BSI',
    'Bank BRI',
  ];
  String selectedValue = 'Transfer Bank';
  String selectedBank = 'Bank Mandiri';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  CustomBackButton(),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: HeaderText(label: 'Pembayaran'),
                  ),
                ],
              ),
              Text(
                'Metode Pembayaran:',
                style: GoogleFonts.libreCaslonText(
                  color: Color(0xFF996781),
                  fontSize: 12,
                ),
              ),
              RadioGroup<String>(
                groupValue: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value!;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio<String>(
                          value: 'Transfer Bank',
                          activeColor: Color(0xFF996781),
                          side: BorderSide(color: Color(0xFF996781), width: 2),
                        ),
                        Text(
                          'Transfer Bank',
                          style: GoogleFonts.libreCaslonText(
                            color: Color(0xFF996781),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio<String>(
                          value: 'E-Wallet',
                          activeColor: Color(0xFF996781),
                          side: BorderSide(color: Color(0xFF996781), width: 2),
                        ),
                        Text(
                          'E-Wallet',
                          style: GoogleFonts.libreCaslonText(
                            color: Color(0xFF996781),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: selectedValue == "Transfer Bank"
                      ? _buildTfState()
                      : _buildEWalletState(),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                child: GradientButton3d(
                  isLoading: false,
                  text: 'Bayar',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentSuccess(dokterID: widget.dokterID,)),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEWalletState() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xFFE4E9FD),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'SCAN ME',
              style: GoogleFonts.libreBodoni(
                color: Color(0xFF996781),
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset('assets/images/QR.png', width: 210),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Pembayaran lebih mudah dengan menggunakan E-Wallet',
                style: GoogleFonts.nanumMyeongjo(
                  color: Color(0xFF686868),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTfState() {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFFE4E9FD),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Card Information",
                style: GoogleFonts.libreCaslonText(
                  color: Color(0xFF996781),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),

              _cardField(
                "2458 0893 2983 5092",
                trailing: "VISA",
                isFully: true,
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(child: _cardField("MM/YY")),
                  const SizedBox(width: 8),
                  Expanded(child: _cardField("CVC", icon: Icons.credit_card)),
                ],
              ),
            ],
          ),
        ),

        RadioGroup<String>(
          groupValue: selectedBank,
          onChanged: (value) {
            setState(() {
              selectedBank = value!;
            });
          },
          child: Column(
            children: banks
                .map(
                  (bank) => Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Color(0xFF92A7CD), Color(0xFFFFC9E6)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: Offset(5, 10),
                        ),
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            bank,
                            style: GoogleFonts.libreCaslonText(
                              color: Color(0xFF996781),
                              fontSize: 15,
                            ),
                          ),
                          Radio<String>(
                            value: bank,
                            activeColor: Color(0xFF996781),
                            side: BorderSide(
                              color: Color(0xFF996781),
                              width: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _cardField(
    String hint, {
    String? trailing,
    IconData? icon,
    bool isFully = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              hint,
              style: GoogleFonts.nanumMyeongjo(
                color: isFully ? Color(0xFF686868) : Color(0xFFD9D9D9),
              ),
            ),
          ),
          if (trailing != null)
            Text(
              trailing,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A2A6C),
                fontSize: 20,
              ),
            ),
          if (icon != null) Icon(icon, size: 16, color: Color(0xFF9AA0B4)),
        ],
      ),
    );
  }
}
