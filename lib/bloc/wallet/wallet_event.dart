import 'package:flutter/material.dart';

@immutable
abstract class WalletEvent {}

class FetchWalletEvent extends WalletEvent {
  final String token;

  FetchWalletEvent({required this.token});
}
