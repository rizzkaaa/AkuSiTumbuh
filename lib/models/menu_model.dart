class MenuModel {
  final String title;
  final String image;

  MenuModel({
    required this.title,
    required this.image,
  });

   factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      title: json['title'],
      image: json['image'],
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
