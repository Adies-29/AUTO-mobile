import 'package:auto/theme/colors.dart';
import 'package:flutter/material.dart';


enum AppButtonVariant { filled, blue, link, notch }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? notchIcon;
  final EdgeInsetsGeometry? margin;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.filled,
    this.notchIcon,
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
  });

  @override
  Widget build(BuildContext context) {
    switch (variant){
      case AppButtonVariant.link:
        return TextButton(
          onPressed: onPressed, 
          child: Text(
            label.toUpperCase(),
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              color: AppColors.primary,
            ),
          ),
        );
      case AppButtonVariant.notch:
        return NotchButton(
          label:label,
          onPressed:onPressed,
          icon: notchIcon ?? Icons.directions_car,
        );
      case AppButtonVariant.blue:
        return PillButton(
          label:label,
          onPressed: onPressed,
          backgroundColor: AppColors.blueAccent,
          margin:margin,
        );
      case AppButtonVariant.filled:
        return PillButton(
          label:label,
          onPressed: onPressed,
          backgroundColor: AppColors.primary,
          margin:margin,
        );
      
    }
  }
}

class PillButton extends StatelessWidget {
  
  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final EdgeInsetsGeometry? margin;

  const PillButton({
    required this.label,
    this.onPressed,
    required this.backgroundColor,
    this.margin,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: FilledButton(
        onPressed: onPressed, 
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: AppColors.surface,
          shape: StadiumBorder(),
          minimumSize: const Size.fromHeight(48),
          textStyle: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}

class NotchButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData icon;

  const NotchButton({
    super.key,
    required this.label,
    this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 28, 16, 0),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            width: double.infinity,
            height: 50 ,
            child: FilledButton(
              onPressed: onPressed, 
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.surface,
                disabledBackgroundColor: AppColors.primary,
                disabledForegroundColor: AppColors.surface,
                shape: StadiumBorder(),
                padding: EdgeInsets.only(top: 8),
                textStyle: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text(label),
            ),
          ),
          Positioned(
            top: -26,
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary,
                  width: 1.5
                )
              ),
              child: Center(
                child: Container(
                  width: 24,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.surface,
                      width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),   
                child: Icon(
                  Icons.photo_camera,
                  size: 16,
                  color: AppColors.surface,
                )
              )
            ),
          )
          )
        ],
      ),
    );
  }
}