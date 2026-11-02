import 'package:auto/theme/colors.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back)
            ),
            title: Text('Setting'),
            elevation: 0,
            backgroundColor: AppColors.background,
            foregroundColor: AppColors.primary,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.help_outline))
            ],
      ),
      body: Center(child: Text('Setting Screen')),
    );
  }
}