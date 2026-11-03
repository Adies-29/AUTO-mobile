import 'package:flutter/material.dart'; // 👈 Wajib import ini agar Colors.black dikenali

class AppColors {
  // ==========================================
  // BASE COLORS
  // ==========================================
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  
  // ==========================================
  // BRAND / DOMINAN
  // ==========================================
  static const Color primary = Color(0xFF111111);       // Teks judul, tombol hitam, ikon aktif
  static const Color secondary = Color(0xFF757575);     // Teks sub-label, ikon inaktif
  static const Color border = Color(0xFFEEEEEE);        // Garis pemisah tabel, border card
  
  // ==========================================
  // FUNGSIONAL / STATUS
  // ==========================================
  static const Color blueAccent = Color(0xFF2F80ED);    // Teks kode sensor (LOAD, ECT, dll)
  static const Color success = Color(0xFF22C55E);       // Indikator hijau status normal
  static const Color anomali = Color(0xFFFF3700);       // Indikator merah status tidak normal

  // ==========================================
  // DARI TOKENS (Warna & Ukuran)
  // ==========================================
  static const Color blue = Color(0xFF4599FE);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color statusGrey = Color(0xFF9E9E9E);
  static const Color subtitleGrey = Color(0xFF6B6B6B);
  
  // Ukuran (Spacing & Sizing)
  static const double screenPadding = 24;
  static const double topBarHeight = 54;
  static const double topBarRadius = 50;
  static const double carHeight = 257;
  static const double buttonHeight = 48;
}