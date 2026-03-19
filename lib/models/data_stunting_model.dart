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

class DataWeightModel {
  final double height;
  final double L;
  final double M;
  final double S;

  DataWeightModel({
    required this.height,
    required this.L,
    required this.M,
    required this.S,
  });

  factory DataWeightModel.fromJson(Map<String, dynamic> json) {
    return DataWeightModel(
      height: (json['Height'] as num).toDouble(),
      L: (json['L'] as num).toDouble(),
      M: (json['M'] as num).toDouble(),
      S: (json['S'] as num).toDouble(),
    );
  }
}
