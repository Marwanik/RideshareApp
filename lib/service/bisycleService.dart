import 'package:dio/dio.dart';
import 'package:rideshare/model/bicycleModel.dart';

class BicycleService {
  final Dio dio;

  BicycleService(this.dio);

  Future<List<BicycleModel>> getBicyclesByCategory(String token, String category) async {
    final response = await dio.get(
      'https://rideshare.devscape.online/api/v1/bicycle/bicycles-by-category',
      queryParameters: {'category': category},
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'accept': '*/*',
        },
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 202) {
      final List<dynamic> data = response.data['body'];
      return data.map((json) => BicycleModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load bicycles');
    }
  }
}
