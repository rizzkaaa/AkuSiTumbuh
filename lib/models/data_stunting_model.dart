class DataStuntingModel {
  final int month;
  final int L;
  final double M;
  final double S;

  DataStuntingModel({
    required this.month,
    required this.L,
    required this.M,
    required this.S,
  });

  factory DataStuntingModel.fromJson(Map<String, dynamic> json) {
    return DataStuntingModel(
      month: json['month'],
      L: (json['L'] as num).toInt(),
      M: (json['M'] as num).toDouble(),
      S: (json['S'] as num).toDouble(),
    );
  }
}
