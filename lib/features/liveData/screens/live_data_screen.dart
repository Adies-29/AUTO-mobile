import 'package:auto/features/liveData/utils/sensor_data.dart';
import 'package:auto/features/shared/widgets/app_search_bar.dart';
import 'package:auto/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:auto/features/shared/widgets/my_app_bar.dart';

// 👇 Import yang diperlukan untuk fitur Not Connected 👇
import 'package:provider/provider.dart';
import 'package:auto/core/providers/car_status_provider.dart';
import 'package:auto/features/shared/widgets/not_connected_state.dart';

class LiveDataScreen extends StatefulWidget {
  const LiveDataScreen({super.key});

  @override
  State<LiveDataScreen> createState() => LiveDataScreenState();
}

class LiveDataScreenState extends State<LiveDataScreen>{
  final searchController = TextEditingController();
  String query = '';
  final sensors = SensorDefinitions.sensors;

  @override
  void dispose(){
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 👇 Cek status koneksi mobil 👇
    final carStatus = Provider.of<CarStatusProvider>(context);

    // Jika belum terhubung, tampilkan halaman peringatan
    if (!carStatus.isConnected) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: MyAppBar(title: 'Live Data'),
        body: const NotConnectedState(
          icon: Icons.monitor_heart_outlined,
          message: 'Hubungkan mobil anda terlebih dahulu untuk melihat data sensor secara real-time.',
        ),
      );
    }

    // 👇 Jika sudah terhubung, tampilkan UI Live Data (list sensor) seperti biasa 👇
    final q = query.toLowerCase();
    final rows = sensors
          .where((s) =>
            s['pid']!.toLowerCase().contains(q) ||
            s['name']!.toLowerCase().contains(q))
        .toList();

    return Scaffold(
      appBar: MyAppBar(title: 'Live Data'),
      body: Column(
        children: [
          AppSearchBar(
            controller: searchController,
            onChanged: (v) => setState(() => query = v ),
          ),
          const HeaderRow(),
          Expanded(
            child: rows.isEmpty ? 
              const Center(
                child: 
                  Text('Sensor tidak ditemukan',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 13,
                    color: AppColors.secondary,
                  ),
                ),
            )
            : ListView.builder(
              itemCount: rows.length,
              itemBuilder: (_, i) => SensorsRow(sensor: rows[i]),
            ),
          )
        ],
      )
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// KODE HEADER DAN SENSOR ROW DI BAWAH INI TETAP SAMA
// ─────────────────────────────────────────────────────────────────────────────

class HeaderRow extends StatelessWidget {
  const HeaderRow({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.secondary)),
      ),
      child: Row(
        children: const [
          Expanded(flex: 2, child: HeaderText('PID')),
          Expanded(flex: 6, child: HeaderText('Keterangan')),
          Expanded(
            flex: 3,
            child: HeaderText('NIlai', align: TextAlign.end),
          ),
        ],
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  final String text;
  final TextAlign align;

  const HeaderText(this.text, {this.align = TextAlign.start, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: const TextStyle(
        fontFamily: 'Manrope',
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.secondary,
      ),
    );
  }
}

class SensorsRow extends StatelessWidget {
  final Map<String, String> sensor;

  const SensorsRow({required this.sensor, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.secondary)),
      ),

      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              sensor['pid']!,
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.blueAccent,
              ),
            ),
          ),
           Expanded(
            flex: 6,
            child: Text(
              sensor['name']!,
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              sensor['value']!,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}