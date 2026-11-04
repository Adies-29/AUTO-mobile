import 'package:auto/features/auth/widgets/register_form.dart';
import 'package:auto/core/theme/colors.dart';
import 'package:auto/features/auth/widgets/auth_header.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AuthHeader(
                  title: 'Daftar',
                  subtitle: 'Buat akun baru',
                ),
                const SizedBox(height: 32),
                const RegisterForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}