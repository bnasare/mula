import 'package:flutter/material.dart';

class LearningTrack {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final int durationMinutes;
  final Gradient? gradient;
  final String category;

  const LearningTrack({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.durationMinutes,
    this.gradient,
    required this.category,
  });
}
