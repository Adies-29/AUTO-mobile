import 'package:flutter/material.dart';
import 'package:auto/core/theme/colors.dart';
import 'package:auto/features/shared/widgets/my_app_bar.dart';
import 'package:auto/features/shared/widgets/app_button.dart';

class DialogTambahMobil extends StatelessWidget {
  const DialogTambahMobil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: MyAppBar(title: 'Daftarkan Mobil anda'),
      // 👇 Menggunakan struktur Column persis seperti garasi.dart 👇
      body: Column(
        children: [
          // Expanded + ScrollView agar form bisa di-scroll 
          // tapi tombol tetap aman di bawah
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Merk Mobil
                  _buildLabel('Merk Mobil'),
                  const SizedBox(height: 8),
                  _buildTextField('Pilih Merk Mobil Anda...'),
                  const SizedBox(height: 20),

                  // 2. Model
                  _buildLabel('Model'),
                  const SizedBox(height: 8),
                  _buildTextField('Pilih Model Mobil Anda...'),
                  const SizedBox(height: 20),

                  // 3. Tahun
                  _buildLabel('Tahun'),
                  const SizedBox(height: 8),
                  _buildTextField('...', keyboardType: TextInputType.number),
                  const SizedBox(height: 20),

                  // 4. Jenis Bahan Bakar
                  _buildLabel('Jenis Bahan Bakar'),
                  const SizedBox(height: 8),
                  _buildTextField('Bensin/Solar/dll...'),
                  
                  const SizedBox(height: 24),

                  // 5. Teks Kecil di Bawah
                  const Center(
                    child: Text(
                      'Mengapa saya harus mendaftarkan mobil saya ?',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF9E9E9E), // Warna abu-abu
                        fontFamily: 'Manrope',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // 👇 TOMBOL PERSIS SEPERTI DI GARASI.DART 👇
          AppButton(
            label: 'Tambahkan mobil anda',
            variant: AppButtonVariant.notch,
            notchIcon: Icons.photo_camera_outlined,
            onPressed: () {
              // Aksi saat tombol diklik (bisa untuk simpan data)
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // Widget helper untuk membuat Label beserta tanda bintang (*)
  Widget _buildLabel(String text) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
          fontFamily: 'Manrope',
        ),
        children: const [
          TextSpan(
            text: '*',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Widget helper untuk membuat TextField dengan gaya abu-abu
  Widget _buildTextField(String hint, {TextInputType? keyboardType}) {
    return TextField(
      keyboardType: keyboardType,
      style: const TextStyle(
        fontSize: 13,
        fontFamily: 'Manrope',
        color: AppColors.black,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 13,
          color: Color(0xFF9E9E9E), // Warna placeholder abu-abu
          fontFamily: 'Manrope',
        ),
        filled: true,
        fillColor: const Color(0xFFF2F2F7), // Background abu-abu terang
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none, // Menghilangkan garis border
        ),
      ),
    );
  }
}