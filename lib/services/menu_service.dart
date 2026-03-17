import 'dart:convert';
import 'package:akusitumbuh/models/menu_model.dart';
import 'package:flutter/services.dart';

class MenuService {
  static final MenuService _instance = MenuService._internal();

  factory MenuService() => _instance;

  MenuService._internal();

  MenuCategoryModel? menus;

  Future<void> loadMenu() async {
    if (menus != null) return;
    String jsonString = await rootBundle.loadString('assets/data/menu.json');

    final jsonData = json.decode(jsonString);

    menus = MenuCategoryModel.fromJson(jsonData);
  }

  List<MenuModel> getAllMenu() {
    if (menus == null) return [];

    return [...menus!.normal, ...menus!.stunting, ...menus!.stuntingBerat];
  }

  List<MenuModel> getMenuByIndex(int index) {
    if (menus == null) return [];

    if (index == 0) return menus!.normal;
    if (index == 1) return menus!.stunting;
    return menus!.stuntingBerat;
  }
}
