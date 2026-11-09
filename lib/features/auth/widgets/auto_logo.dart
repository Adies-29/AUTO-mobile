import 'package:flutter/material.dart';

class AutoLogo extends StatelessWidget {
  const AutoLogo({super.key, this.size = 132});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        'assets/images/auto.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
