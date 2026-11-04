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
        if (isLoading)
          ModalBarrier(
            dismissible: false,
            color: AppColors.background.withValues(alpha: 0.3),
          ),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
      ],
    );
  }
}