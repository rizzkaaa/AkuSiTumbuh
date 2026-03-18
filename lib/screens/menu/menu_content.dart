import 'package:akusitumbuh/models/menu_model.dart';
import 'package:akusitumbuh/screens/menu/card_menu.dart';
import 'package:akusitumbuh/screens/menu/filter_set.dart';
import 'package:akusitumbuh/screens/menu/search_filter.dart';
import 'package:akusitumbuh/services/menu_service.dart';
import 'package:akusitumbuh/widgets/header_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuContent extends StatefulWidget {
  final int? indexResult;
  const MenuContent({super.key, this.indexResult});

  @override
  State<MenuContent> createState() => _MenuContentState();
}

class _MenuContentState extends State<MenuContent> {
  List<MenuModel> _menuList = [];
  List<MenuModel> _allMenu = [];
  int filterIndex = -1;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filterIndex = widget.indexResult ?? -1;
    final service = MenuService();

    _allMenu = (filterIndex > -1)
        ? service.getMenuByIndex(filterIndex)
        : service.getAllMenu();

    _menuList = _allMenu;
  }

  @override
  Widget build(BuildContext context) {
    int index = filterIndex;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderText(label: "Rekomendari Gizi"),

            SearchFilter(
              controller: _searchController,
              onChanged: (value) {
                final keyword = value.toLowerCase();

                setState(() {
                  _menuList = _allMenu.where((item) {
                    return item.title.toLowerCase().contains(keyword);
                  }).toList();
                });
              },
              onClear: () {
                setState(() {
                  _searchController.clear();
                  _menuList = _allMenu;
                });
              },
              onFiltered: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                  builder: (context) {
                    return FilterSet(
                      index: index,
                      onApply: (value) {
                        final service = MenuService();

                        setState(() {
                          filterIndex = value;

                          _allMenu = (value > -1)
                              ? service.getMenuByIndex(value)
                              : service.getAllMenu();

                          _menuList = _allMenu;
                        });
                      },
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 20),
            _buildListMenu(_menuList),
          ],
        ),
      ),
    );
  }

  Widget _buildListMenu(List<MenuModel> menuList) {
    return Expanded(
      child: menuList.isEmpty
          ? Center(
              child: Text(
                'Tidak ada menu',
                style: GoogleFonts.inriaSerif(
                  color: Color(0xFFD6A7C9),
                  fontSize: 16,
                ),
              ),
            )
          : ListView.builder(
              itemCount: menuList.length,
              itemBuilder: (context, index) {
                final item = menuList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 5,
                  ),
                  child: CardMenu(item: item, index: index),
                );
              },
            ),
    );
  }
}
