import 'package:flutter/material.dart';
import 'package:auto/core/theme/colors.dart';

class DialogBacaLebihLanjut extends StatelessWidget {
  const DialogBacaLebihLanjut({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      // Agar konten bisa di-scroll jika layar HP kecil
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Indikator bar di atas
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 👇 JUDUL 👇
            const Text(
              'Apa Saja yang Bisa Dilakukan AUTO?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Manrope',
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Aplikasi AUTO bukan sekadar scanner biasa. Berikut adalah fitur teknis yang dirancang untuk memberikan kontrol penuh atas kendaraan Anda:',
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                fontFamily: 'Manrope',
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 24),

            _buildFeatureItem(
              icon: Icons.troubleshoot_rounded,
              title: 'Diagnostik DTC (Trouble Codes)',
              description:
                  'Membaca kode kesalahan dari Engine Control Unit (ECU) mobil Anda. Aplikasi ini mengelompokkannya menjadi 3 status: Terkonfirmasi, Pending, dan Permanent, sehingga Anda tahu mana masalah yang harus segera ditangani.',
            ),
            
            _buildFeatureItem(
              icon: Icons.speed_rounded,
              title: 'Pemantauan Live Data',
              description:
                  'Melihat data sensor secara real-time langsung dari mesin. Pantau putaran mesin (RPM), suhu cairan pendingin, tegangan aki (Voltase), kecepatan, dan sensor lainnya selama berkendara.',
            ),

            _buildFeatureItem(
              icon: Icons.smart_toy_rounded,
              title: 'Asisten Cerdas (Tanya AI)',
              description:
                  'Bingung dengan kode error yang muncul? Fitur Tanya AI akan menganalisis kode DTC secara otomatis. AI akan memberikan penjelasan mengenai penyebab kerusakan dan saran tindakan yang harus dilakukan.',
            ),

            _buildFeatureItem(
              icon: Icons.manage_search_rounded,
              title: 'Pencarian Referensi Instan',
              description:
                  'Jika Anda ingin riset lebih dalam, fitur "Cari Informasi" akan membawa Anda langsung ke Google Search dengan kata kunci spesifik sesuai kode DTC yang terdeteksi.',
            ),

            _buildFeatureItem(
              icon: Icons.history_rounded,
              title: 'Histori Pemindaian & Garasi',
              description:
                  'Simpan profil kendaraan Anda dan lacak riwayat (History) kerusakan dari waktu ke waktu. Membantu Anda memantau apakah suatu masalah bersifat berulang atau sudah teratasi.',
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Siap Digunakan',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // Widget Helper untuk membuat baris fitur
  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kotak Ikon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          // Teks
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Manrope',
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    fontFamily: 'Manrope',
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}