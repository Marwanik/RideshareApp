import 'package:flutter/material.dart';
import 'package:rideshare/pages/onBoarding/onboardingScreen.dart';
import 'package:rideshare/widget/button/mainButton.dart';
import 'package:rideshare/widget/listTile/languageListTile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,
      home:  OnboardingPage(),
    );
  }
}


class ChangeLanguagePage extends StatelessWidget {
  final List<Map<String, String>> languages = [
    {"name": "English", "subtext": "English", "flag": "assets/flags/us.png"},
    {"name": "Hindi", "subtext": "Hindi", "flag": "assets/flags/in.png"},
    {"name": "Arabic", "subtext": "Arabic", "flag": "assets/flags/sa.png"},
    {"name": "French", "subtext": "French", "flag": "assets/flags/fr.png"},
    {"name": "German", "subtext": "German", "flag": "assets/flags/de.png"},
    {"name": "Portuguese", "subtext": "Portuguese", "flag": "assets/flags/pt.png"},
    {"name": "Turkish", "subtext": "Turkish", "flag": "assets/flags/tr.png"},
    {"name": "Dutch", "subtext": "Nederlands", "flag": "assets/flags/nl.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Language', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final language = languages[index];
                  return LanguageTile(
                    name: language['name']!,
                    subtext: language['subtext']!,
                    flagPath: language['flag']!,
                    isSelected: index == 0, // Change this logic as per your requirement
                  );
                },
              ),
            ),
            CustomFilledButton(
              text: 'Save',
              onPressed: () {
                // Handle save action
              },
            ),
          ],
        ),
      ),
    );
  }
}
