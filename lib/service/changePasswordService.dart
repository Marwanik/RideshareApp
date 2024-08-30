import 'package:dio/dio.dart';
import 'package:rideshare/model/changePasswordModel.dart';

class ChangePasswordService {
  final Dio dio;

  ChangePasswordService(this.dio);

  Future<void> changePassword(ChangePasswordRequest request, String token) async {
    final String url = 'https://rideshare.devscape.online/api/v1/users/change-password';

    try {
      print('Sending change password request...');
      final response = await dio.put(
        url,
        data: request.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'accept': '*/*',
          },
          validateStatus: (status) {
            return status! < 500; // Handle all statuses less than 500
          },
        ),
      );

      print('Response data: ${response.data}'); // Print the raw response

      if (response.statusCode == 200 || response.statusCode == 202) {
        print('Change password done successfully');
      } else {
        throw Exception('Failed to change password: ${response.statusMessage}');
      }
    } on DioError catch (e) {
      print('Error changing password: ${e.response?.data}');
      throw Exception('Failed to change password: ${e.message}');
    } catch (e) {
      print('Error: ${e.toString()}');
      throw Exception('Failed to change password: ${e.toString()}');
    }
  }
}
