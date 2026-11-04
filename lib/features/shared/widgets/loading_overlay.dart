import 'dart:ui'; // 👈 Wajib untuk efek Blur
import 'package:flutter/cupertino.dart'; // 👈 Wajib untuk CupertinoActivityIndicator
import 'package:flutter/material.dart';
import 'package:auto/core/theme/colors.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading) ...[
          // 1. Efek Blur & Gelap di seluruh layar (Khas iOS)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withValues(alpha: 0.2), // Sedikit digelapkan
              ),
            ),
          ),
          
          // 2. Kotak HUD (Heads-Up Display) ala iOS
          Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.9), // Putih agak transparan
                borderRadius: BorderRadius.circular(20), // Sudut membulat (squircle)
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Center(
                // 3. Spinner khas Apple (Garis tipis & abu-abu)
                child: CupertinoActivityIndicator(
                  radius: 16,
                  color: Colors.grey, 
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}