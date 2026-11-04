import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto/core/providers/auth_provider.dart';
import 'package:auto/core/theme/colors.dart';
import 'package:auto/features/home/screens/home_screen.dart';
import 'package:auto/features/shared/widgets/bottom_nav_bar.dart';
import 'package:auto/features/liveData/screens/live_data_screen.dart';
import 'package:auto/features/diagnostic/screens/diagnostic_screen.dart';
import 'package:auto/features/settings/screens/settings_screen.dart';
import 'package:auto/features/shared/widgets/app_splash_loading.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: 'AUTO Mobile',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Manrope',
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4599FE)),
          useMaterial3: true,
        ),
        home: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  bool _isAppLoading = true;

  final List<Widget> pages = [
    const HomeScreen(),
    const LiveDataScreen(),
    const DiagnosticScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Loading Splash Screen selama 3 detik
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _isAppLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. Tampilkan Splash Screen
    if (_isAppLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: AppSplashLoading(),
      );
    }

    // 2. Tampilkan Aplikasi Utama
    return Scaffold(
      // Hapus 'extendBody: true' agar tombol Scan tidak tertutup
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      
      // 👇 PERBAIKAN NAVBAR: Bungkus dengan Container agar muncul sempurna 👇
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16), // Jarak dari pinggir layar
          child: Container(
            height: 60, // Tinggi navbar
            decoration: BoxDecoration(
              color: Colors.white, // Background navbar
              borderRadius: BorderRadius.circular(30), // Sudut membulat
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
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