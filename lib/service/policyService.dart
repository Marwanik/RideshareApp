import 'package:dio/dio.dart';
import 'package:rideshare/model/policyModel.dart';

class PolicyService {
  final Dio dio;

  PolicyService(this.dio);

  Future<PolicyModel> fetchPolicy(String token) async {
    final String url = 'https://rideshare.devscape.online/api/v1/policy';

    try {
      print('Fetching policy info...');
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'accept': '*/*',
          },
          validateStatus: (status) {
            return status! < 500; // Handle all statuses less than 500
          },
        ),
      );

      print('Response data: ${response.data}'); // Print the raw response

      if (response.statusCode == 200) {
        return PolicyModel.fromJson(response.data['body']);
      } else if (response.statusCode == 403) {
        print('Access denied error: ${response.data}');
        throw Exception('Access denied: Invalid or expired token. Please log in again.');
      } else {
        throw Exception('Failed to fetch policy: ${response.statusMessage}');
      }
    } on DioError catch (e) {
      print('Error fetching policy info: ${e.response?.data}');
      throw Exception('Failed to fetch policy: ${e.message}');
    } catch (e) {
      print('Error: ${e.toString()}');
      throw Exception('Failed to fetch policy: ${e.toString()}');
    }
  }
}
