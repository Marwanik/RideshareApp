import 'package:flutter/material.dart';

@immutable
abstract class CategoryEvent {}

class FetchCategories extends CategoryEvent {
  final String token;

  FetchCategories({required this.token});
}
