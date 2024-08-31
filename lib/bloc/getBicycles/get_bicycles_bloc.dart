import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/getBicycles/get_bicycles_event.dart';
import 'package:rideshare/bloc/getBicycles/get_bicycles_state.dart';
import 'package:rideshare/repos/getBicycleRepo.dart';

class GetBicycleBloc extends Bloc<GetBicycleEvent, GetBicycleState> {
  final GetBicycleRepository bicycleRepository;

  GetBicycleBloc(this.bicycleRepository) : super(GetBicycleInitial()) {
    on<GetFetchBicyclesEvent>(_onFetchBicycles);
  }

  void _onFetchBicycles(GetFetchBicyclesEvent event, Emitter<GetBicycleState> emit) async {
    emit(GetBicycleLoading());
    try {
      final bicycles = await bicycleRepository.getBicycles(event.token);
      emit(GetBicycleLoaded(bicycles));
    } catch (e) {
      emit(GetBicycleError(e.toString()));
    }
  }
}
