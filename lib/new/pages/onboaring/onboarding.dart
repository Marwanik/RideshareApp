import 'package:flutter/material.dart';
import 'package:rideshare/new/pages/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rideshare/new/pages/Home/homeScreen.dart';
import 'package:rideshare/pages/login/loginScreen.dart'; // Adjust the import path to your actual LoginSignupScreen

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: [
                buildOnboardingPage(
                  image: 'assets/images/onBoarding/Locate.png',
                  title: 'Locate',
                  description: 'Exceptuer sint occaecat cupidatat non proident, sunt in culpa qui officia.',
                ),
                buildOnboardingPage(
                  image: 'assets/images/onBoarding/Unlock.png',
                  title: 'Unlock',
                  description: 'Sunt in culpa qui officia deserunt mollit anim id est laborum.',
                ),
                buildOnboardingPage(
                  image: 'assets/images/onBoarding/Ride.png',
                  title: 'Ride',
                  description: 'Culpa qui officia deserunt mollit anim id est laborum.',
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  _pageController.animateToPage(
                    2,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Text('Skip', style: TextStyle(color: Colors.black)),
              ),
              Row(
                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor: _currentPage == index ? Colors.black : Colors.grey,
                    ),
                  );
                }),
              ),
              TextButton(
                onPressed: () async {
                  if (_currentPage < 2) {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    // Save onboarding complete in SharedPreferences
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('onboardingComplete', true);

                    // Check if user is already logged in
                    String? token = prefs.getString('authToken');

                    if (token != null) {
                      // If token exists, navigate to HomeScreen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } else {
                      // If token does not exist, navigate to LoginSignupScreen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginSignupScreen()),
                      );
                    }
                  }
                },
                child: Text('Next', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildOnboardingPage({required String image, required String title, required String description}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: Center(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 16),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
