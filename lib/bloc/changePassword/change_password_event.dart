import 'package:flutter/material.dart';
import 'package:rideshare/model/changePasswordModel.dart';

@immutable
abstract class ChangePasswordEvent {}

class ChangePasswordButtonPressed extends ChangePasswordEvent {
  final ChangePasswordRequest request;
  final String token;

  ChangePasswordButtonPressed({
    required this.request,
    required this.token,
  });
}
