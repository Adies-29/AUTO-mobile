import 'package:auto/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:auto/features/shared/widgets/app_button.dart';
import 'package:auto/features/diagnostic/screens/dialog_pengertian_diag.dart';
import 'package:auto/features/diagnostic/screens/diagnostic_results_screen.dart';
import 'package:auto/features/diagnostic/screens/models/dtc_model.dart';
import 'package:auto/features/shared/widgets/loading_dialog.dart';
import 'package:provider/provider.dart';
import 'package:auto/core/providers/car_status_provider.dart';
import 'package:auto/features/diagnostic/screens/models/dummy_dtc_data.dart';

class DiagnosticScreen extends StatelessWidget {
  const DiagnosticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final carStatus = Provider.of<CarStatusProvider>(context);
    if (carStatus.isConnected) {
      return DiagnosticResultsScreen(
        // 👇 Panggil dari file pusat 👇
        dtcList: carStatus.hasError ? DummyDtcData.engineErrors : [], 
        isTab: true, 
      );
    }

    // 👇 JIKA BELUM TERHUBUNG (TAMPILAN AWAL TOMBOL SCAN) 👇
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
      body: Column(
        children: [
          const Spacer(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 32, left: 24, right: 24),
            child: AppButton(
              label: 'Scan',
              variant: AppButtonVariant.filled,
              onPressed: () => _performInitialScan(context),
            ),
          ),
        ],
      ),
    );
  }

  void _performInitialScan(BuildContext context) async {
    showLoadingDialog(context);
    await Future.delayed(const Duration(seconds: 2));

    if (!context.mounted) return;
    Navigator.pop(context);

    final isError = DateTime.now().millisecond % 2 == 0;

    // Simpan status ke provider, lalu UI akan otomatis berubah (karena menggunakan Provider)
    Provider.of<CarStatusProvider>(context, listen: false).updateCarStatus(
      hasError: isError,
      dtcList: [],
      isConnected: true,
    );
  }
}