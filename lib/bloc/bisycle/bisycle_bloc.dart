import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/bisycle/bisycle_event.dart';
import 'package:rideshare/bloc/bisycle/bisycle_state.dart';
import 'package:rideshare/repos/bisycleRepo.dart';

class BicycleBloc extends Bloc<BicycleEvent, BicycleState> {
  final BicycleRepository bicycleRepository;

  BicycleBloc(this.bicycleRepository) : super(BicycleInitial()) {
    on<FetchBicyclesByCategory>((event, emit) async {
      emit(BicycleLoading());
      try {
        final bicycles = await bicycleRepository.getBicyclesByCategory(event.token, event.category);
        if (bicycles.isEmpty) {
          emit(BicycleError(message: 'No bicycles available'));
        } else {
          emit(BicycleLoaded(bicycles: bicycles));
        }
      } catch (e) {
        if (e.toString().contains('Access denied')) {
          emit(BicycleError(message: 'Access denied: Invalid or expired token. Please log in again.'));
        } else {
          emit(BicycleError(message: 'Failed to fetch bicycles: $e'));
        }
      }
    });
  }
}
