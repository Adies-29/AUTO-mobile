import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 👈 Import Provider

import 'package:auto/features/home/widgets/home_app_bar.dart';
import 'package:auto/features/shared/widgets/pilihan_koneksi.dart';
import 'package:auto/core/theme/spacing.dart';
import 'package:auto/core/theme/colors.dart';
import 'package:auto/features/shared/widgets/loading_dialog.dart';
import 'package:auto/core/providers/car_status_provider.dart'; // 👈 Import Provider Status
import 'home_connected.dart';
import 'home_error.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.onReadMoreTap});

  final VoidCallback? onReadMoreTap;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isConnected = false;

  void _showConnectionModal() async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.black.withValues(alpha: 0.5),
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: PilihanKoneksiSheet(),
            ),
          ],
        );
      },
    );

    if (result == true) {
      showLoadingDialog(context); 
      await Future.delayed(const Duration(seconds: 2));

      final random = Random();
      final isRandomError = random.nextBool(); 

      if (mounted) {
        Navigator.pop(context); // Tutup Loading Dialog
        
        // 👇 SIMPAN HASIL RANDOM KE PROVIDER AGAR SINKRON 👇
        Provider.of<CarStatusProvider>(context, listen: false).updateCarStatus(
          hasError: isRandomError,
          dtcList: [], // Di home belum ada data DTC, kita biarkan kosong dulu
        );

        setState(() {
          _isConnected = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 👇 DENGARKAN PERUBAHAN DARI PROVIDER 👇
    final carStatus = Provider.of<CarStatusProvider>(context);

    // Tampilan Awal (Disconnected)
    if (!_isConnected) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
            child: Column(
              children: [
                const SizedBox(height: 16),
                const DashboardTopBar(),
                Expanded(
                  child: _DashboardCenter(onConnectTap: _showConnectionModal),
                ),
                ReadMoreButton(onPressed: widget.onReadMoreTap),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
    }

    // Tampilan Connected (Error atau Normal)
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
          child: carStatus.hasError 
              ? const HomeErrorScreen() // Jika Provider bilang error
              : const HomeConnectedScreen(), // Jika Provider bilang normal
        ),
      ),
    );
  }
} 

class _DashboardCenter extends StatelessWidget {
  const _DashboardCenter({this.onConnectTap});

  final VoidCallback? onConnectTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        const Align(alignment: Alignment.centerLeft, child: ConnectionStatus()),
        const Spacer(),
        const CarImage(),
        const SizedBox(height: 24),
        const WelcomeText(),
        const SizedBox(height: 24),
        ConnectButton(onPressed: onConnectTap),
        const Spacer(flex: 2),
      ],
    );
  }
}

class ConnectionStatus extends StatelessWidget {
  const ConnectionStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 4),
      child: Text(
        '• Not Connected',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.statusGrey,
        ),
      ),
    );
  }
}

class CarImage extends StatelessWidget {
  const CarImage({super.key, this.height = AppSpacing.carHeight});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: height),
        child: Image.asset(
          'assets/images/car.png',
          height: 160,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Selamat datang di AUTO',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Pemindai mobil berbasis OBD 2',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: AppColors.subtitleGrey,
          ),
        ),
      ],
    );
  }
}

class ConnectButton extends StatelessWidget {
  const ConnectButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.75,
      child: SizedBox(
        height: AppSpacing.buttonHeight,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blue,
            foregroundColor: AppColors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text('Hubungkan mobil anda'),
        ),
      ),
    );
  }
}

class ReadMoreButton extends StatelessWidget {
  const ReadMoreButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(foregroundColor: AppColors.black),
      child: const Text(
        'BACA LEBIH LANJUT →',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
    );
  }
}