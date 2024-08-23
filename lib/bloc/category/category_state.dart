import 'package:flutter/material.dart';
import 'package:rideshare/model/categoryModel.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;

  CategoryLoaded({required this.categories});
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError({required this.message});
}
