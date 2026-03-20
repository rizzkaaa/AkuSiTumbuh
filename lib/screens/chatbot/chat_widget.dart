import 'package:akusitumbuh/widgets/typing_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/icon_bot2.png',
                              width: 30,
                            ),
                            const SizedBox(width: 10),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 230),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFDC8DB7)),
                                ),
                                child: Text(
                                  'ini aku dsjfns df dhfus  sduf sf h fs dfs fsdduf fggsdfgsdf f  dfus dfsd f',
                                  style: GoogleFonts.poppins(
                                    color: Color(0xFFDC8DB7),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 230),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFDC8DB7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'ini aku dsjfns df dhfus  sduf sf h fs dfs fsdduf fggsdfgsdf f  dfus dfsd f',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/icon_bot2.png',
                              width: 30,
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Color(0xFFDC8DB7)),
                              ),
                              child: TypingIndicator(color: Color(0xFFDC8DB7)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
  }
}