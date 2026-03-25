import 'package:akusitumbuh/firebase_options.dart';
import 'package:akusitumbuh/screens/splash_screen.dart';
import 'package:akusitumbuh/services/menu_service.dart';
import 'package:akusitumbuh/services/stunting_checking_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env", isOptional: false);

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
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
