import 'package:akusitumbuh/extensions/extension.dart';
import 'package:akusitumbuh/models/history_model.dart';
import 'package:akusitumbuh/services/stunting_checking_service.dart';
import 'package:akusitumbuh/widgets/header_text.dart';
import 'package:akusitumbuh/widgets/metal_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryContent extends StatefulWidget {
  const HistoryContent({super.key});

  @override
  State<HistoryContent> createState() => _HistoryContentState();
}

class _HistoryContentState extends State<HistoryContent> {
  final StuntingCheckingService _service = StuntingCheckingService();
  late Future<List<HistoryModel>> historyData;

  @override
  void initState() {
    super.initState();
    historyData = _service.getAllHistory();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            HeaderText(label: 'Riwayat Pertumbuhan'),
            Transform.translate(
              offset: Offset(0, -20),
              child: MetalText(
                text: 'Pantau perkembangan anak dari waktu ke waktu',
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  width: 583,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [Color(0xFFE4E9FD), Color(0xFFFBDDED)],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildHead(),
                      FutureBuilder(
                        future: historyData,
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
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 1.5,
                                horizontal: 2,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(15),
                                ),
                              ),
                              child: Center(
                                child: MetalText(text: 'Belum ada data'),
                              ),
                            );
                          } else {
                            final data = snapshot.data!;

                            return Expanded(
                              child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final history = data[index];
                                  return _buildData(
                                    color: (index + 1) % 2 == 1
                                        ? Colors.white
                                        : (index + 1) % 4 == 0
                                        ? Color(0xFFFFEEFA)
                                        : Color(0xFFDCE7FF),
                                    history: history,
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHead() {
    return Row(
      children: [
        _buildHeadTextStyle(
          label: 'Tanggal Pengecekan',
          width: 100,
          isLeft: true,
        ),
        _buildHeadTextStyle(label: 'Usia (bulan)', width: 100),
        _buildHeadTextStyle(label: 'Tinggi Badan (cm)', width: 100),
        _buildHeadTextStyle(label: 'Berat Badan (kg)', width: 100),
        _buildHeadTextStyle(label: 'Status', width: 150, isRight: true),
      ],
    );
  }

  Widget _buildData({
    bool? isEnd,
    required Color color,
    required HistoryModel history,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.vertical(
          bottom: isEnd != null && isEnd
              ? Radius.circular(15)
              : Radius.circular(0),
        ),
      ),
      child: Row(
        children: [
          _buildDataTextStyle(history.createdAt!.toFormatID(), 100),
          _buildDataTextStyle(history.usia, 100),
          _buildDataTextStyle(history.tb.toString(), 100),
          _buildDataTextStyle(history.bb.toString(), 100),
          _buildDataTextStyle(history.status, 150),
        ],
      ),
    );
  }

  Widget _buildHeadTextStyle({
    required String label,
    required double width,
    bool? isLeft,
    bool? isRight,
  }) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 4),
      width: width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: isLeft != null && isLeft
              ? Radius.circular(15)
              : Radius.circular(0),
          topRight: isRight != null && isRight
              ? Radius.circular(15)
              : Radius.circular(0),
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.libreBodoni(color: Color(0xFF996781)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildDataTextStyle(String label, double width) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1.5),
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: width,
      child: Center(child: MetalText(text: label, size: 15)),
    );
  }
}
