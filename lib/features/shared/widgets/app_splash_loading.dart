import 'package:flutter/material.dart';

class AppSplashLoading extends StatelessWidget {
  const AppSplashLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Background hitam pekat
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
          const Spacer(flex: 1),
          
          // Logo AUTO
          Image.asset(
            'assets/images/auto.png', 
            height: 120,
            errorBuilder: (context, error, stackTrace) {
              return const Column(
                children: [
                  Icon(Icons.change_history, size: 80, color: Colors.white),
                  Text(
                    'AUTO',
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 32, 
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                ],
              );
            },
          ),
          
          const SizedBox(height: 40), // Jarak antara logo dan progress bar
          
          // 👇 PROGRESS BAR BARU 👇
          SizedBox(
            width: 150, // Lebar progress bar dibuat lebih pendek (dari sebelumnya full)
            child: TweenAnimationBuilder<double>(
              // Animasi dari 0.0 (kiri) ke 1.0 (kanan)
              tween: Tween(begin: 0.0, end: 1.0),
              // Durasi disesuaikan dengan loading di main.dart (3 detik)
              duration: const Duration(seconds: 3), 
              builder: (context, value, _) {
                return LinearProgressIndicator(
                  value: value, // 👈 Menggunakan 'value' agar mengisi perlahan, bukan berulang
                  minHeight: 4,
                  backgroundColor: Colors.grey[800],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                );
              },
            ),
          ),
          
          // 👇 Spacer di bawah dibuat lebih besar (flex: 2) 
          // agar progress bar terdorong lebih ke atas 👇
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}