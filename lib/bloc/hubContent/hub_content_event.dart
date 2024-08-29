import 'package:flutter/material.dart';

@immutable
abstract class HubContentEvent {}

class FetchBicyclesByHubAndCategory extends HubContentEvent {
  final String token;
  final int hubId;
  final String category;

  FetchBicyclesByHubAndCategory({required this.token, required this.hubId, required this.category});
}
