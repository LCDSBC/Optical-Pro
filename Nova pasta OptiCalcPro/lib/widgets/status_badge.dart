import 'package:flutter/material.dart';

import '../models/readiness_item.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({required this.status, super.key});

  final ReadinessStatus status;

  @override
  Widget build(BuildContext context) {
    final (:color, :label) = switch (status) {
      ReadinessStatus.ready => (
        color: Colors.greenAccent.shade400,
        label: 'Pronto',
      ),
      ReadinessStatus.warning => (
        color: Colors.amberAccent.shade400,
        label: 'Configurar',
      ),
      ReadinessStatus.blocked => (
        color: Colors.redAccent.shade200,
        label: 'Bloqueado',
      ),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.48)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
