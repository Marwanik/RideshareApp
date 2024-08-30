
import 'package:flutter/material.dart';
import 'package:rideshare/model/policyModel.dart';

@immutable
abstract class PolicyState {}

class PolicyInitial extends PolicyState {}

class PolicyLoading extends PolicyState {}

class PolicyLoaded extends PolicyState {
  final PolicyModel policy;

  PolicyLoaded(this.policy);
}

class PolicyError extends PolicyState {
  final String error;

  PolicyError(this.error);
}
