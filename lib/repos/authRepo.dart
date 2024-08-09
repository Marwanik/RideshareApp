
import 'package:rideshare/handling_error/handle_auth_message.dart';
import 'package:rideshare/model/dataModel.dart';
import 'package:rideshare/model/userModel.dart';
import 'package:rideshare/service/authService.dart';

class AuthRepo {
  final AuthService authService;

  AuthRepo(this.authService);

  Future<ResultModel> signUp(UserModel user) async {
    try {
      var data = await authService.signup(user);
      // ? Success Scenrio
      return DataSuccess();
    } catch (e) {
      print(e.runtimeType);
      if (e is PasswordHasNotSpeicalCharcter) {
        return DataFailed(message: "Your Password must be retryed");
      } else {
        return DataFailed(message: "The error is not Detect");
      }
    }
  }
}