import 'package:rideshare/model/userModel.dart';
import 'package:rideshare/service/authService.dart';

class AuthRepo {
  final AuthService authService;

  AuthRepo(this.authService);

  Future<void> signUp(UserModel user) async {
    try {
      final token = await authService.signUp(user);

      // Handle the token as required, e.g., saving it to storage
      print('Signup successful, token: $token');

      // Example:
      // await saveToken(token);

    } catch (e) {
      // Handle errors accordingly
      if (e.toString().contains('Forbidden')) {
        print('Signup failed: You do not have access to this resource.');
        // Handle 403 Forbidden specifically
      } else {
        print('Signup failed: $e');
      }
      throw Exception('Signup failed: $e');
    }
  }

  // Example method to save token (could be using SharedPreferences or another storage solution)
  Future<void> saveToken(String token) async {
    // Implement your token saving logic here
    // For example, using SharedPreferences:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('auth_token', token);
  }
}
