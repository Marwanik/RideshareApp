import 'package:dio/dio.dart';
import 'package:rideshare/model/hubModel.dart';

class HubService {
  final Dio dio;

  HubService(this.dio);

  Future<List<Hub>> getHubs(double latitude, double longitude, String token) async {
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
      return data.map((json) => Hub.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load hubs');
    }
  }
}
