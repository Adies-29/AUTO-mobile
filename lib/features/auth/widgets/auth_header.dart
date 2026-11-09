import 'package:flutter/material.dart';
import 'package:auto/core/theme/colors.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color titleColor;
  final Color subtitleColor;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.titleColor = AppColors.black,
    this.subtitleColor = AppColors.subtitleGrey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 28,
            fontWeight: FontWeight.w700,
            height: 1.2,
            letterSpacing: -0.4,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.5,
            color: subtitleColor,
          ),
        ),
      ],
    );
  }
}
