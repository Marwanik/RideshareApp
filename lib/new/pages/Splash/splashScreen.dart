import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:rideshare/new/pages/Home/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _logoAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _logoAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: const Offset(0, 0.5),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Start the animation
    _controller.forward();

    // Add a listener to navigate when animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(seconds: 2), () {
          // Navigate to HomeScreen after the animation completes
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
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
              Color(0xFF009EFD),
              Color(0xFF2AF598),
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Rotating image in the center
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * math.pi,
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/images/splash/Shape.png',
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            // Sliding logo from bottom to center
            SlideTransition(
              position: _logoAnimation,
              child: Image.asset(
                'assets/images/splash/logo.png',
                height: 250,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
