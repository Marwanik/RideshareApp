
import 'package:rideshare/model/categoryModel.dart';
import 'package:rideshare/service/categoryService.dart';

class CategoryRepository {
  final CategoryService categoryService;

  CategoryRepository(this.categoryService);

  Future<List<CategoryModel>> getCategories(String token) async {
    return await categoryService.getCategories(token);
  }
}
