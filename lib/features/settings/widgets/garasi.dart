import 'package:auto/features/shared/widgets/app_button.dart';
import 'package:auto/features/shared/widgets/car_profile_card.dart';
import 'package:auto/features/shared/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'detail_mobil.dart'; 

class Garasi extends StatelessWidget {
  const Garasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Garasi Saya'),
      body: Column(
        children: [
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailMobilScreen(),
                ),
              );
            },
            child: const CarProfileCard(
              name: 'Avanza 2015',
              imagePath: 'assets/images/avanza.png',
            ),
          ),
          const Spacer(),
          const AppButton(
            label: 'Tambahkan mobil anda',
            variant: AppButtonVariant.notch,
            notchIcon: Icons.photo_camera_outlined,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}