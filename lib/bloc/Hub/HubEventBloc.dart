import 'package:flutter/material.dart';

@immutable
abstract class HubEvent {}

class FetchHubs extends HubEvent {
  final double latitude;
  final double longitude;
  final String token;

  FetchHubs({
    required this.latitude,
    required this.longitude,
    required this.token,
  });
}
