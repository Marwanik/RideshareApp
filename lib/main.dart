import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/auth_bloc.dart';
import 'package:rideshare/config/serviceLocater.dart';
import 'package:rideshare/pages/signUp/signupScreen.dart';

void main() {
  setupLocator(); // Initialize the service locator
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(), // Provide the AuthBloc using GetIt
      child: MaterialApp(

        home: SignupScreen(),
      ),
    );
  }
}
