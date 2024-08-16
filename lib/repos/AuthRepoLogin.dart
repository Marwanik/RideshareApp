import 'package:rideshare/handling_error/handleLoginMessage.dart';
import 'package:rideshare/model/loginModel.dart';
import 'package:rideshare/service/AuthServiceLogin.dart';

class AuthRepoLogin {
  final AuthServiceLogin authService;

  AuthRepoLogin(this.authService);

  Future<void> login(LoginModel user) async {
    try {
      final token = await authService.login(user);
      print('Login successful, token: $token');
      // Example: await saveToken(token);
    } catch (e) {
      if (e is InvalidEmailOrPassword) {
        throw InvalidEmailOrPassword();
      }
      throw Exception('Login failed: $e');
    }
  }
}
