import 'package:flutter/material.dart';

import 'premium_card.dart';

class CalculationResultCard extends StatelessWidget {
  const CalculationResultCard({
    super.key,
    required this.title,
    required this.value,
    required this.description,
    this.icon = Icons.auto_awesome,
  });

  final String title;
  final String value;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return PremiumCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: colorScheme.primary.withValues(alpha: 0.16),
            child: Icon(icon, color: colorScheme.primary),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(description, style: textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
