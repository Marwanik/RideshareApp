import 'package:flutter/material.dart';

@immutable
abstract class GetBicycleEvent {}

class GetFetchBicyclesEvent extends GetBicycleEvent {
  final String token;

  GetFetchBicyclesEvent({required this.token});
}
