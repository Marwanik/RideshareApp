import 'package:flutter/material.dart';
import 'package:rideshare/model/bicycleModel.dart';

@immutable
abstract class BicycleState {}

class BicycleInitial extends BicycleState {}

class BicycleLoading extends BicycleState {}

class BicycleLoaded extends BicycleState {
  final List<BicycleModel> bicycles;

  BicycleLoaded({required this.bicycles});
}

class BicycleError extends BicycleState {
  final String message;

  BicycleError({required this.message});
}
