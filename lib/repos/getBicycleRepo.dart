import 'package:rideshare/service/getBicyclesService.dart';
import 'package:rideshare/model/getBicyclesModel.dart';

class GetBicycleRepository {
  final GetBicycleService bicycleService;

  GetBicycleRepository(this.bicycleService);

  Future<List<GetBicycleModel>> getBicycles(String token) async {
    return await bicycleService.fetchBicycles(token);
  }
}
