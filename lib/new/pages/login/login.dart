import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/Login/AuthBlocLogin.dart';
import 'package:rideshare/bloc/Login/AuthEventLogin.dart';
import 'package:rideshare/bloc/Login/AuthStateLogin.dart';
import 'package:rideshare/bloc/Register/authBlocRegister.dart';
import 'package:rideshare/bloc/Register/authEventRegister.dart';
import 'package:rideshare/bloc/Register/authStateRegister.dart';
import 'package:rideshare/model/loginModel.dart';
import 'package:rideshare/model/registerModel.dart';
import 'package:rideshare/new/pages/Home/homeScreen.dart';
import 'package:rideshare/pages/home/homeScreen.dart';
import 'package:rideshare/widget/button/mainButton.dart';
import 'package:rideshare/widget/checkBox/checkBox.dart';
import 'package:rideshare/widget/dropDown/countrydropDown.dart';
import 'package:rideshare/widget/textField/mainTextFiled.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final PageController _pageController = PageController();
  int selectedIndex = 0;

  // Controllers for login and signup
  TextEditingController loginPhoneController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController signupPhoneController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom Painted Header with Curved Top
            Stack(
              children: [
                CustomPaint(
                  painter: CurvePainter(),
                  child: Container(
                    height: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Change in GestureDetector for "Log in"
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                            _pageController.animateToPage(
                              selectedIndex,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              'Log in',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: selectedIndex == 0 ? Colors.black : Colors.white.withOpacity(0.6),  // Change to black
                              ),
                            ),
                            if (selectedIndex == 0)
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                height: 3,
                                width: 50,
                                color: Colors.black,  // Change to black
                              ),
                          ],
                        ),
                      ),

// Change in GestureDetector for "Sign up"
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                            _pageController.animateToPage(
                              selectedIndex,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              'Sign up',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: selectedIndex == 1 ? Colors.black : Colors.white.withOpacity(0.6),  // Change to black
                              ),
                            ),
                            if (selectedIndex == 1)
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                height: 3,
                                width: 60,
                                color: Colors.black,  // Change to black
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // PageView for Login and Signup pages
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                children: [
                  // Login Page
                  _buildLoginPage(context),
                  // Sign Up Page
                  _buildSignupPage(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginPage(BuildContext context) {
    return BlocListener<AuthBlocLogin, AuthStateLogin>(
      listener: (context, state) async {
        if (state is LoadingLogin) {
          _showLoadingDialog(context);
        } else if (state is SuccessLogin) {
          await _saveUserSession(state.token); // Save the auth token
          Navigator.pop(context); // Close the loading dialog
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()), // Navigate to HomeScreen
          );
        } else if (state is FailedLogin) {
          Navigator.pop(context); // Close the loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              hintText: 'Phone',
              keyboardType: TextInputType.phone,
              controller: loginPhoneController,
            ),
            SizedBox(height: 16),
            CustomTextField(
              hintText: 'Password',
              obscureText: true,
              controller: loginPasswordController,
            ),
            SizedBox(height: 32),
            GestureDetector(
              onTap: () {
                _onLoginButtonPressed(context);
              },
              child: _buildMainButton('Log in'),
            ),
            SizedBox(height: 20),
            // If you don't have an account
            Text(
              "If you don't have an account",
              style: TextStyle(fontSize: 16),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  selectedIndex = 1;
                  _pageController.animateToPage(
                    selectedIndex,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Color(0xFF009EFD), Color(0xFF2AF598)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                child: Text(
                  'Sign Up!',
                  style: TextStyle(fontSize: 16, color: Colors.white),  // Set color to white to blend with ShaderMask
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildSignupPage(BuildContext context) {
    return BlocListener<AuthBlocRegister, AuthStateRegister>(
      listener: (context, state) {
        if (state is LoadingRegister) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Center(child: CircularProgressIndicator()),
          );
        } else if (state is SuccessRegister) {
          Navigator.pop(context); // Close the loading dialog
          // Navigate back to Login Page
          setState(() {
            selectedIndex = 0;
            _pageController.animateToPage(
              selectedIndex,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        } else if (state is FailedRegister) {
          Navigator.pop(context); // Close the loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 50),
            CustomTextField(
              hintText: 'First Name',
              controller: firstnameController,
            ),
            SizedBox(height: 16),
            CustomTextField(
              hintText: 'Last Name',
              controller: lastnameController,
            ),
            SizedBox(height: 16),
            CustomCountryCodePicker(
              hintText: 'Your mobile number',
              Controller: signupPhoneController,
            ),
            SizedBox(height: 16),
            CustomTextField(
              hintText: 'UserName',
              keyboardType: TextInputType.name,
              controller: userNameController,
            ),
            SizedBox(height: 16),
            CustomTextField(
              hintText: 'Birth Date',
              keyboardType: TextInputType.text,
              controller: birthDateController,
            ),
            SizedBox(height: 16),
            CustomTextField(
              hintText: 'Password',
              obscureText: true,
              controller: signupPasswordController,
            ),
            SizedBox(height: 16),
            CustomTextField(
              hintText: 'Confirm Password',
              obscureText: true,
              controller: confirmPasswordController,
            ),
            SizedBox(height: 16),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                _onSignupButtonPressed(context);
              },
              child: _buildMainButton('Sign up'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMainButton(String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [Color(0xFF009EFD), Color(0xFF2AF598)],
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _onLoginButtonPressed(BuildContext context) {
    final user = LoginModel(
      phone: loginPhoneController.text.trim(),
      password: loginPasswordController.text.trim(),
    );

    context.read<AuthBlocLogin>().add(Login(user));
  }

  void _onSignupButtonPressed(BuildContext context) {
    final user = RegisterModel(
      firstName: firstnameController.text.trim(),
      lastName: lastnameController.text.trim(),
      phone: signupPhoneController.text.trim(),
      username: userNameController.text.trim(),
      birthDate: birthDateController.text.trim(),
      password: signupPasswordController.text.trim(),
      confirmPassword: confirmPasswordController.text.trim(),
    );

    context.read<AuthBlocRegister>().add(SignUp(user));
  }

  Future<void> _saveUserSession(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token); // Save the auth token in shared preferences
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
  }
}

// CustomPainter to create the curved design at the top
class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [Color(0xFF009EFD), Color(0xFF2AF598)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(250, 100, size.width, 100);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
