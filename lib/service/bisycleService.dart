import 'package:dio/dio.dart';
import 'package:rideshare/model/bicycleModel.dart';

class BicycleService {
  final Dio dio;

  BicycleService(this.dio);

  Future<List<BicycleModel>> getBicyclesByCategory(String token, String category) async {
    final String url = 'https://rideshare.devscape.online/api/v1/bicycle/bicycles-by-category';

    try {
      print('Fetching bicycles...');
      print('Using token: $token'); // Print the token to verify
      final response = await dio.get(
        url,
        queryParameters: {'category': category},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Ensure token is correctly formatted
            'accept': '*/*',
          },
          validateStatus: (status) {
            return status! < 500; // Handle all statuses less than 500
          },
        ),
      );

      print('Response status code: ${response.statusCode}'); // Print status code
      print('Response headers: ${response.headers}'); // Print headers
      print('Response data: ${response.data}'); // Print the raw response data

      if (response.statusCode == 200 || response.statusCode == 202) {
        final List<dynamic> data = response.data['body'];
        return data.map((json) => BicycleModel.fromJson(json)).toList();
      } else if (response.statusCode == 403) {
        print('Access denied error: ${response.data}');
        throw Exception('Access denied: Invalid or expired token. Please log in again.');
      } else {
        throw Exception('Failed to load bicycles');
      }
    } on DioError catch (e) {
      print('Error fetching bicycles: ${e.response?.data}'); // Print detailed error response
      throw Exception('Failed to fetch bicycles: ${e.message}');
    } catch (e) {
      print('Error: ${e.toString()}');
      throw Exception('Failed to fetch bicycles: ${e.toString()}');
    }
  }
}
