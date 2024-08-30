

import 'package:flutter/material.dart';

@immutable
abstract class PolicyEvent {}

class FetchPolicyEvent extends PolicyEvent {
  final String token;

  FetchPolicyEvent({required this.token});
}
