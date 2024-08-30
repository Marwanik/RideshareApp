import 'package:flutter/material.dart';
import 'package:rideshare/model/walletModel.dart';

@immutable
abstract class WalletState {}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final WalletModel wallet;

  WalletLoaded(this.wallet);
}

class WalletError extends WalletState {
  final String error;

  WalletError(this.error);
}
