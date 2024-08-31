import 'package:flutter/material.dart';
import 'package:rideshare/model/getBicyclesModel.dart';

@immutable
abstract class GetBicycleState {}

class GetBicycleInitial extends GetBicycleState {}

class GetBicycleLoading extends GetBicycleState {}

class GetBicycleLoaded extends GetBicycleState {
  final List<GetBicycleModel> bicycles;

  GetBicycleLoaded(this.bicycles);
}

class GetBicycleError extends GetBicycleState {
  final String message;

  GetBicycleError(this.message);
}
