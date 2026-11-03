import 'package:auto/shared/widgets/app_bottom_modal.dart';
import 'package:auto/shared/widgets/car_profile_card.dart';
import 'package:auto/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:auto/shared/widgets/app_button.dart';

class DiagnosticScreen extends StatelessWidget {
  const DiagnosticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Diagnostic'),
        elevation: 0,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.help_outline))],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const CarProfileCard(
            name: 'Avanza 2016',
            // imagePath: 'assets/images/avanza.png',
            // onTap: () {}, // buka detail spesifikasi
          ),

          const AppButton(
            label: 'Tambahkan mobil anda',
            variant: AppButtonVariant.notch,
            notchIcon: Icons.photo_camera_outlined,
          ),
          const Spacer(), // dorong tombol ke bawah
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AppButton(
              label: 'Scan',
              onPressed: () => AppBottomModal.show(
                context,
                title: 'Scan',
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.help_outline),
                  ),
                ],
                child: const ScanContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScanContent extends StatelessWidget {
  const ScanContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8),
        const Text(
          'Siap memindai kendaraan',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14,
            color: AppColors.secondary,
          ),
        ),
        const SizedBox(height: 24),
        AppButton(label: 'Mulai Scan', onPressed: () => Navigator.pop(context)),
        const SizedBox(height: 8),
      ],
    );
  }
}
