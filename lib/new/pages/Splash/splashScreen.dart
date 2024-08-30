import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _logoAnimation; // Animation for the logo to slide up

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // Duration for one full rotation and slide up
    );

    // Initialize the animation for sliding the logo from bottom to center
    _logoAnimation = Tween<Offset>(
      begin: const Offset(0, 2), // Start offscreen from the bottom
      end:  const Offset(0, 0.5), // End at its natural position (center)
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut, // Smooth transition effect
    ));

    // Start the animation
    _controller.forward();

    // Add a listener to navigate when animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Navigate to your next screen here after the animation completes
        Future.delayed(Duration(seconds: 2), () {
          // Example of navigation
          Navigator.pushReplacementNamed(context, '/nextScreen'); // Replace with your route
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF009EFD), // Start color of the gradient
              Color(0xFF2AF598), // End color of the gradient
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center, // Center align both widgets in the stack
          children: [
            // Rotating image in the center
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * math.pi, // Rotate the image 360 degrees
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/images/splash/Shape.png', // Path to your shape image
                  width: 150, // Adjust the width and height as needed
                  height: 150,
                ),
              ),
            ),
            // Sliding logo from bottom to center
            SlideTransition(
              position: _logoAnimation,
              child: Image.asset(
                'assets/images/splash/logo.png', // Path to your logo image
                width: 200, // Adjust the width and height as needed
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
