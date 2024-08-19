import 'package:rideshare/handling_error/handleLoginMessage.dart';
import 'package:rideshare/model/loginModel.dart';
import 'package:rideshare/service/AuthServiceLogin.dart';

class AuthRepoLogin {
  final AuthServiceLogin authService;

  AuthRepoLogin(this.authService);

  Future<String> login(LoginModel user) async {  // Ensure this expects LoginModel and returns String
    try {
      final token = await authService.login(user);  // Assume this returns a token as String
      return token;  // Return the token
    } catch (e) {
      if (e is InvalidEmailOrPassword) {
        throw InvalidEmailOrPassword();
      }
      throw Exception('Login failed: $e');
    }
  }
}
