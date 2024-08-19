import 'package:bloc/bloc.dart';
import 'package:rideshare/bloc/Hub/HubStateBloc.dart';
import 'package:rideshare/bloc/Hub/HubEventBloc.dart';
import 'package:rideshare/repos/HubRepo.dart';

class HubBloc extends Bloc<HubEvent, HubState> {
  final HubRepository hubRepository;

  HubBloc(this.hubRepository) : super(HubInitial()) {
    on<FetchHubs>((event, emit) async {
      emit(HubLoading());
      try {
        print('Fetching hubs in HubBloc');  // Debugging
        final hubs = await hubRepository.getHubs(event.latitude, event.longitude, event.token);
        print('Hubs Loaded in Bloc: $hubs');  // Print the hubs in the Bloc
        emit(HubLoaded(hubs: hubs));
      } catch (e) {
        print('Error loading hubs: $e');  // Print error
        emit(HubError(message: e.toString()));
      }
    });
  }
}
