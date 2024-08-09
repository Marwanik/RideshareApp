import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rideshare/bloc/auth_bloc.dart';
import 'package:rideshare/repos/authRepo.dart';
import 'package:rideshare/service/authService.dart';

GetIt locater = GetIt.instance;

setup() {
  locater.registerSingleton(Dio());

  locater.registerSingleton(AuthService(locater.get()));

  locater.registerSingleton(AuthRepo(locater.get()));

  locater.registerSingleton(AuthBloc(locater.get()));
}