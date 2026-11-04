import 'package:auto/core/providers/auth_provider.dart';
import 'package:auto/features/home/screens/home_screen.dart';
import 'package:auto/features/shared/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto/core/theme/colors.dart';
import 'package:auto/core/theme/theme.dart';
import 'package:auto/features/shared/widgets/bottom_nav_bar.dart';
import 'package:auto/features/liveData/screens/live_data_screen.dart';
import 'package:auto/features/diagnostic/screens/diagnostic_screen.dart';
import 'package:auto/features/settings/screens/settings_screen.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        title: 'AUTO Mobile',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: LoadingOverlay(
          isLoading: false,
          child: const MyAppScreen(),
        ),
      ),
    );
  }
}

class MyAppScreen extends StatefulWidget {
  const MyAppScreen({super.key});

  @override
  State<MyAppScreen> createState() => _MyAppScreenState();
}

class _MyAppScreenState extends State<MyAppScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(),
    const LiveDataScreen(),
    const DiagnosticScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06), // Menggunakan withOpacity
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavBar(
              currentIndex: currentIndex,
              onTap: (index) => setState(() => currentIndex = index),
            ),
          ),
        ),
      ),
    );
  }
}

