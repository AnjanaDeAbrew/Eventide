import 'package:flutter/material.dart';

class CategoryModel {
  CategoryModel({
    required this.id,
    required this.widget,
    required this.category,
    required this.image,
    required this.vectorImage,
  });

  final int id;
  final Widget widget;
  final String category;
  final String image;
  final String vectorImage;
}
