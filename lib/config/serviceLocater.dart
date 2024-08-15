import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:rideshare/service/authService.dart';
import 'package:rideshare/repos/authRepo.dart';
import 'package:rideshare/bloc/auth_bloc.dart';

final GetIt sl = GetIt.instance;

void setupLocator() {

  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<AuthService>(() => AuthServiceImpl(sl<Dio>()));
  sl.registerLazySingleton<AuthRepo>(() => AuthRepo(sl<AuthService>()));
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl<AuthRepo>()));
}
