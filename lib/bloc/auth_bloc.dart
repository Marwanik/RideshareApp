import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rideshare/model/dataModel.dart';
import 'package:rideshare/model/userModel.dart';
import 'package:rideshare/repos/authRepo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo repo;
  AuthBloc(this.repo) : super(AuthInitial()) {
    on<SignUp>((event, emit) async {
      emit(Loading());
      var data = await repo.signUp(event.user);
      if (data is DataSuccess) {
        emit(Success());
      } else {
        emit(Failed(message: (data as DataFailed).message));
      }
    });
  }
}