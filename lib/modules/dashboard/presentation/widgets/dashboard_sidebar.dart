import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class DashboardSidebar extends StatelessWidget {
  const DashboardSidebar({
    required this.items,
    this.selectedIndex = 0,
    super.key,
  });

  final List<DashboardSidebarItem> items;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 288,
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
      decoration: BoxDecoration(
        color: AppTheme.navy.withValues(alpha: 0.78),
        border: Border(
          right: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _BrandHeader(),
            const SizedBox(height: 34),
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final item = items[index];

                  return _SidebarButton(
                    label: item.label,
                    icon: item.icon,
                    isSelected: index == selectedIndex,
                  );
                },
              ),
            ),
            const SizedBox(height: 18),
            _StatusPill(
              text: 'Sistema óptico premium',
              icon: Icons.auto_awesome_rounded,
              color: AppTheme.cyanGlow,
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardSidebarItem {
  const DashboardSidebarItem({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [AppTheme.electricBlue, AppTheme.cyanGlow],
            ),
          ),
          child: const Icon(Icons.visibility_rounded, color: Colors.white),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OptiCalc Pro',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Dashboard clínico',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xFF91A6C8), fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SidebarButton extends StatefulWidget {
  const _SidebarButton({
    required this.label,
    required this.icon,
    required this.isSelected,
  });

  final String label;
  final IconData icon;
  final bool isSelected;

  @override
  State<_SidebarButton> createState() => _SidebarButtonState();
}

class _SidebarButtonState extends State<_SidebarButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.isSelected || _isHovering;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isActive
              ? Colors.white.withValues(alpha: 0.10)
              : Colors.transparent,
          border: Border.all(
            color: widget.isSelected
                ? AppTheme.electricBlue.withValues(alpha: 0.46)
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: widget.isSelected
                  ? AppTheme.cyanGlow
                  : Colors.white.withValues(alpha: 0.70),
              size: 21,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: widget.isSelected
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.74),
                  fontWeight: widget.isSelected
                      ? FontWeight.w800
                      : FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({
    required this.text,
    required this.icon,
    required this.color,
  });

  final String text;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: color.withValues(alpha: 0.10),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.86),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
