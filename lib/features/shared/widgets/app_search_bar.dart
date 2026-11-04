
import 'package:auto/core/theme/colors.dart';
import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final EdgeInsetsGeometry margin;

  const AppSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
    this.hintText = "Cari Sensor...",
    this.margin = const EdgeInsets.fromLTRB(16, 8, 16, 8),
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller, 
      builder: (context, value, _){
        return Container(
          margin: margin,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Icon(Icons.search, size: 22, color: AppColors.primary,),
              SizedBox(width: 10,),
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  textInputAction: TextInputAction.search,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: TextStyle(
                       fontFamily: 'Manrope',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              if(value.text.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    controller.clear();
                    onChanged?.call('');
                  },
                  child: const Icon(
                    Icons.close,
                    size: 18,
                    color: AppColors.secondary,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

