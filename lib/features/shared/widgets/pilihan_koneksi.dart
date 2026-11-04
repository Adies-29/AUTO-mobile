import 'package:flutter/material.dart';
import 'protokol.dart';
// 👇 Sesuaikan path import ini dengan lokasi dialog_tambah_mobil kamu 👇
import 'package:auto/features/settings/widgets/dialog_tambah_mobil.dart'; 

class PilihanKoneksiSheet extends StatefulWidget {
  const PilihanKoneksiSheet({super.key});

  @override
  State<PilihanKoneksiSheet> createState() => _PilihanKoneksiSheetState();
}

class _PilihanKoneksiSheetState extends State<PilihanKoneksiSheet> {
  int _selectedIndex = -1; 
  String? _selectedProtocol = 'Auto';

  final TextEditingController _ipController = TextEditingController(text: '192.168.0.10');
  final TextEditingController _portController = TextEditingController(text: '35000');

  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    super.dispose();
  }

  Future<void> _openProtocolSheet() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ProtokolSheet(
        currentProtocol: _selectedProtocol,
      ),
    );

    if (result != null) {
      setState(() {
        _selectedProtocol = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Indicator Bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  'Koneksi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Manrope',
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Ikon Bluetooth & Wifi
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bluetooth,
                  size: 32,
                  color: _selectedIndex == 0 ? Colors.black : Colors.grey[400],
                ),
                const SizedBox(width: 16),
                Row(
                  children: List.generate(
                    4,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: _selectedIndex == 1 ? Colors.black : Colors.grey[400],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.wifi,
                  size: 32,
                  color: _selectedIndex == 1 ? Colors.black : Colors.grey[400],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 👇 TAMBAHAN BARU: Teks dan Tombol Tambah Mobil 👇
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tambahkan Mobil anda terlebih dahulu',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Manrope',
                ),
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                // Navigasi ke halaman DialogTambahMobil
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DialogTambahMobil(),
                  ),
                );
              },
              child: Container(
                height: 48,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F7), // Warna abu-abu terang
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Tambahkan Mobil Anda +',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: 'Manrope',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Teks Petunjuk Koneksi (Disesuaikan dengan Figma)
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Silahkan pilih jenis Koneksi OBD II',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6B6B6B),
                  fontFamily: 'Manrope',
                ),
              ),
            ),
            const SizedBox(height: 8),
            
            // Toggle / Segmented Control
            Container(
              height: 48,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildToggleButton(
                      text: 'Bluetooth',
                      isSelected: _selectedIndex == 0,
                      onTap: () => setState(() => _selectedIndex = 0),
                    ),
                  ),
                  Expanded(
                    child: _buildToggleButton(
                      text: 'Wi-Fi',
                      isSelected: _selectedIndex == 1,
                      onTap: () => setState(() => _selectedIndex = 1),
                    ),
                  ),
                ],
              ),
            ),

            // BAGIAN PROTOKOL
            if (_selectedIndex != -1) ...[
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Protokol',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B6B6B),
                    fontFamily: 'Manrope',
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _openProtocolSheet,
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Jenis Protokol',
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Manrope',
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            _selectedProtocol ?? 'Pilih',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF4599FE),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Manrope',
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            size: 20,
                            color: Color(0xFF4599FE),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],

            // BAGIAN PENGATURAN WI-FI
            if (_selectedIndex == 1) ...[
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Pengaturan Wi-Fi',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Manrope',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildCustomTextField(
                label: 'Alamat IP adaptor',
                controller: _ipController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              _buildCustomTextField(
                label: 'Port IP Adaptor',
                controller: _portController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nilai default pengaturan (IP : Port)\n'
                  '172.123.42.2 : 35000 (sebagian besar perangkat)\n'
                  '464.758.12.9 : 35000 (sebagian kecil klien)\n'
                  '127.947.6.52 : 40200 (POX PW-Wi-Fi)\n'
                  '927.727.91.90 : 30000 (OBD Link)\n'
                  '728.728.69.0 : 23 (OBD KEY)',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6B6B6B),
                    height: 1.5,
                    fontFamily: 'Manrope',
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),

            // TOMBOL HUBUNGKAN
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _selectedIndex == -1
                    ? null
                    : () {
                        Navigator.pop(context, true); 
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  disabledBackgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Hubungkan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Manrope',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14, fontFamily: 'Manrope', fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 12, color: Colors.grey),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? Colors.white : Colors.grey[600],
            fontSize: 14,
            fontFamily: 'Manrope',
          ),
        ),
      ),
    );
  }
}