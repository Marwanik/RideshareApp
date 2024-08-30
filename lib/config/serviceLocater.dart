import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rideshare/bloc/Hub/HubBloc.dart';
import 'package:rideshare/bloc/Login/AuthBlocLogin.dart';
import 'package:rideshare/bloc/Register/authBlocRegister.dart';
import 'package:rideshare/bloc/bisycle/bisycle_bloc.dart';
import 'package:rideshare/bloc/category/category_bloc.dart';
import 'package:rideshare/bloc/changePassword/change_password_bloc.dart';
import 'package:rideshare/bloc/policy/policy_bloc.dart';
import 'package:rideshare/bloc/wallet/wallet_bloc.dart';

import 'package:rideshare/repos/AuthRepoLogin.dart';
import 'package:rideshare/repos/AuthRepoRegister.dart';
import 'package:rideshare/repos/HubRepo.dart';
import 'package:rideshare/repos/bisycleRepo.dart';
import 'package:rideshare/repos/categoryRepo.dart';
import 'package:rideshare/repos/changePasswordRepo.dart';
import 'package:rideshare/repos/policyRepo.dart';
import 'package:rideshare/repos/walletRepo.dart';
import 'package:rideshare/service/AuthServiceLogin.dart';
import 'package:rideshare/service/HubService.dart';
import 'package:rideshare/service/authServiceRegister.dart';
import 'package:rideshare/service/bisycleService.dart';
import 'package:rideshare/service/categoryService.dart';
import 'package:rideshare/service/changePasswordService.dart';
import 'package:rideshare/service/policyService.dart';
import 'package:rideshare/service/walletService.dart';

final GetIt sl = GetIt.instance;

void setupLocator() {
  // Register Dio
  sl.registerLazySingleton<Dio>(() => Dio());
  // Registering for registration
  sl.registerLazySingleton<AuthServiceRegister>(() => AuthServiceRegisterImpl(sl<Dio>()));
  sl.registerLazySingleton<AuthRepoRegister>(() => AuthRepoRegister(sl<AuthServiceRegister>()));
  sl.registerFactory<AuthBlocRegister>(() => AuthBlocRegister(sl<AuthRepoRegister>()));

  // Registering for login
  sl.registerLazySingleton<AuthServiceLogin>(() => AuthServiceLoginImpl(sl<Dio>()));
  sl.registerLazySingleton<AuthRepoLogin>(() => AuthRepoLogin(sl<AuthServiceLogin>()));
  sl.registerFactory<AuthBlocLogin>(() => AuthBlocLogin(sl<AuthRepoLogin>()));

  // Registering HubService
  sl.registerLazySingleton<HubService>(() => HubService(sl<Dio>()));
  sl.registerLazySingleton<HubRepository>(() => HubRepository(sl<HubService>()));
  sl.registerFactory<HubBloc>(() => HubBloc(sl<HubRepository>()));

  // Registering Category
  sl.registerLazySingleton<CategoryService>(() => CategoryService(sl<Dio>()));
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepository(sl<CategoryService>()));
  sl.registerFactory<CategoryBloc>(() => CategoryBloc(sl<CategoryRepository>()));

  // Registering Bicycle
  sl.registerLazySingleton<BicycleService>(() => BicycleService(sl<Dio>()));
  sl.registerLazySingleton<BicycleRepository>(() => BicycleRepository(sl<BicycleService>()));
  sl.registerFactory<BicycleBloc>(() => BicycleBloc(sl<BicycleRepository>()));

  // Registering Wallet
  sl.registerLazySingleton<WalletService>(() => WalletService(sl<Dio>()));
  sl.registerLazySingleton<WalletRepository>(() => WalletRepository(sl<WalletService>()));
  sl.registerFactory<WalletBloc>(() => WalletBloc(sl<WalletRepository>()));

  // Registering Policy
  sl.registerLazySingleton<PolicyService>(() => PolicyService(sl<Dio>())); // Add PolicyService
  sl.registerLazySingleton<PolicyRepository>(() => PolicyRepository(sl<PolicyService>())); // Add PolicyRepository
  sl.registerFactory<PolicyBloc>(() => PolicyBloc(sl<PolicyRepository>())); // Add PolicyBloc

  // Registering Change Password
  sl.registerLazySingleton<ChangePasswordService>(() => ChangePasswordService(sl<Dio>()));
  sl.registerLazySingleton<ChangePasswordRepository>(() => ChangePasswordRepository(sl<ChangePasswordService>()));
  sl.registerFactory<ChangePasswordBloc>(() => ChangePasswordBloc(sl<ChangePasswordRepository>()));

}
