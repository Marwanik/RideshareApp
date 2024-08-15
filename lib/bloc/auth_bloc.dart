import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rideshare/bloc/auth_event.dart';
import 'package:rideshare/bloc/auth_state.dart';
import 'package:rideshare/model/userModel.dart';
import 'package:rideshare/repos/authRepo.dart';



class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc(this.authRepo) : super(AuthInitial()) {
    on<SignUp>((event, emit) async {
      emit(Loading());
      try {
        await authRepo.signUp(event.user);
        emit(Success());
      } catch (e) {
        emit(Failed(message: e.toString()));
      }
    });
  }
}