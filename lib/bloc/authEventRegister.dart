import 'package:flutter/material.dart';
import 'package:rideshare/model/registerModel.dart';

@immutable
abstract class AuthEventRegister {}

class SignUp extends AuthEventRegister {
  final RegisterModel user;

  SignUp(this.user);
}
