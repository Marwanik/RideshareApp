import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/pages/welcome/welcomeScreen.dart';
import 'package:rideshare/repos/HubRepo.dart';
import 'package:rideshare/bloc/Hub/HubBloc.dart';
import 'package:rideshare/pages/home/homeScreen.dart';
import 'package:rideshare/bloc/Login/AuthBlocLogin.dart';
import 'package:rideshare/config/serviceLocater.dart';
import 'package:rideshare/service/HubService.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBlocLogin>(),
        ),
        BlocProvider(
          create: (context) => sl<HubBloc>(),
        ),
      ],
      child: MaterialApp(
        home: WelcomePage(),
      ),
    );
  }
}
