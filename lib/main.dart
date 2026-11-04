import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 👈 Import Provider
import 'package:auto/core/providers/auth_provider.dart'; // 👈 Import AuthProvider

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
    // 👇 BUNGKUS DENGAN PROVIDER DI SINI 👇
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(), // Inisialisasi AuthProvider
      child: MaterialApp(
        title: 'AUTO Mobile',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Manrope', 
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF4599FE),
          ),
          useMaterial3: true,
        ),
        home: const MainScreen(),
      ),
    );
  }
}

// ... (Class MainScreen dan MainScreenState di bawahnya biarkan tetap sama) ...

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  
  // State untuk Splash Screen Awal (Layar Hitam)
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
    _loadData();
  }

  Future<void> _loadData() async {
    // Jeda 3 detik untuk Splash Screen
    await Future.delayed(const Duration(seconds: 3)); 
    if (!mounted) return;
    setState(() => _isAppLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    // 👇 1. Tampilkan Splash Screen Full tanpa Navbar 👇
    if (_isAppLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: AppSplashLoading(),
      );
    }

    // 👇 2. Tampilkan Aplikasi Utama + Navbar 👇
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
      ),
    );
  }
}