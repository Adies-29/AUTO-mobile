import 'package:auto/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:auto/features/diagnostic/screens/dialog_pengertian_diag.dart';
import 'package:auto/features/diagnostic/screens/diagnostic_results_screen.dart';
import 'package:auto/features/diagnostic/screens/models/dummy_dtc_data.dart';
import 'package:provider/provider.dart';
import 'package:auto/core/providers/car_status_provider.dart';
import 'package:auto/features/shared/widgets/not_connected_state.dart'; // 👈 Import widget baru

class DiagnosticScreen extends StatelessWidget {
  const DiagnosticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final carStatus = Provider.of<CarStatusProvider>(context);
    
    // Jika mobil SUDAH terhubung, otomatis tampilkan hasil scan
    if (carStatus.isConnected) {
      return DiagnosticResultsScreen(
        dtcList: carStatus.hasError ? DummyDtcData.engineErrors : [], 
        isTab: true, 
      );
    }

    // 👇 Jika BELUM terhubung, tampilkan Empty State (tanpa tombol Scan) 👇
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Diagnostic',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Manrope',
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.help_outline, color: Colors.black, size: 28),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DialogPengertianDiag()),
                );
              },
            ),
          ),
        ],
      ),
      body: const NotConnectedState(
        icon: Icons.bluetooth_disabled_rounded,
        message: 'Hubungkan mobil anda terlebih dahulu untuk memulai proses diagnostik.',
      ),
    );
  }
}