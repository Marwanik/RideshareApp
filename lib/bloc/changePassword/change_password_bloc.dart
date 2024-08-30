import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/changePassword/change_password_event.dart';
import 'package:rideshare/bloc/changePassword/change_password_state.dart';
import 'package:rideshare/repos/changePasswordRepo.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordRepository changePasswordRepository;

  ChangePasswordBloc(this.changePasswordRepository) : super(ChangePasswordInitial()) {
    on<ChangePasswordButtonPressed>(_onChangePassword);
  }

  void _onChangePassword(ChangePasswordButtonPressed event, Emitter<ChangePasswordState> emit) async {
    emit(ChangePasswordLoading());
    print('Changing password...');

    try {
      await changePasswordRepository.changePassword(event.request, event.token);
      emit(ChangePasswordSuccess());
      print('Password changed successfully.');
    } catch (error) {
      print('Error: $error');
      emit(ChangePasswordError('Failed to change password: ${error.toString()}'));
    }
  }
}
