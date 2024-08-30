import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/wallet/wallet_event.dart';
import 'package:rideshare/bloc/wallet/wallet_state.dart';
import 'package:rideshare/repos/walletRepo.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository walletRepository;

  WalletBloc(this.walletRepository) : super(WalletInitial()) {
    on<FetchWalletEvent>(_onFetchWallet);
  }

  void _onFetchWallet(FetchWalletEvent event, Emitter<WalletState> emit) async {
    emit(WalletLoading());
    print('Fetching wallet info...');

    try {
      final walletData = await walletRepository.fetchWallet(event.token);
      emit(WalletLoaded(walletData));
      print('Wallet info fetched successfully: $walletData');
    } catch (error) {
      print('Error: $error');
      if (error.toString().contains('Access denied')) {
        emit(WalletError('Access denied: Invalid or expired token. Please log in again.'));
      } else {
        emit(WalletError(error.toString()));
      }
    }
  }
}
