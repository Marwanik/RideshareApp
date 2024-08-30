import 'package:rideshare/model/changePasswordModel.dart';
import 'package:rideshare/service/changePasswordService.dart';

class ChangePasswordRepository {
  final ChangePasswordService changePasswordService;

  ChangePasswordRepository(this.changePasswordService);

  Future<void> changePassword(ChangePasswordRequest request, String token) async {
    return await changePasswordService.changePassword(request, token);
  }
}
