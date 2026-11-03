import 'dart:ui';
import 'package:auto/shared/widgets/pilihan_koneksi.dart';
import 'package:auto/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:auto/theme/colors.dart'; // 👈 Import theme

import 'home_connected.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.onProfileTap,
    this.onReadMoreTap,
  });

  final VoidCallback? onProfileTap;
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
      barrierColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(color: AppColors.black.withOpacity(0.5)),
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
      setState(() {
        _isConnected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isConnected) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
            child: const HomeConnectedScreen(),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
          child: Column(
            children: [
              const SizedBox(height: 16),
              DashboardTopBar(onProfileTap: widget.onProfileTap),
              Expanded(
                child: _DashboardCenter(
                  onConnectTap: _showConnectionModal,
                ),
              ),
              ReadMoreButton(onPressed: widget.onReadMoreTap),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardTopBar extends StatelessWidget {
  const DashboardTopBar({super.key, this.onProfileTap});

  final VoidCallback? onProfileTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSpacing.topBarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.topBarRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 6,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'AUTO',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          GestureDetector(
            onTap: onProfileTap,
            child: const Icon(
              Icons.account_circle,
              size: 33,
              color: AppColors.black,
            ),
          ),
        ],
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
        const Align(
          alignment: Alignment.centerLeft,
          child: ConnectionStatus(),
        ),
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
  const CarImage({
    super.key,
    this.height = AppSpacing.carHeight,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: height),
        child: Image.asset(
          'assets/images/car.png',
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