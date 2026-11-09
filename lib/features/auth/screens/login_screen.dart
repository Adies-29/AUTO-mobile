import 'package:auto/features/auth/widgets/auto_logo.dart';
import 'package:auto/features/auth/widgets/login_form.dart';
import 'package:auto/core/theme/colors.dart';
import 'package:auto/core/theme/spacing.dart';
import 'package:auto/features/auth/widgets/auth_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final minHeight = constraints.maxHeight > 64
                  ? constraints.maxHeight - 64
                  : 0.0;

              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                  vertical: 32,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: minHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(child: AutoLogo()),
                      const SizedBox(height: 28),
                      const AuthHeader(
                        title: 'Masuk',
                        subtitle: 'Selamat datang kembali',
                        titleColor: AppColors.white,
                        subtitleColor: AppColors.statusGrey,
                      ),
                      const SizedBox(height: 32),
                      const LoginForm(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
