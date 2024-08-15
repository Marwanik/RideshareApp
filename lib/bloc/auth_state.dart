import 'package:flutter/material.dart';


@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class Loading extends AuthState {}

class Failed extends AuthState {
  final String message;
  Failed({required this.message});
}

class Success extends AuthState {}