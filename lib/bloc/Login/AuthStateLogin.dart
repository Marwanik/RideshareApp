import 'package:flutter/material.dart';

@immutable
abstract class AuthStateLogin {}

class AuthInitialLogin extends AuthStateLogin {}

class LoadingLogin extends AuthStateLogin {}

class SuccessLogin extends AuthStateLogin {
  final String token;

  SuccessLogin(this.token);
}

class FailedLogin extends AuthStateLogin {
  final String message;
  FailedLogin({required this.message});
}
