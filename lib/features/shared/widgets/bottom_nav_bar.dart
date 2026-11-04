import 'package:flutter/material.dart';

import 'package:auto/core/theme/colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    (icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
    (icon: Icons.show_chart_outlined, activeIcon: Icons.show_chart, label: 'Live Data'),
    (icon: Icons.search_outlined, activeIcon: Icons.search, label: 'Diagnostic'),
    (icon: Icons.settings_outlined, activeIcon: Icons.settings, label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            for (int i = 0; i < _items.length; i++)
              Expanded(
                child: _NavItem(
                  icon: _items[i].icon,
                  activeIcon: _items[i].activeIcon,
                  label: _items[i].label,
                  isActive: i == currentIndex,
                  onTap: () => onTap(i),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // transition-all + duration-150 ease-in-out dari Tailwind
    return TweenAnimationBuilder<double>(
      tween: Tween(end: isActive ? 1 : 0),
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      builder: (context, t, _) {
        final color = Color.lerp(AppColors.secondary, AppColors.primary, t)!;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(38),
            child: Container(
              decoration: BoxDecoration(
                color: Color.lerp(Colors.transparent, AppColors.border, t),
                borderRadius: BorderRadius.circular(38),
                // shadow-neu-inset versi Flutter (inset asli tidak ada,
                // jadi pakai bayangan tipis di dalam area)
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06 * t),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ikon berganti instan seperti strokeWidth 2 -> 2.5
                  Icon(isActive ? activeIcon : icon, size: 22, color: color),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 10,
                      fontWeight: FontWeight.lerp(
                        FontWeight.w600,
                        FontWeight.w800,
                        t,
                      ),
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
