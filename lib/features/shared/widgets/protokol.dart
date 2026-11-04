import 'package:auto/core/theme/colors.dart';
import 'package:flutter/material.dart';
import '../../home/widgets/dialog_cara_menghubungkan.dart';

class ProtokolSheet extends StatefulWidget {
  final String? currentProtocol;

  const ProtokolSheet({super.key, this.currentProtocol});

  @override
  State<ProtokolSheet> createState() => _ProtokolSheetState();
}

class _ProtokolSheetState extends State<ProtokolSheet> {
  // Daftar protokol dari Figma
  final List<String> protocols = [
    'Auto',
    'SAE - 34665TRWE K52',
    'SAE - 34665TRWE T7',
    'SAE - 34665TRWE PKA',
    'ISO - BGCR 03CZK 55',
    'ISO - BGCR 000765 BZZW',
  ];

  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    // Cari index protokol saat ini, jika tidak ada (baru buka) default ke 0 (Auto)
    _selectedIndex = protocols.indexOf(widget.currentProtocol ?? 'Auto');
    if (_selectedIndex == -1) _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 24),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      // Gunakan tinggi maksimal agar list muat banyak
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
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
          const SizedBox(height: 16),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.black),
                onPressed: () => Navigator.pop(context),
              ),
              const Text(
                'Protokol',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Manrope',
                ),
              ),
              IconButton(
                icon: const Icon(Icons.info_outline, color: AppColors.black),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const DialogCaraMenghubungkan(),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // List Radio Button
          Expanded(
            child: ListView.builder(
              itemCount: protocols.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedIndex == index;
                return InkWell(
                  onTap: () => setState(() => _selectedIndex = index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            protocols[index],
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Manrope',
                              color: isSelected ? AppColors.black : AppColors.black87,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ),
                        // Custom Radio Button
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? AppColors.blue : AppColors.statusGrey,
                              width: isSelected ? 6 : 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Tombol Simpan
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Kembalikan nilai protokol yang dipilih ke halaman sebelumnya
                Navigator.pop(context, protocols[_selectedIndex]);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Simpan Perubahan',
                style: TextStyle(
                  color: AppColors.surface,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Manrope',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

