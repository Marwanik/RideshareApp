import 'package:dio/dio.dart';
import 'package:rideshare/model/userModel.dart';

abstract class AuthService {
  final Dio dio;

  AuthService(this.dio);

  Future<String> signUp(UserModel user);
}

class AuthServiceImpl extends AuthService {
  final String baseUrl = "https://rideshare.devscape.online/api/v1/auth/";

  AuthServiceImpl(Dio dio) : super(dio);

  @override
  Future<String> signUp(UserModel user) async {
    try {
      final response = await dio.post(
        '${baseUrl}register',
        data: user.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data as Map<String, dynamic>;

        if (responseData.containsKey('body') && responseData['body'] is Map<String, dynamic>) {
          final body = responseData['body'] as Map<String, dynamic>;
          final token = body['token'] as String?;

          if (token != null) {
            return token;
          } else {
            throw Exception('Token not found in the response body.');
          }
        } else {
          throw Exception('Unexpected response format: Missing body or token.');
        }
      } else if (response.statusCode == 403) {
        throw Exception('Forbidden: You do not have access to this resource.');
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 403) {
          throw Exception('Forbidden: You do not have access to this resource.');
        } else {
          throw Exception('Error ${e.response?.statusCode}: ${e.response?.statusMessage}');
        }
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }
}
