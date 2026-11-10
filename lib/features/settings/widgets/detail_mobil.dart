import 'package:flutter/material.dart';
import 'package:auto/core/theme/colors.dart';
import 'package:auto/features/shared/widgets/my_app_bar.dart'; 
import 'history_scan.dart';

class DetailMobilScreen extends StatelessWidget {
  const DetailMobilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: MyAppBar(title: 'Spesifikasi'), 
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─────────────────────────────────────────────────────────────
            // Header (Judul & Gambar)
            // ─────────────────────────────────────────────────────────────
            const Text(
              'Avanza 2016',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Detail spesifikasi kendaraan',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 24),
            
            // Gambar Mobil
            Center(
              child: Image.asset(
                'assets/images/avanza.png', // 👈 Pastikan asset ini ada
                height: 140,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 24),

            // ─────────────────────────────────────────────────────────────
            // Ringkasan (Tahun, Status, Odometer)
            // ─────────────────────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryItem(
                  label: 'Tahun',
                  value: '2016',
                ),
                _buildSummaryItem(
                  label: 'Status',
                  value: 'Terhubung',
                  valueColor: AppColors.blue, // Warna biru untuk status
                ),
                _buildSummaryItem(
                  label: 'Odometer',
                  value: '130.330 km',
                  alignEnd: true,
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            const Divider(color: AppColors.border),
            const SizedBox(height: 16),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Spesifikasi Mobil',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                Text(
                  'Informasi detail kendaraan',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Baris 1
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildSpecItem('Merek / Mobil', 'Toyota Avanza')),
                Expanded(child: _buildSpecItem('Tahun', '2016')),
              ],
            ),
            const SizedBox(height: 16),
            
            // Baris 2
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildSpecItem(
                    'Mesin', 
                    '1.3L 4-Silinder, Dual VVT-i (1NR-VE)',
                  ),
                ),
                Expanded(
                  child: _buildSpecItem(
                    'Transmisi', 
                    'Manual 5-Speed / Otomatis 4-Speed',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Baris 3
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildSpecItem('Tenaga', '96.5 PS / 121 Nm')),
                Expanded(child: _buildSpecItem('Penggerak', 'RWD')),
              ],
            ),
            const SizedBox(height: 16),

            // Baris 4
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildSpecItem('Bahan Bakar', 'Bensin')),
                Expanded(child: _buildSpecItem('Kapasitas', '7 penumpang')),
              ],
            ),
            
            const SizedBox(height: 40),

            // ─────────────────────────────────────────────────────────────
            // Tombol Cek History Scan
            // ─────────────────────────────────────────────────────────────
            Center(
              child: SizedBox(
                width: 200, // Lebar tombol
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoryScanScreen(),
                    ),
                   );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.black,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
                    'Cek History Scan',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            
            // Spasi bawah
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Widget Helper untuk ringkasan atas
  Widget _buildSummaryItem({
    required String label,
    required String value,
    Color? valueColor,
    bool alignEnd = false,
  }) {
    return Column(
      crossAxisAlignment: alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppColors.secondary),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: valueColor ?? AppColors.black,
          ),
        ),
      ],
    );
  }

  // Widget Helper untuk item spesifikasi
  Widget _buildSpecItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppColors.secondary),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}