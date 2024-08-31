import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingScreen(),
    );
  }
}

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
                  image:
                      'assets/images/onboarding/Locate.png', // Replace with your image path
                  title: 'Locate',
                  description:
                      'Exceptuer sint occaecat cupidatat non proident, sunt in culpa qui officia.',
                ),
                buildOnboardingPage(
                  image:
                      'assets/images/onboarding/Unlock.png', // Replace with your image path
                  title: 'Unlock',
                  description:
                      'Sunt in culpa qui officia deserunt mollit anim id est laborum.',
                ),
                buildOnboardingPage(
                  image:
                      'assets/images/onboarding/Ride.png', // Replace with your image path
                  title: 'Ride',
                  description:
                      'Culpa qui officia deserunt mollit anim id est laborum.',
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
                    2, // Index of the last page (third page in this case)
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Row(
                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor:
                          _currentPage == index ? Colors.black : Colors.grey,
                    ),
                  );
                }),
              ),
              TextButton(
                onPressed: () {
                  if (_currentPage < 2) {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    // Navigate to the next screen or complete the onboarding
                  }
                },
                child: Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildOnboardingPage(
      {required String image,
      required String title,
      required String description}) {
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
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
