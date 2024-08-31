import 'package:dio/dio.dart';
import 'package:rideshare/model/getBicyclesModel.dart';

class GetBicycleService {
  final Dio dio;

  GetBicycleService(this.dio);

  Future<List<GetBicycleModel>> fetchBicycles(String token) async {
    final String url = 'https://rideshare.devscape.online/api/v1/bicycle';

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'accept': '*/*',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['body'];
        return data.map((item) => GetBicycleModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch bicycles: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to fetch bicycles: ${e.toString()}');
    }
  }
}
