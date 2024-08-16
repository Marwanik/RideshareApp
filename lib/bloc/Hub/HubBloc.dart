import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/Hub/HubEventBloc.dart';
import 'package:rideshare/bloc/Hub/HubStateBloc.dart';
import 'package:rideshare/repos/HubRepo.dart';

class HubBloc extends Bloc<HubEvent, HubState> {
  final HubRepository hubRepository;

  HubBloc(this.hubRepository) : super(HubInitial()) {
    on<FetchHubs>((event, emit) async {
      emit(HubLoading());
      try {
        final hubs = await hubRepository.getHubs(event.latitude, event.longitude, event.token);
        emit(HubLoaded(hubs: hubs));
      } catch (e) {
        emit(HubError(message: e.toString()));
      }
    });
  }
}
