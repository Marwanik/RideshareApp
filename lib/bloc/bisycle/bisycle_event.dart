import 'package:flutter/material.dart';

@immutable
abstract class BicycleEvent {}

class FetchBicyclesByCategory extends BicycleEvent {
  final String token;
  final String category;

  FetchBicyclesByCategory({required this.token, required this.category});
}
