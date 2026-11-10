import 'package:flutter/material.dart';
import 'package:auto/core/theme/colors.dart';
import 'package:auto/features/shared/widgets/dialog_kenapadaftar_mobil.dart';

class DialogTambahMobil extends StatelessWidget {
  const DialogTambahMobil({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Daftarkan Mobil anda',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Manrope',
              color: Colors.black,
            ),
          ),
          bottom: const TabBar(
            labelColor: AppColors.black,
            unselectedLabelColor: AppColors.secondary,
            indicatorColor: AppColors.blue,
            indicatorWeight: 3,
            labelStyle: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            tabs: [
              Tab(text: 'Isi Manual'),
              Tab(text: 'Foto Mobil'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _ManualFormTab(),
            _ScanFotoTab(),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 1: FORM MANUAL
// ─────────────────────────────────────────────────────────────────────────────
class _ManualFormTab extends StatefulWidget {
  const _ManualFormTab();

  @override
  State<_ManualFormTab> createState() => _ManualFormTabState();
}

class _ManualFormTabState extends State<_ManualFormTab> {
  final TextEditingController _carController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  // State untuk mengunci (disable) kolom model & tahun
  bool _isModelEnabled = true;
  bool _isYearEnabled = true;

  // Data Dummy Mobil (Format Lengkap)
  final List<Map<String, String>> _dummyCars = [
    {'full': 'Toyota Avanza 2016', 'model': 'Avanza', 'year': '2016'},
    {'full': 'Honda Brio 2018', 'model': 'Brio', 'year': '2018'},
    {'full': 'Mitsubishi Xpander 2020', 'model': 'Xpander', 'year': '2020'},
    {'full': 'Suzuki Ertiga 2019', 'model': 'Ertiga', 'year': '2019'},
    {'full': 'Daihatsu Terios 2017', 'model': 'Terios', 'year': '2017'},
  ];

  // Fungsi DatePicker untuk Ganti Oli
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary, 
              onPrimary: Colors.white, 
              onSurface: AppColors.primary, 
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 👇 KOLOM PILIH MOBIL (AUTOCOMPLETE) 👇
                _buildLabel('Mobil Anda'),
                const SizedBox(height: 8),
                Autocomplete<Map<String, String>>(
                  displayStringForOption: (option) => option['full']!,
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return _dummyCars;
                    }
                    return _dummyCars.where((option) {
                      return option['full']!.toLowerCase().contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  
                  // 👇 TAMBAHKAN ON-SELECTED DI SINI 👇
                  onSelected: (Map<String, String> selection) {
                    setState(() {
                      _carController.text = selection['full']!;
                      _modelController.text = selection['model']!;
                      _yearController.text = selection['year']!;
                      _isModelEnabled = false; // Kunci Model
                      _isYearEnabled = false;  // Kunci Tahun
                    });
                  },

                  fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                    // Sinkronisasi controller
                    if (textEditingController.text != _carController.text && _carController.text.isNotEmpty) {
                      textEditingController.text = _carController.text;
                    }
                    
                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      style: const TextStyle(fontSize: 13, fontFamily: 'Manrope', color: AppColors.black),
                      decoration: _buildInputDecoration('Pilih atau ketik Mobil (Cth: Honda Brio 2018)...'),
                      
                      // 👇 ON-CHANGED HANYA UNTUK DETEKSI KETIKAN MANUAL 👇
                      onChanged: (text) {
                        _carController.text = text;
                        
                        // Jika teks dikosongkan atau diubah manual, buka kunci kolom
                        final matches = _dummyCars.where((car) => car['full']!.toLowerCase() == text.toLowerCase()).toList();
                        
                        if (matches.isEmpty) {
                          setState(() {
                            _isModelEnabled = true;
                            _isYearEnabled = true;
                            if (text.isEmpty) {
                              _modelController.clear();
                              _yearController.clear();
                            }
                          });
                        }
                      },
                    );
                  },
                ),
                
                const SizedBox(height: 20),

                // 👇 MODEL MOBIL 👇
                _buildLabel('Model'),
                const SizedBox(height: 8),
                TextField(
                  controller: _modelController,
                  enabled: _isModelEnabled, // Mati jika dipilih dari autocomplete
                  style: TextStyle(
                    fontSize: 13, 
                    fontFamily: 'Manrope', 
                    color: _isModelEnabled ? AppColors.black : AppColors.secondary, // Abu-abu jika mati
                  ),
                  decoration: _buildInputDecoration('Model Mobil...'),
                ),
                
                const SizedBox(height: 20),

                // 👇 TAHUN MOBIL 👇
                _buildLabel('Tahun'),
                const SizedBox(height: 8),
                TextField(
                  controller: _yearController,
                  enabled: _isYearEnabled, // Mati jika dipilih dari autocomplete
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 13, 
                    fontFamily: 'Manrope', 
                    color: _isYearEnabled ? AppColors.black : AppColors.secondary, // Abu-abu jika mati
                  ),
                  decoration: _buildInputDecoration('Tahun Mobil...'),
                ),

                const SizedBox(height: 20),

                // 👇 KAPAN TERAKHIR GANTI OLI 👇
                _buildLabel('Kapan Terakhir Ganti Oli?'),
                const SizedBox(height: 8),
                TextField(
                  controller: _dateController,
                  readOnly: true, 
                  onTap: () => _selectDate(context), 
                  style: const TextStyle(fontSize: 13, fontFamily: 'Manrope', color: AppColors.black),
                  decoration: _buildInputDecoration('Pilih Tanggal...').copyWith(
                    suffixIcon: const Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.secondary),
                  ),
                ),
                
                const SizedBox(height: 24),

                Center(
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const DialogDaftarkanMobil(),
                      );
                    },
                    child: const Text(
                      'Mengapa saya harus mendaftarkan mobil saya ?',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF9E9E9E),
                        fontFamily: 'Manrope',
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Tombol Simpan
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Simpan Data',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helper Label
  Widget _buildLabel(String text) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
          fontFamily: 'Manrope',
        ),
        children: const [
          TextSpan(
            text: '*',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Helper Input Decoration
  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 13,
        color: Color(0xFF9E9E9E),
        fontFamily: 'Manrope',
      ),
      filled: true,
      fillColor: const Color(0xFFF2F2F7),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB 2: SCAN FOTO
// ─────────────────────────────────────────────────────────────────────────────
class _ScanFotoTab extends StatelessWidget {
  const _ScanFotoTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const Spacer(),
          Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              color: Color(0xFFF2F2F7),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.photo_camera_outlined,
              size: 64,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Foto Mobil Anda tampak Depan/Samping',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Posisikan kamera Anda dengan jelas dengan menghadap mobil. Sistem kami akan otomatis mengisi data merk, model, dan tahun.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 13,
              height: 1.5,
              color: AppColors.secondary,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Aksi Buka Kamera
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Ambil Foto Sekarang',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}