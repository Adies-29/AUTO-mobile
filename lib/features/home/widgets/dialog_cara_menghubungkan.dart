import 'package:auto/core/theme/colors.dart';
import 'package:flutter/material.dart';

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
  bool _isWifiSelected = true;
  int _expandedIndex = -1;

  final List<Langkah> _langkahBluetooth = [
    Langkah(
      title: 'Langkah 1',
      desc: 'Hubungkan OBD anda ke mobil',
      detail:'Port OBD-II biasanya terletak di bawah dashboard. Untuk mobil tertentu, lokasinya bisa berbeda',
      images:['assets/images/car.png','assets/images/avanza.png']
    ),
    Langkah(
      title: 'Langkah 2',
      desc: 'Aktifkan Bluetooth di posnel anda',
      detail:'Buka pengaturan Bluetooth dan cari device OBD anda. Hubungkan dengan password default',
      images:['assets/images/car.png','assets/images/avanza.png']
    ),
    Langkah(
      title: 'Langkah 3',
      desc: 'Jalankan aplikasi AUTO',
      detail:'Port OBD-II biasanya terletak di bawah dashboard. Untuk mobil tertentu, lokasinya bisa berbeda',
      images:['assets/images/car.png','assets/images/car.png']
    ),
    Langkah(
      title: 'Langkah 4',
      desc: 'Hubungkan Mobil Anda',
      detail:'Di layar hime',
      images:['assets/images/car.png','assets/images/car.png']
    ),
    Langkah(
      title: 'Langkah 5',
      desc: 'Pilih metode koneksi',
      detail:'Di layar hime',
      images:['assets/images/car.png','assets/images/car.png']
    ),
  ];

  final List<Langkah> _langkahWifi = [
   Langkah(
      title: 'Langkah 5',
      desc: 'Pilih metode koneksi',
      detail:'Di layar hime',
      images:['assets/images/car.png','assets/images/car.png']
    ),
  ];

  List<Langkah> get _currentLangkah =>
      _isWifiSelected ? _langkahWifi : _langkahBluetooth;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      insetPadding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, size: 18, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Cara menghubungkan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Manrope',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
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
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                                      fontWeight: FontWeight.w700
                                      
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
                              color: AppColors.black87,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // === KONTEN DETAIL
                    if (isExpanded)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.detail,
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 14,
                                color: AppColors.black,
                                height: 1.5
                              ),
                            ),
                            SizedBox(height: 12,),
                            //images
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: item.images.map((imagePath) {
                                  return Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        imagePath,
                                        height: 200,
                                        fit: BoxFit.cover
                                      ),
                                    ),
                                  );
                                }).toList()
                              ),
                            )
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}