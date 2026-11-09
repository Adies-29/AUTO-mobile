import 'dart:async';
import 'package:flutter/material.dart';
import 'package:auto/core/theme/colors.dart';

// ─────────────────────────────────────────────────────────────────────────────
// 1. WIDGET LONCENG BERANIMASI
// ─────────────────────────────────────────────────────────────────────────────
class ServiceReminderBell extends StatefulWidget {
  const ServiceReminderBell({super.key});

  @override
  State<ServiceReminderBell> createState() => _ServiceReminderBellState();
}

class _ServiceReminderBellState extends State<ServiceReminderBell> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    // Animasi goyang kiri-kanan (seperti lonceng berbunyi)
    _rotation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.15), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.15, end: -0.15), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -0.15, end: 0.15), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 0.15, end: -0.15), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -0.15, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Ulangi animasi setiap 4 detik
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (mounted) _controller.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ServiceReminderSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showModal(context),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: RotationTransition(
          turns: _rotation,
          child: const Icon(
            Icons.notifications_active_rounded,
            color: AppColors.black,
            size: 22,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 2. WIDGET ISI MODAL (BOTTOM SHEET)
// ─────────────────────────────────────────────────────────────────────────────
class ServiceReminderSheet extends StatelessWidget {
  const ServiceReminderSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 24),
          
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // 👇 Background ikon biru transparan 👇
                  color: AppColors.black.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.calendar_month_rounded, color: AppColors.black, size: 28),
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pengingat Servis', style: TextStyle(fontFamily: 'Manrope', fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Ganti oli berikutnya', style: TextStyle(fontFamily: 'Manrope', fontSize: 12, color: AppColors.secondary)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Info tanggal
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tanggal Servis', style: TextStyle(fontSize: 11, color: AppColors.secondary)),
                    SizedBox(height: 4),
                    Text('10 Mei 2024', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Manrope')),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    // 👇 Badge biru transparan 👇
                    color: AppColors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('30 Hari Lagi', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.black, fontFamily: 'Manrope')),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Tombol Tutup
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              child: const Text('Mengerti', style: TextStyle(fontFamily: 'Manrope', fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}