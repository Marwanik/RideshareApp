import 'package:flutter/material.dart';
import 'package:rideshare/model/hubModel.dart';

@immutable
abstract class HubState {}

class HubInitial extends HubState {}

class HubLoading extends HubState {}

class HubLoaded extends HubState {
  final List<Hub> hubs;

  HubLoaded({required this.hubs});
}

class HubError extends HubState {
  final String message;

  HubError({required this.message});
}
