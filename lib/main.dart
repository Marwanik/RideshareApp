// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rideshare/bloc/Register/authBlocRegister.dart';
// import 'package:rideshare/bloc/bisycle/bisycle_bloc.dart';
// import 'package:rideshare/bloc/category/category_bloc.dart';
// import 'package:rideshare/bloc/changePassword/change_password_bloc.dart';
// import 'package:rideshare/bloc/getBicycles/get_bicycles_bloc.dart';
// import 'package:rideshare/bloc/policy/policy_bloc.dart';
// import 'package:rideshare/bloc/wallet/wallet_bloc.dart';
// import 'package:rideshare/new/pages/Home/homeScreen.dart';
// import 'package:rideshare/new/pages/Splash/splashScreen.dart';
// import 'package:rideshare/new/pages/login/login.dart';
// import 'package:rideshare/pages/login/loginScreen.dart';
// import 'package:rideshare/pages/onBoarding/onboardingScreen.dart';
// import 'package:rideshare/pages/welcome/welcomeScreen.dart';
// import 'package:rideshare/repos/HubRepo.dart';
// import 'package:rideshare/bloc/Hub/HubBloc.dart';
// import 'package:rideshare/pages/home/homeScreen.dart';
// import 'package:rideshare/bloc/Login/AuthBlocLogin.dart';
// import 'package:rideshare/config/serviceLocater.dart';
// import 'package:rideshare/repos/categoryRepo.dart';
// import 'package:rideshare/service/HubService.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   setupLocator();
//
//   final prefs = await SharedPreferences.getInstance();
//   final bool onboardingComplete = prefs.getBool('onboardingComplete') ?? false;
//
//   runApp(MyApp(showOnboarding: !onboardingComplete));
// }
//
// class MyApp extends StatelessWidget {
//   final bool showOnboarding;
//
//   MyApp({required this.showOnboarding});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => sl<AuthBlocRegister>()
//         ),
//         BlocProvider(
//           create: (context) => sl<AuthBlocLogin>(),
//         ),
//         BlocProvider(
//           create: (context) => sl<HubBloc>(),
//         ),
//         BlocProvider(
//           create: (context) => sl<CategoryBloc>(),
//         ),
//         BlocProvider(
//           create: (context) => sl<BicycleBloc>(),
//         ),
//         BlocProvider(
//           create: (context) => sl<WalletBloc>(),
//         ),
//         BlocProvider(
//           create: (context) => sl<PolicyBloc>(), // Add PolicyBloc provider
//         ),
//         BlocProvider(
//           create: (context) => sl<ChangePasswordBloc>(), // Add ChangePasswordBloc provider
//         ),
//         BlocProvider(
//           create: (context) => sl<GetBicycleBloc>(),
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: showOnboarding ? OnboardingPage() : HomeScreen(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rideshare/config/serviceLocater.dart';
import 'package:rideshare/new/pages/Home/homeScreen.dart';
import 'package:rideshare/new/pages/Splash/splashScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/Login/AuthBlocLogin.dart';
import 'package:rideshare/bloc/Register/authBlocRegister.dart';
import 'package:rideshare/bloc/bisycle/bisycle_bloc.dart';
import 'package:rideshare/bloc/category/category_bloc.dart';
import 'package:rideshare/bloc/changePassword/change_password_bloc.dart';
import 'package:rideshare/bloc/getBicycles/get_bicycles_bloc.dart';
import 'package:rideshare/bloc/policy/policy_bloc.dart';
import 'package:rideshare/bloc/wallet/wallet_bloc.dart';
import 'package:rideshare/bloc/Hub/HubBloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator(); // Setup dependency injection
  final prefs = await SharedPreferences.getInstance();
  final bool onboardingComplete = prefs.getBool('onboardingComplete') ?? false;
  final String? token = prefs.getString('token'); // Check for login token

  runApp(MyApp(
    showOnboarding: !onboardingComplete,
    hasToken: token != null,
  ));
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;
  final bool hasToken;

  MyApp({required this.showOnboarding, required this.hasToken});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthBlocRegister>()),
        BlocProvider(create: (context) => sl<AuthBlocLogin>()),
        BlocProvider(create: (context) => sl<HubBloc>()),
        BlocProvider(create: (context) => sl<CategoryBloc>()),
        BlocProvider(create: (context) => sl<BicycleBloc>()),
        BlocProvider(create: (context) => sl<WalletBloc>()),
        BlocProvider(create: (context) => sl<PolicyBloc>()),
        BlocProvider(create: (context) => sl<ChangePasswordBloc>()),
        BlocProvider(create: (context) => sl<GetBicycleBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(
          showOnboarding: showOnboarding,
          hasToken: hasToken,
        ),
      ),
    );
  }
}
