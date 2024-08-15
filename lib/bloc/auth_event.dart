
import 'package:flutter/material.dart';
import 'package:rideshare/model/userModel.dart';

@immutable
abstract class AuthEvent {}

class SignUp extends AuthEvent {
  final UserModel user;

  SignUp(this.user);
}
