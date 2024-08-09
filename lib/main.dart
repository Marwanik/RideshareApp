import 'package:flutter/material.dart';
import 'package:rideshare/config/serviceLocater.dart';
import 'package:rideshare/pages/home/homeScreen.dart';
import 'package:rideshare/pages/onBoarding/onboardingScreen.dart';
import 'package:rideshare/widget/button/mainButton.dart';
import 'package:rideshare/widget/listTile/languageListTile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      home:  HomePage(),
    );
  }
}

