import 'package:dio/dio.dart';
import 'package:rideshare/model/bicycleModel.dart';

class HubContentService {
  final Dio _dio = Dio();

  Future<List<BicycleModel>> getBicyclesByHubAndCategory(String token, int hubId, String category) async {
    try {
      final response = await _dio.get(
        'https://rideshare.devscape.online/api/v1/hub-content/$hubId',
        queryParameters: {'bicycleCategory': category},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'accept': '*/*',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['body']['bicycleList'];
        return data.map((json) => BicycleModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load bicycles');
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        throw Exception('Access denied: ${e.response?.statusMessage}');
      } else {
        throw Exception('Failed to load bicycles: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
