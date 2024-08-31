import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginSignupScreen(),
    );
  }
}

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLogin = true;
                      });
                    },
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isLogin ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLogin = false;
                      });
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isLogin ? Colors.grey : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: isLogin
                      ? 'Log in with your phone number'
                      : 'Sign up with your phone number',
                  prefixText: '123 45 67  ',  // Assuming a fixed phone format
                  suffixIcon: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
              if (!isLogin) ...[
                SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                  ),
                ),
              ],
              Spacer(),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Handle login or signup action
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [Colors.greenAccent, Colors.blueAccent],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        isLogin ? 'Log in' : 'Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
