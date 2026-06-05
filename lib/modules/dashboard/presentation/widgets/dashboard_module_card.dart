import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class DashboardModuleCard extends StatefulWidget {
  const DashboardModuleCard({
    required this.title,
    required this.description,
    required this.metric,
    required this.icon,
    required this.accentColor,
    required this.delay,
    super.key,
  });

  final String title;
  final String description;
  final String metric;
  final IconData icon;
  final Color accentColor;
  final int delay;

  @override
  State<DashboardModuleCard> createState() => _DashboardModuleCardState();
}

class _DashboardModuleCardState extends State<DashboardModuleCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 520 + widget.delay),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 22 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: _isHovering
                  ? widget.accentColor.withValues(alpha: 0.42)
                  : Colors.white.withValues(alpha: 0.08),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.navy.withValues(alpha: _isHovering ? 0.95 : 0.78),
                const Color(0xFF09111E).withValues(alpha: 0.94),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: widget.accentColor.withValues(
                  alpha: _isHovering ? 0.28 : 0.12,
                ),
                blurRadius: _isHovering ? 34 : 22,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          transform: Matrix4.translationValues(
            0.0,
            _isHovering ? -5.0 : 0.0,
            0.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          widget.accentColor,
                          widget.accentColor.withValues(alpha: 0.42),
                        ],
                      ),
                    ),
                    child: Icon(widget.icon, color: Colors.white, size: 26),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_outward_rounded,
                    color: Colors.white.withValues(alpha: 0.55),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                widget.metric,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                widget.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
