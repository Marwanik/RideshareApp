import 'package:flutter/material.dart';
import 'package:rideshare/pages/onBoarding/onboardingContent.dart';
import 'package:rideshare/pages/welcome/welcomeScreen.dart';
import 'package:rideshare/widget/button/onBoardingButton.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Widget> _buildPages() {
    return [
      OnboardingContent(
        imagePath: 'assets/images/onBoarding/on1.png',
        title: 'Anywhere you are',
        description: 'Sell houses easily with the help of Listenoryx and to make this line big I am writing more.',
      ),
      OnboardingContent(
        imagePath: 'assets/images/onBoarding/on2.png',
        title: 'At anytime',
        description: 'Sell houses easily with the help of Listenoryx and to make this line big I am writing more.',
      ),
      OnboardingContent(
        imagePath: 'assets/images/onBoarding/on3.png',
        title: 'Book your car',
        description: 'Sell houses easily with the help of Listenoryx and to make this line big I am writing more.',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (_currentPage != _buildPages().length - 1)
                TextButton(
                  onPressed: () {
                    _pageController.animateToPage(
                      _buildPages().length - 1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  child: Text("Skip"),
                ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: _buildPages(),
            ),
          ),
          SizedBox(height: 20.0),
          CircularProgressButton(
            icon: _currentPage == _buildPages().length - 1 ? null : Icons.arrow_forward,
            label: _currentPage == _buildPages().length - 1 ? 'Go' : '',
            onPressed: () {
              if (_currentPage == _buildPages().length - 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomePage()),
                );
              } else {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              }
            },
            progress: (_currentPage + 1) / _buildPages().length,
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}