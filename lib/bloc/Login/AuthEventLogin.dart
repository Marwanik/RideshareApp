import 'package:flutter/material.dart';
import 'package:rideshare/model/loginModel.dart';

@immutable
abstract class AuthEventLogin {}

class Login extends AuthEventLogin {
  final LoginModel user;  // Change from String to LoginModel

  Login(this.user);
}
