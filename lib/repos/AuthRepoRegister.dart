import 'package:rideshare/model/registerModel.dart';
import 'package:rideshare/service/authServiceRegister.dart';

class AuthRepoRegister {
  final AuthServiceRegister authService;

  AuthRepoRegister(this.authService);

  Future<void> signUp(RegisterModel user) async {
    try {
      final token = await authService.signUp(user);
      print('Signup successful, token: $token');
      // Example: await saveToken(token);
    } catch (e) {
      if (e.toString().contains('Forbidden')) {
        print('Signup failed: You do not have access to this resource.');
      } else {
        print('Signup failed: $e');
      }
      throw Exception('Signup failed: $e');
    }
  }
}
