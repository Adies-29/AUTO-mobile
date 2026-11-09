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
import 'package:auto/core/providers/car_status_provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CarStatusProvider()),
      ],
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

  // 👇 TAMBAHKAN GLOBAL KEY INI AGAR BISA DIAKSES DARI FILE LAIN 👇
  static final GlobalKey<MainScreenState> mainKey = GlobalKey<MainScreenState>();

  @override
  State<MainScreen> createState() => MainScreenState(); // 👈 Hapus garis bawah
}

// 👇 UBAH NAMA CLASS MENJADI PUBLIC (TANPA GARIS BAWAH) 👇
class MainScreenState extends State<MainScreen> {
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
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _isAppLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isAppLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: AppSplashLoading(),
      );
    }

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
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