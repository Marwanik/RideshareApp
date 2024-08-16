
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rideshare/bloc/Login/AuthBlocLogin.dart';
import 'package:rideshare/bloc/authBlocRegister.dart';
import 'package:rideshare/repos/AuthRepoLogin.dart';
import 'package:rideshare/repos/AuthRepoRegister.dart';
import 'package:rideshare/service/AuthServiceLogin.dart';
import 'package:rideshare/service/authServiceRegister.dart';



final GetIt sl = GetIt.instance;

void setupLocator() {
  sl.registerLazySingleton<Dio>(() => Dio());

  // Registering for registration
  sl.registerLazySingleton<AuthServiceRegister>(() => AuthServiceRegisterImpl(sl<Dio>()));
  sl.registerLazySingleton<AuthRepoRegister>(() => AuthRepoRegister(sl<AuthServiceRegister>()));
  sl.registerFactory<AuthBlocRegister>(() => AuthBlocRegister(sl<AuthRepoRegister>()));

  // Registering for login
  sl.registerLazySingleton<AuthServiceLogin>(() => AuthServiceLoginImpl(sl<Dio>()));
  sl.registerLazySingleton<AuthRepoLogin>(() => AuthRepoLogin(sl<AuthServiceLogin>()));
  sl.registerFactory<AuthBlocLogin>(() => AuthBlocLogin(sl<AuthRepoLogin>()));
}
