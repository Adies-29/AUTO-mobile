import 'dart:ui';
import 'dart:math'; // 👈 [TAMBAHAN] Untuk fitur random

import 'package:auto/features/home/widgets/home_app_bar.dart';
import 'package:auto/features/shared/widgets/pilihan_koneksi.dart';
import 'package:auto/core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:auto/core/theme/colors.dart';
import 'package:auto/features/shared/widgets/loading_overlay.dart';
import 'home_connected.dart';
import 'home_error.dart'; // 👈 [TAMBAHAN] Import halaman error

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.onReadMoreTap});

  final VoidCallback? onReadMoreTap;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isConnected = false;
  bool _isLoading = true;
  bool _isError = false; // 👈 [TAMBAHAN] State untuk melacak error
  
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  
  Future<void> _loadData() async {
    // panggil API / database / proses loading asli di sini
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() => _isLoading = false);
  }
  

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
                  child: Container(
                        
                  ),
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
      // 👇 [TAMBAHAN] Logika Loading & Random 👇
      setState(() {
        _isLoading = true; // Munculkan loading overlay
      });

      // Tahan loading 2 detik simulasi koneksi ke OBD
      await Future.delayed(const Duration(seconds: 2));

      final random = Random();
      final isRandomError = random.nextBool(); // Menghasilkan true/false secara acak

      if (mounted) {
        setState(() {
          _isLoading = false;
          _isConnected = true;
          _isError = isRandomError; // Simpan hasil random (true = Error, false = Connected)
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    
    // 👇 [TAMBAHAN] Percabangan Tampilan 👇
    if (_isConnected) {
      // Jika terhubung, cek apakah error atau normal
      if (_isError) {
        content = Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              child: const HomeErrorScreen(), // Tampilan Error
            ),
          ),
        );
      } else {
        content = Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              child: const HomeConnectedScreen(), // Tampilan Normal
            ),
          ),
        );
      }
    } else {
      // Tampilan Awal (Disconnected)
      content = Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            child: Column(
              children: [
                SizedBox(height: 16),
                DashboardTopBar(),
                Expanded(
                  child: _DashboardCenter(onConnectTap: _showConnectionModal,),
                ),
                ReadMoreButton(onPressed: widget.onReadMoreTap,),
                SizedBox(height: 16,),
              ],
            ),
          )
        ),
      );
    }
    
    return LoadingOverlay(
      isLoading: _isLoading,
      child: content,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// KODE DI BAWAH INI TIDAK SAYA UBAH SAMA SEKALI
// ─────────────────────────────────────────────────────────────────────────────

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