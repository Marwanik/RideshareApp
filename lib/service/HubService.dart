import 'package:dio/dio.dart';
import 'package:rideshare/model/hubModel.dart';

class HubService {
  final Dio dio;

  HubService(this.dio);

  Future<List<Hub>> getHubs(double latitude, double longitude, String token) async {
    print('Requesting hubs with latitude: $latitude, longitude: $longitude');  // Debugging
    final response = await dio.get(
      'https://rideshare.devscape.online/api/v1/hubs',
      queryParameters: {
        'latitude': latitude,
        'longtitude': longitude,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'accept': '*/*',
        },
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 202) {
      final List<dynamic> data = response.data['body'];
      print('API Response: $data');  // Print the raw data
      return data.map((json) => Hub.fromJson(json)).toList();
    } else {
      print('Failed to load hubs, status code: ${response.statusCode}');
      throw Exception('Failed to load hubs');
    }
  }
}