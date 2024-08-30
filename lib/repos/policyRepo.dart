import 'package:rideshare/model/policyModel.dart';
import 'package:rideshare/service/policyService.dart';

class PolicyRepository {
  final PolicyService policyService;

  PolicyRepository(this.policyService);

  Future<PolicyModel> getPolicy(String token) async {
    try {
      return await policyService.fetchPolicy(token);
    } catch (e) {
      rethrow;
    }
  }
}
