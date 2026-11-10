import 'package:flutter/material.dart';
import 'package:auto/core/theme/colors.dart';

class DialogPengertianDiag extends StatelessWidget {
  const DialogPengertianDiag({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Pengertian Diagnostic',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Manrope',
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         
            Center(
              child: Image.asset(
                'assets/images/mesin.png', 
                height: 200,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                 
                  return const Icon(
                    Icons.settings_suggest, 
                    size: 150, 
                    color: Colors.grey,
                  );
                },
              ),
            ),
            const SizedBox(height: 32),

            // 👇 Bagian Teks Penjelasan 👇
            _buildTextSection(
              title: 'DTC',
              description:
                  'Diagnostic Trouble Code (DTC) Diagnostic code adalah cara OBD2 '
                  'mengidentifikasi dan mengomunikasikan kepada teknisi di mana dan '
                  'apa masalah yang ada pada kendaraan. Ada 3 jenis kode OBD 2',
            ),
            const SizedBox(height: 20),

            _buildTextSection(
              title: 'DTC Terkonfirmasi',
              description:
                  'Disimpan dalam kode memori, dengan kerusakan yang sudah '
                  'terkonfirmasi. Terkonfirmasi berarti kerusakan yang terjadi beberapa kali '
                  'selama siklus berkendara terakhir atau beberapakali selama siklus berkendata terakhir',
            ),
            const SizedBox(height: 20),

            _buildTextSection(
              title: 'DTC Pending',
              description:
                  'menunjukan kerusakan yang belum di konfirmasi, terjadi pada '
                  'siklus berkendara saat ini. jika kerusakan terjadi lagi dan berulang '
                  'kode akan di transfer ke DTC Terkonfirmasi dan disimpan di '
                  'memori. Jika tidak, kode akan dihapus saat anda mematikan mobil.',
            ),
            const SizedBox(height: 20),

            _buildTextSection(
              title: 'DTC Permanen',
              description:
                  'Malfungsi yang dikonfirmasi dan disimpan, yang tidak dapat dihapus',
            ),
            
            const SizedBox(height: 40), 
          ],
        ),
      ),
    );
  }

  // Widget helper untuk membuat judul dan deskripsi agar kodenya tidak berulang
  Widget _buildTextSection({required String title, required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Manrope',
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          description,
          textAlign: TextAlign.justify, // Agar rata kanan-kiri seperti di Figma
          style: const TextStyle(
            fontSize: 12,
            height: 1.5, // Jarak antar baris agar mudah dibaca
            fontFamily: 'Manrope',
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}