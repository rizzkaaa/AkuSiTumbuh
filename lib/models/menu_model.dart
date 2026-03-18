class MenuModel {
  final String title;
  final String image;
  final List<String> bahanUtama;
  final List<String> bumbudanBahanTambahan;
  final List<CaraMasakModel> caraMasak;
  final List<String> manfaatGizi;

  MenuModel({
    required this.title,
    required this.image,
    required this.bahanUtama,
    required this.bumbudanBahanTambahan,
    required this.caraMasak,
    required this.manfaatGizi,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      title: json['title'],
      image: json['image'],
      bahanUtama: List<String>.from(json['bahanUtama']),
      bumbudanBahanTambahan: List<String>.from(json['bumbudanBahanTambahan']),
      caraMasak: (json['caraMasak'] as List)
          .map((e) => CaraMasakModel.fromJson(e))
          .toList(),
      manfaatGizi: List<String>.from(json['manfaatGizi']),
    );
  }
}

class CaraMasakModel {
  final String label;
  final List langkah;

  CaraMasakModel({required this.label, required this.langkah});

  factory CaraMasakModel.fromJson(Map<String, dynamic> json) {
    return CaraMasakModel(
      label: json['label'],
      langkah: List<String>.from(json['langkah']),
    );
  }
}

class MenuCategoryModel {
  final List<MenuModel> normal;
  final List<MenuModel> stunting;
  final List<MenuModel> stuntingBerat;

  MenuCategoryModel({
    required this.normal,
    required this.stunting,
    required this.stuntingBerat,
  });

  factory MenuCategoryModel.fromJson(Map<String, dynamic> json) {
    return MenuCategoryModel(
      normal: (json['normal'] as List)
          .map((e) => MenuModel.fromJson(e))
          .toList(),

      stunting: (json['stunting'] as List)
          .map((e) => MenuModel.fromJson(e))
          .toList(),

      stuntingBerat: (json['stunting_berat'] as List)
          .map((e) => MenuModel.fromJson(e))
          .toList(),
    );
  }
}
