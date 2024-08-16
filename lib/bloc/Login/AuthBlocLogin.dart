import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rideshare/bloc/Login/AuthEventLogin.dart';
import 'package:rideshare/bloc/Login/AuthStateLogin.dart';
import 'package:rideshare/repos/AuthRepoLogin.dart';

class AuthBlocLogin extends Bloc<AuthEventLogin, AuthStateLogin> {
  final AuthRepoLogin authRepo;

  AuthBlocLogin(this.authRepo) : super(AuthInitialLogin()) {
    on<Login>((event, emit) async {
      emit(LoadingLogin());
      try {
        await authRepo.login(event.user);
        emit(SuccessLogin());
      } catch (e) {
        emit(FailedLogin(message: e.toString()));
      }
    });
  }
}
