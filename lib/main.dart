import 'package:auto/theme/colors.dart';
import 'package:flutter/material.dart';
import './screens/home/home_screen.dart';
import './shared/widgets/bottom_nav_bar.dart';
import 'screens/liveData/live_data_screen.dart';
import 'screens/diagnostic/diagnostic_screen.dart';
import 'screens/setting/settings_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AUTO Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // 👇 Gunakan font Manrope yang ada di folder assets/fonts 👇
        fontFamily: 'Manrope', 
        
        // 👇 Gunakan warna biru dari Figma sebagai warna utama 👇
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4599FE), // Warna biru AUTO
        ),
        
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
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
      // Pastikan background scaffold putih agar sesuai dengan desain Figma
      backgroundColor: Colors.white, 
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.background, // Pastikan warna ini cocok (putih/abu-abu terang)
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
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