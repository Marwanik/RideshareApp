
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/Register/authEventRegister.dart';
import 'package:rideshare/bloc/Register/authStateRegister.dart';
import 'package:rideshare/repos/AuthRepoRegister.dart';

class AuthBlocRegister extends Bloc<AuthEventRegister, AuthStateRegister> {
  final AuthRepoRegister authRepo;

  AuthBlocRegister(this.authRepo) : super(AuthInitialRegister()) {
    on<SignUp>((event, emit) async {
      emit(LoadingRegister());
      try {
        await authRepo.signUp(event.user);
        emit(SuccessRegister());
      } catch (e) {
        emit(FailedRegister(message: e.toString()));
      }
    });
  }
}
