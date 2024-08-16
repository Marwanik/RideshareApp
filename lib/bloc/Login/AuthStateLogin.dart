import 'package:flutter/material.dart';

@immutable
abstract class AuthStateLogin {}

class AuthInitialLogin extends AuthStateLogin {}

class LoadingLogin extends AuthStateLogin {}

class FailedLogin extends AuthStateLogin {
  final String message;
  FailedLogin({required this.message});
}

class SuccessLogin extends AuthStateLogin {}
