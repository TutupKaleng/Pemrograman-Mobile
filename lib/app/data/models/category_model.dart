import 'package:flutter/material.dart';

class Category {
  final String name;
  final String url;
  final IconData icon;
  final List<Color> gradient;
  final String? badge;

  const Category({
    required this.name,
    required this.url,
    required this.icon,
    required this.gradient,
    this.badge,
  });
}
