import 'package:dio/dio.dart';
import 'package:rideshare/model/categoryModel.dart';


class CategoryService {
  final Dio dio;

  CategoryService(this.dio);

  Future<List<CategoryModel>> getCategories(String token) async {
    final response = await dio.get(
      'https://rideshare.devscape.online/api/v1/bicycle/bicycles-categories',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'accept': '*/*',
        },
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 202) {
      final List<dynamic> data = response.data['body'];
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
