import 'package:flutter/material.dart';
import 'package:rideshare/model/bicycleModel.dart';

@immutable
abstract class HubContentState {}

class HubInitial extends HubContentState {}

class HubLoading extends HubContentState {}

class HubLoaded extends HubContentState {
  final List<BicycleModel> bicycles;

  HubLoaded({required this.bicycles});
}

class HubError extends HubContentState {
  final String message;

  HubError({required this.message});
}