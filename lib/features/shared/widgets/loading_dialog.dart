import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto/core/theme/colors.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // User tidak bisa menutup dengan klik luar
    barrierColor: Colors.black.withValues(alpha: 0.3), // Efek gelap di belakang
    builder: (context) {
      return PopScope(
        canPop: false, // Mencegah tombol back HP menutup dialog
        child: Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Center(
                child: CupertinoActivityIndicator(
                  radius: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}