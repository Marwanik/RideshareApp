import 'package:rideshare/model/bicycleModel.dart';
import 'package:rideshare/service/hubContentService.dart';

class HubContentRepository {
  final HubContentService hubContentService;

  HubContentRepository({required this.hubContentService});

  Future<List<BicycleModel>> getBicyclesByHubAndCategory(String token, int hubId, String category) async {
    return await hubContentService.getBicyclesByHubAndCategory(token, hubId, category);
  }
}
