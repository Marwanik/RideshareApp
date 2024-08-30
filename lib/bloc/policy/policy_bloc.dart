import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/policy/policy_event.dart';
import 'package:rideshare/bloc/policy/policy_state.dart';
import 'package:rideshare/repos/policyRepo.dart';

class PolicyBloc extends Bloc<PolicyEvent, PolicyState> {
  final PolicyRepository policyRepository;

  PolicyBloc(this.policyRepository) : super(PolicyInitial()) {
    on<FetchPolicyEvent>(_onFetchPolicy);
  }

  void _onFetchPolicy(FetchPolicyEvent event, Emitter<PolicyState> emit) async {
    emit(PolicyLoading());
    print('Fetching policy info...');

    try {
      final policyData = await policyRepository.getPolicy(event.token);
      emit(PolicyLoaded(policyData));
      print('Policy info fetched successfully: $policyData');
    } catch (error) {
      print('Error: $error');
      if (error.toString().contains('Access denied')) {
        emit(PolicyError('Access denied: Invalid or expired token. Please log in again.'));
      } else {
        emit(PolicyError('Failed to fetch policy: ${error.toString()}'));
      }
    }
  }
}
