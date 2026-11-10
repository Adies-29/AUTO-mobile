import 'package:auto/core/theme/colors.dart';
import 'package:auto/features/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // 👈 Import url_launcher

class DtcCard extends StatelessWidget {
  final String code;
  final String title;
  final String description;
  final VoidCallback? onCardPressed; // 👈 Parameter baru untuk klik kartu
  final VoidCallback? onAIPressed;
  final VoidCallback? onSearchPressed; // Bisa dipertahankan atau dihapus

  const DtcCard({
    super.key,
    required this.code,
    required this.title,
    required this.description,
    this.onCardPressed, // 👈 Tambahkan ini
    this.onAIPressed,
    this.onSearchPressed,
  });

  // 👇 Fungsi untuk membuka Google Search 👇
  Future<void> _searchOnGoogle() async {
    // Membuat query pencarian, contoh: "OBD2 P03200 Engine Temp"
    final query = Uri.encodeComponent('OBD2 $code $title kerusakan mobil');
    final url = Uri.parse('https://www.google.com/search?q=$query');

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      // 👇 BUNGKUS DENGAN INKWELL UNTUK KLIK KARTU 👇
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onCardPressed, // Arahkan ke Detail saat kartu diklik
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        code,
                        style: const TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 14,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'Cari Informasi',
                        variant: AppButtonVariant.link,
                        // 👇 Panggil fungsi Google Search di sini 👇
                        onPressed: _searchOnGoogle, 
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppButton(
                        label: 'Tanya AI',
                        variant: AppButtonVariant.link,
                        onPressed: onAIPressed,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}