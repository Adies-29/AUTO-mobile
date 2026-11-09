import 'package:flutter/material.dart';
import 'package:auto/core/theme/colors.dart';

class DialogDaftarkanMobil extends StatelessWidget {
  const DialogDaftarkanMobil({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Agar tingginya menyesuaikan isi
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👇 Judul (Bold) 👇
            const Text(
              'Mengapa saya harus mendaftarkan mobil saya?',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            
            // 👇 Deskripsi (Medium) 👇
            const Text(
              'Untuk memberikan informasi yang lebih akurat kepada pengguna tentang mobil, kami mengumpulkan data anda tentang merk/model/tahun/jenis bahan bakar mobil.',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 14,
                fontWeight: FontWeight.w500, // Medium
                height: 1.5,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 24),
            
            // Tombol Mengerti
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Mengerti',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}