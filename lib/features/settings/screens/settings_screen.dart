import 'package:auto/core/theme/colors.dart';
import 'package:auto/features/shared/widgets/app_button.dart';
import 'package:auto/features/shared/widgets/car_profile_card.dart';
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
      body: Column(
        children: [
          const SizedBox(height: 16),
          const CarProfileCard(
            name: 'Avanza 2015',
            imagePath: 'assets/images/avanza.png',
          ),
          const AppButton(
            label: 'Tambahkan mobil anda',
            variant: AppButtonVariant.notch,
            notchIcon: Icons.photo_camera_outlined,
          ),
        ],
      ),
    );
  }
}

