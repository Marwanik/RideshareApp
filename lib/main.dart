import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/Login/AuthBlocLogin.dart';
import 'package:rideshare/bloc/authBlocRegister.dart';
import 'package:rideshare/config/serviceLocater.dart';

import 'package:rideshare/pages/signUp/signupScreen.dart';
import 'package:rideshare/pages/welcome/welcomeScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBlocLogin>(), // Provide the AuthBloc using GetIt
      child: MaterialApp(

        home: WelcomePage(),
      ),
    );
  }
}

