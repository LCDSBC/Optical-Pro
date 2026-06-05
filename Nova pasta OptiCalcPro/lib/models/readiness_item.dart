import 'package:flutter/material.dart';

enum ReadinessStatus { ready, warning, blocked }

class ReadinessItem {
  const ReadinessItem({
    required this.title,
    required this.description,
    required this.status,
    required this.icon,
  });

  final String title;
  final String description;
  final ReadinessStatus status;
  final IconData icon;
}
