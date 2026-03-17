import 'package:akusitumbuh/screens/homepage.dart';
import 'package:akusitumbuh/services/menu_service.dart';
import 'package:akusitumbuh/services/stunting_checking_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StuntingCheckingService().loadData();
  await MenuService().loadMenu();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AkuSiTumbuh',
      home: const Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
