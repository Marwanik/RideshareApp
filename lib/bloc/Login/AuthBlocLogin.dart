import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rideshare/bloc/Login/AuthEventLogin.dart';
import 'package:rideshare/bloc/Login/AuthStateLogin.dart';
import 'package:rideshare/repos/AuthRepoLogin.dart';
import 'package:rideshare/model/loginModel.dart';

class AuthBlocLogin extends Bloc<AuthEventLogin, AuthStateLogin> {
  final AuthRepoLogin authRepo;
  String? _authToken; // Private token variable

  AuthBlocLogin(this.authRepo) : super(AuthInitialLogin()) {
    on<Login>((event, emit) async {
      emit(LoadingLogin());
      try {
        final token = await authRepo.login(event.user);  // Ensure this passes LoginModel to authRepo.login
        _authToken = token;  // Store the token
        emit(SuccessLogin(token));  // Emit the SuccessLogin state with the token


      } catch (e) {
        emit(FailedLogin(message: e.toString()));
      }
    });
  }

  String? get authToken => _authToken;  // Expose the token through a getter
}
