import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex, 
      onTap: onTap,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor:Colors.transparent,
      selectedItemColor:AppColors.primary,
      unselectedItemColor:AppColors.secondary,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Live Data'),
        BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Diagnostic'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],

    );

  }
}