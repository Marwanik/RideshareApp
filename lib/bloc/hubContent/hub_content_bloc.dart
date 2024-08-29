import 'package:bloc/bloc.dart';
import 'package:rideshare/bloc/hubContent/hub_content_event.dart';
import 'package:rideshare/bloc/hubContent/hub_content_state.dart';
import 'package:rideshare/repos/hubContentRepo.dart';

class HubContentBloc extends Bloc<HubContentEvent, HubContentState> {
  final HubContentRepository hubRepository;

  HubContentBloc(this.hubRepository) : super(HubInitial()) {
    on<FetchBicyclesByHubAndCategory>((event, emit) async {
      emit(HubLoading());
      try {
        final bicycles = await hubRepository.getBicyclesByHubAndCategory(event.token, event.hubId, event.category);
        if (bicycles.isEmpty) {
          emit(HubError(message: 'No bicycles available'));
        } else {
          emit(HubLoaded(bicycles: bicycles));
        }
      } catch (e) {
        emit(HubError(message: 'Failed to fetch bicycles: $e'));
      }
    });
  }
}
