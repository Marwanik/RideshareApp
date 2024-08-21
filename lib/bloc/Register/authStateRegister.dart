import 'package:flutter/material.dart';

@immutable
abstract class AuthStateRegister {}

class AuthInitialRegister extends AuthStateRegister {}

class LoadingRegister extends AuthStateRegister {}

class FailedRegister extends AuthStateRegister {
  final String message;
  FailedRegister({required this.message});
}

class SuccessRegister extends AuthStateRegister {}
