import 'package:auto/core/theme/colors.dart';
import 'package:auto/features/shared/widgets/dtc_card.dart';
import 'package:flutter/material.dart';
import 'package:auto/features/shared/widgets/app_button.dart';
import 'package:auto/features/diagnostic/screens/models/dtc_model.dart'; // Pastikan ini ada
import 'package:auto/features/shared/widgets/my_app_bar.dart';

class DiagnosticScreen extends StatefulWidget {
  const DiagnosticScreen({super.key});

  @override
  State<DiagnosticScreen> createState() => _DiagnosticScreenState();
}

class _DiagnosticScreenState extends State<DiagnosticScreen> {
  bool _showNoAnomalies = false; // State untuk menampilkan UI "tidak ada anomali"
  List<DtcModel>? _scanResults;

  // State untuk tracking expand/collapse ExpansionTile
  bool _confirmedExpanded = true;
  bool _pendingExpanded = false;
  bool _permanentExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: ('Diagnostic')),
      body: Column(
        children: [
          const SizedBox(height: 16),
          if(_scanResults == null)
          Expanded(
            child: _showNoAnomalies
                ? _buildNoAnomaliesContent() // UI jika tidak ada anomali
                : _buildInitialContent(), // UI awal atau jika ada anomali
          )
          else
          Expanded(
            child: _buildScanResultsContent()),
          Padding(
            padding: const EdgeInsets.only(bottom: 16), // Space untuk bottom nav
            child: AppButton(
              label:  _scanResults != null ? 'Scan Ulang' : 'Scan',
              onPressed: _scanResults != null ? _resetScan : _performScan,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialContent() {
    return Column(
      children: [
        const Spacer(), // Dorong tombol ke bawah
      ],
    );
  }

  Widget _buildNoAnomaliesContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.success.withValues(alpha: 0.15), // Warna hijau muda
          ),
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.success.withValues(alpha: 0.25), // Warna hijau lebih gelap
            ),
            child: const Icon(
              Icons.check, // Icon ceklis
              size: 48,
              color: AppColors.success, // Warna hijau
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Tidak ada anomali',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        const Text(
          'atau masalah ditemukan',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        const Spacer(), // Dorong tombol ke bawah
      ],
    );
  }
  Widget _buildScanResultsContent() {
    if (_scanResults == null || _scanResults!.isEmpty) return const SizedBox();

    final confirmed =
        _scanResults!.where((d) => d.status == 'Terkonfirmasi').toList();
    final pending = _scanResults!.where((d) => d.status == 'Pending').toList();
    final permanent =
        _scanResults!.where((d) => d.status == 'Permanent').toList();

    return Column(
      children: [
        const SizedBox(height: 16),
        // Warning icon section
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.anomali.withValues(alpha: 0.15),
          ),
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.anomali.withValues(alpha: 0.25),
            ),
            child: const Icon(
              Icons.warning_rounded,
              size: 48,
              color: AppColors.anomali,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '${_scanResults!.length} Masalah ditemukan',
          style: const TextStyle(
            fontFamily: 'Manrope',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 16),
        // Konten DTC yang scrollable
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 0).copyWith(bottom: 90),
            children: [
              if (confirmed.isNotEmpty)
                ExpansionTile(
                  title: Text('Terkonfirmasi DTC (${confirmed.length})'),
                  trailing: AnimatedRotation(
                    turns: _confirmedExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.arrow_drop_down),
                  ),
                  initiallyExpanded: _confirmedExpanded,
                  onExpansionChanged: (expanded) {
                    setState(() {
                      _confirmedExpanded = expanded;
                    });
                  },
                  children: confirmed
                      .map((dtc) => DtcCard(
                            code: dtc.code,
                            title: dtc.title,
                            description: dtc.description,
                            onSearchPressed: () {},
                            onAIPressed: () {},
                          ))
                      .toList(),
                ),
              if (pending.isNotEmpty)
                ExpansionTile(
                  title: Text('Pending DTC (${pending.length})'),
                  trailing: AnimatedRotation(
                    turns: _pendingExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.arrow_drop_down),
                  ),
                  initiallyExpanded: _pendingExpanded,
                  onExpansionChanged: (expanded) {
                    setState(() {
                      _pendingExpanded = expanded;
                    });
                  },
                  children: pending
                      .map((dtc) => DtcCard(
                            code: dtc.code,
                            title: dtc.title,
                            description: dtc.description,
                            onSearchPressed: () {},
                            onAIPressed: () {},
                          ))
                      .toList(),
                ),
              if (permanent.isNotEmpty)
                ExpansionTile(
                  title: Text('Permanent DTC (${permanent.length})'),
                  trailing: AnimatedRotation(
                    turns: _permanentExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.arrow_drop_down),
                  ),
                  initiallyExpanded: _permanentExpanded,
                  onExpansionChanged: (expanded) {
                    setState(() {
                      _permanentExpanded = expanded;
                    });
                  },
                  children: permanent
                      .map((dtc) => DtcCard(
                            code: dtc.code,
                            title: dtc.title,
                            description: dtc.description,
                            onSearchPressed: () {},
                            onAIPressed: () {},
                          ))
                      .toList(),
                ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }

  void _performScan() {
    // Simulasi hasil scan
    final List<DtcModel> dummyData = [
      // Jika mau test "tidak ada anomali", kosongkan list ini: []
      // Jika mau test "ada anomali", isi dengan data ini:
      DtcModel(
        code: 'P03200',
        title: 'Engine Temp',
        description:
            'Suhu radiator terlalu tinggi, suhu mesin terlalu tinggi',
        status: 'Terkonfirmasi',
      ),
      DtcModel(
        code: 'P04400',
        title: 'Engine and Transmission',
        description: 'Fuel Volume Regulator Control high',
        status: 'Terkonfirmasi',
      ),
      DtcModel(
        code: 'P01000',
        title: 'Mass Air Flow Sensor',
        description: 'Mass or Volume Air Flow Circuit low',
        status: 'Pending',
      ),
      DtcModel(
        code: 'P03000',
        title: 'Random/Multiple Cylinder Misfire',
        description: 'Engine misfire detected',
        status: 'Permanent',
      ),
      // DtcModel(
      //   code: 'P04200',
      //   title: 'Catalyst System Efficiency',
      //   description: 'Catalyst system efficiency below threshold',
      //   status: 'Permanent',
      // ),
    ];

    setState(() {
      if (dummyData.isEmpty) {
        // Tidak ada anomali
        _showNoAnomalies = true;
        _scanResults = null;
      } else {
        // Ada anomali, tampilkan hasil scan inline (bottom nav tetap muncul)
        _scanResults = dummyData;
        _showNoAnomalies = false;
      }
    });
  }
  void _resetScan() {
    setState(() {
      _scanResults = null;
      _showNoAnomalies = false;
    });
  }
}