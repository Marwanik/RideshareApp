
import 'package:rideshare/model/hubModel.dart';
import 'package:rideshare/service/HubService.dart';
class HubRepository {
  final HubService hubService;

  HubRepository(this.hubService);

  Future<List<Hub>> getHubs(double latitude, double longitude, String token) async {
    final hubs = await hubService.getHubs(latitude, longitude, token);
    print('Hubs from HubService: $hubs');  // Print the hubs list
    return hubs;
  }
}
