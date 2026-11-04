import 'package:flutter/material.dart';
import 'package:auto/core/theme/colors.dart';
import 'package:auto/features/shared/widgets/my_app_bar.dart';

class HistoryScanScreen extends StatelessWidget {
  const HistoryScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: MyAppBar(title: 'History scan ( Avanza )'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          // Item 1
          _HistoryItem(
            date: 'Oct 22, 2025 10:24',
            codeCount: '1 Kode ditemukan',
            dtcCode: 'P00650',
            isWarning: true,
          ),
          const Divider(color: AppColors.border, height: 32),
          
          // Item 2
          _HistoryItem(
            date: 'Aug 10, 2025 15:21',
            codeCount: '2 Kode ditemukan',
            dtcCode: 'P00650',
            isWarning: true,
          ),
          const Divider(color: AppColors.border, height: 32),
          
          // Item 3 (Desain Figma menunjukkan ikon centang hitam)
          _HistoryItem(
            date: 'Mar 13, 2025 15:21',
            codeCount: '2 Kode ditemukan',
            dtcCode: 'P00650',
            isWarning: false, 
          ),
          const Divider(color: AppColors.border, height: 32),
        ],
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final String date;
  final String codeCount;
  final String dtcCode;
  final bool isWarning;

  const _HistoryItem({
    required this.date,
    required this.codeCount,
    required this.dtcCode,
    required this.isWarning,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tanggal
        Text(
          date,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.secondary,
          ),
        ),
        const SizedBox(height: 12),
        
        // Ikon dan Teks
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ikon (Peringatan atau Centang)
            Icon(
              isWarning ? Icons.error_outline_rounded : Icons.check_circle,
              color: AppColors.black,
              size: 24,
            ),
            const SizedBox(width: 12),
            
            // Teks Kode
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  codeCount,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dtcCode,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}