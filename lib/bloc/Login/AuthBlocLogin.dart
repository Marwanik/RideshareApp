import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rideshare/bloc/Login/AuthEventLogin.dart';
import 'package:rideshare/bloc/Login/AuthStateLogin.dart';
import 'package:rideshare/repos/AuthRepoLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBlocLogin extends Bloc<AuthEventLogin, AuthStateLogin> {
  final AuthRepoLogin authRepo;
  String? _authToken;

  AuthBlocLogin(this.authRepo) : super(AuthInitialLogin()) {
    on<Login>((event, emit) async {
      emit(LoadingLogin());
      try {
        final token = await authRepo.login(event.user);
        _authToken = token;
        await _saveToken(token);  // Save the token to shared preferences
        emit(SuccessLogin(token));
      } catch (e) {
        emit(FailedLogin(message: e.toString()));
      }
    });

    _loadToken();  // Load the token when the Bloc is initialized
  }

  String? get authToken => _authToken;

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString('authToken');
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    _authToken = null;
  }
}
