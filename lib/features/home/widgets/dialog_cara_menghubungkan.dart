import 'package:flutter/material.dart';
import 'package:auto/core/theme/colors.dart';

class Langkah {
  final String title;
  final String desc;
  final String detail;
  final List<String> images;

  Langkah({
    required this.title,
    required this.desc,
    required this.detail,
    required this.images,
  });
}

class DialogCaraMenghubungkan extends StatefulWidget {
  const DialogCaraMenghubungkan({super.key});

  @override
  State<DialogCaraMenghubungkan> createState() => _DialogCaraMenghubungkanState();
}

class _DialogCaraMenghubungkanState extends State<DialogCaraMenghubungkan> {
  // 👇 Ubah default ke false agar Bluetooth yang muncul duluan
  bool _isWifiSelected = false; 
  int _expandedIndex = -1;

  final List<Langkah> _langkahBluetooth = [
    Langkah(
      title: 'Langkah 1',
      desc: 'Hubungkan OBD anda ke mobil',
      detail: 'Port OBD-II biasanya terletak di bawah dashboard. Untuk mobil tertentu, lokasinya bisa berbeda',
      images: ['assets/images/car.png', 'assets/images/avanza.png'],
    ),
    Langkah(
      title: 'Langkah 2',
      desc: 'Aktifkan Bluetooth di ponsel anda',
      detail: 'Buka pengaturan Bluetooth dan cari device OBD anda. Hubungkan dengan password default',
      images: ['assets/images/car.png', 'assets/images/avanza.png'],
    ),
    Langkah(
      title: 'Langkah 3',
      desc: 'Jalankan aplikasi AUTO',
      detail: 'Port OBD-II biasanya terletak di bawah dashboard. Untuk mobil tertentu, lokasinya bisa berbeda',
      images: ['assets/images/car.png', 'assets/images/car.png'],
    ),
    Langkah(
      title: 'Langkah 4',
      desc: 'Hubungkan Mobil Anda',
      detail: 'Di layar home, tekan tombol "Hubungkan mobil anda"',
      images: ['assets/images/car.png', 'assets/images/car.png'],
    ),
    Langkah(
      title: 'Langkah 5',
      desc: 'Pilih metode koneksi',
      detail: 'Pilih Bluetooth pada jendela yang muncul',
      images: ['assets/images/car.png', 'assets/images/car.png'],
    ),
  ];

  final List<Langkah> _langkahWifi = [
    // Saya tambahkan dummy data agar tidak kosong saat toggle ditekan
    Langkah(
      title: 'Langkah 1',
      desc: 'Sambungkan ke Wi-Fi OBD',
      detail: 'Buka pengaturan Wi-Fi HP dan sambungkan ke jaringan OBD-II',
      images: ['assets/images/car.png', 'assets/images/car.png'],
    ),
    Langkah(
      title: 'Langkah 2',
      desc: 'Pilih metode koneksi',
      detail: 'Pilih Wi-Fi di aplikasi AUTO dan masukkan IP default',
      images: ['assets/images/car.png', 'assets/images/car.png'],
    ),
  ];

  List<Langkah> get _currentLangkah =>
      _isWifiSelected ? _langkahWifi : _langkahBluetooth;

  @override
  Widget build(BuildContext context) {
    // 👇 Ganti Dialog menjadi Scaffold 👇
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 24, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Cara menghubungkan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Manrope',
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          // Toggle Bluetooth / Wi-Fi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() {
                        _isWifiSelected = false;
                        _expandedIndex = -1;
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                          color: _isWifiSelected ? Colors.transparent : AppColors.black,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Bluetooth',
                          style: TextStyle(
                            color: _isWifiSelected ? AppColors.black : AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Manrope',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() {
                        _isWifiSelected = true;
                        _expandedIndex = -1;
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                          color: _isWifiSelected ? AppColors.black : Colors.transparent,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Wi-Fi',
                          style: TextStyle(
                            color: _isWifiSelected ? AppColors.white : AppColors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Manrope',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),

          // List Langkah-langkah (Di sini 'Expanded' aman karena dibungkus Scaffold)
          Expanded(
            child: ListView.builder(
              // shrinkWrap tidak perlu karena sudah pakai Expanded
              itemCount: _currentLangkah.length,
              itemBuilder: (context, index) {
                final item = _currentLangkah[index];
                final isExpanded = _expandedIndex == index;
                
                return Column(
                  children: [
                    InkWell(
                      onTap: () => setState(() {
                        _expandedIndex = isExpanded ? -1 : index;
                      }),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14,
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.desc,
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      fontFamily: 'Manrope',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                              // 👇 Perbaikan typo AppColors.black87 menjadi Colors.black87 👇
                              color: Colors.black87, 
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // === KONTEN DETAIL ===
                    if (isExpanded)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.detail,
                              style: const TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 14,
                                color: Colors.black,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Images
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: item.images.map((imagePath) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        imagePath,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const Divider(height: 32), // Tambahkan garis pembatas di bawah detail
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}