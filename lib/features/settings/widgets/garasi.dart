import 'package:flutter/material.dart';
import 'package:auto/core/theme/colors.dart';
import 'package:auto/features/shared/widgets/app_button.dart';
import 'package:auto/features/shared/widgets/car_profile_card.dart';
import 'package:auto/features/shared/widgets/my_app_bar.dart';
import 'detail_mobil.dart'; 
import 'dialog_tambah_mobil.dart'; // 👈 Import halaman form tambah mobil

class Garasi extends StatelessWidget {
  const Garasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Garasi Saya'),
      body: Column(
        children: [
          const SizedBox(height: 16),
          
          // 👇 List Mobil (Untuk saat ini baru 1 data dummy) 👇
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailMobilScreen(),
                ),
              );
            },
            child: const CarProfileCard(
              name: 'Avanza 2015',
              imagePath: 'assets/images/avanza.png',
            ),
          ),
          
          const Spacer(),
          
          // 👇 Tombol Tambah Mobil yang Baru 👇
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                // Arahkan ke halaman form TabBar yang baru kita buat
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DialogTambahMobil(),
                    ),
                  );
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  'Tambah Mobil Baru',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary, // Warna hitam elegan
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}