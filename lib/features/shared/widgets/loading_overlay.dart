import 'dart:ui'; 
import 'package:flutter/cupertino.dart'; 
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
          Positioned.fill(
            // 👇 Perbaikan 1: Tambahkan 'child:' 👇
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withValues(alpha: 0.2), 
              ),
            ),
          ),
          
          Center(
            child: Container(
              width: 80,
              height: 80,
              // 👇 Perbaikan 2: borderRadius masuk ke dalam BoxDecoration 👇
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
        ],
      ],
    );
  }
}