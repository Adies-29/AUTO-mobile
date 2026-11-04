import 'package:flutter/material.dart';
import 'package:auto/core/theme/colors.dart';
import 'package:auto/features/shared/widgets/my_app_bar.dart';
import '../widgets/garasi.dart';
import 'package:auto/features/shared/widgets/pilihan_koneksi.dart';
import 'package:auto/features/liveData/screens/live_data_screen.dart';
import 'package:auto/features/home/widgets/dialog_cara_menghubungkan.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showPilihanKoneksi(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Agar ujung melengkungnya terlihat
      barrierColor: Colors.black.withValues(alpha: 0.5), // Layar belakang jadi gelap
      builder: (context) {
        return const PilihanKoneksiSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Settings'), 
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            _SettingsGroup(
              children: [
                _SettingsItem(
                  icon: Icons.directions_car_outlined,
                  title: 'Garasi saya',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Garasi(), 
                      ),
                    );
                  },
                ),
                  // Fungsi untuk memunculkan modal Koneksi dari bawah
                
                _buildDivider(),
                _SettingsItem(
                  icon: Icons.cable_outlined,
                  title: 'Adaptor',
                  onTap: () {
                    _showPilihanKoneksi(context);
                  },
                ),
                _buildDivider(),
                _SettingsItem(
                  icon: Icons.sensors_outlined,
                  title: 'Sensor',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LiveDataScreen(), 
                      ),
                    );
                  },
                ),
                _buildDivider(),
                _SettingsItem(
                  icon: Icons.menu_book_outlined,
                  title: 'Petunjuk',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DialogCaraMenghubungkan(), 
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            _SettingsGroup(
              children: [
                _SettingsItem(
                  icon: Icons.auto_awesome_outlined,
                  title: 'Tanya Ai',
                  onTap: () {},
                ),
                _buildDivider(),
                _SettingsItem(
                  icon: Icons.support_agent_outlined,
                  title: 'Support',
                  onTap: () {},
                ),
                _buildDivider(),
                _SettingsItem(
                  icon: Icons.star_border_rounded,
                  title: 'Ulasan Aplikasi',
                  onTap: () {},
                ),
                _buildDivider(),
                _SettingsItem(
                  icon: Icons.share_outlined,
                  title: 'Bagikan Aplikasi',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(0xFFF0F0F0),
      indent: 56,
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final List<Widget> children;
  const _SettingsGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 24, color: AppColors.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 24,
              color: AppColors.secondary,
            ),
          ],
        ),
      ),
    );
  }
}