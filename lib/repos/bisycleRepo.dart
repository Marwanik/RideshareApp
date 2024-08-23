import 'package:rideshare/model/bicycleModel.dart';
import 'package:rideshare/service/bisycleService.dart';

class BicycleRepository {
  final BicycleService bicycleService;

  BicycleRepository(this.bicycleService);

  Future<List<BicycleModel>> getBicyclesByCategory(String token, String category) async {
    return await bicycleService.getBicyclesByCategory(token, category);
  }
}
