import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/config/serviceLocater.dart';
import 'package:rideshare/core/bloc/app_manger_event.dart';
import 'package:rideshare/core/bloc/app_manger_state.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AppManagerBloc extends Bloc<AppManagerEvent, AppManagerState> {
  AppManagerBloc() : super(AppManagerInitial()) {
    on<CheckAuthorized>(
          (event, emit) {
        if (sl.get<SharedPreferences>().getString('token') == null ||
            sl.get<SharedPreferences>().getString('token') == '') {
          emit(NavigateToLogin());
        } else {
          emit(NavigateToMainPage());
        }
      },
    );
    on<Success>((event, emit) {
      emit(NavigateToMainPage());
    });
    on<Failed>((event, emit) {
      emit(NavigateToLogin());
    });
    on<LogOut>((event, emit) {
      sl.get<SharedPreferences>().setString("token", '');
      emit(NavigateToLogin());
    });
  }
}