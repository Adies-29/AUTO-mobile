import 'package:auto/core/theme/colors.dart';
import 'package:auto/features/diagnostic/screens/models/dtc_model.dart';
import 'package:auto/features/shared/widgets/app_button.dart';
import 'package:auto/features/shared/widgets/dtc_card.dart';
import 'package:flutter/material.dart';
import 'package:auto/features/shared/widgets/tanya_ai.dart';
import 'package:auto/features/diagnostic/screens/diagnostic_detail.dart';
import 'package:auto/features/diagnostic/screens/dialog_pengertian_diag.dart';
import 'package:auto/features/shared/widgets/loading_dialog.dart';
import 'package:provider/provider.dart';
import 'package:auto/core/providers/car_status_provider.dart';
import 'package:auto/features/shared/widgets/bottom_nav_bar.dart';
import 'package:auto/main.dart';
import 'package:auto/features/diagnostic/screens/models/dummy_dtc_data.dart';

class DiagnosticResultsScreen extends StatefulWidget {
  final List<DtcModel>? dtcList; 
  final bool isTab; 

  const DiagnosticResultsScreen({
    super.key, 
    this.dtcList, 
    this.isTab = false, 
  });

  @override
  State<DiagnosticResultsScreen> createState() => _DiagnosticResultsScreenState();
}

class _DiagnosticResultsScreenState extends State<DiagnosticResultsScreen> {
  late List<DtcModel> _currentList;

  @override
  void initState() {
    super.initState();
    if (widget.dtcList != null) {
      _currentList = widget.dtcList!;
    } else {
      _currentList = [];
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _performScan();
      });
    }
  }

  void _performScan() async {
    showLoadingDialog(context);
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    Navigator.pop(context);

    final isError = DateTime.now().millisecond % 2 == 0;

    if (isError) {
      // 👇 Ambil data dari file pusat 👇
      final dummyData = DummyDtcData.engineErrors;

      Provider.of<CarStatusProvider>(context, listen: false)
          .updateCarStatus(hasError: true, dtcList: dummyData, isConnected: true);

      setState(() => _currentList = dummyData);
    } else {
      Provider.of<CarStatusProvider>(context, listen: false)
          .updateCarStatus(hasError: false, dtcList: [], isConnected: true);

      setState(() => _currentList = []);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isNormal = _currentList.isEmpty;

    final confirmed = _currentList.where((d) => d.status == 'Terkonfirmasi').toList();
    final pending = _currentList.where((d) => d.status == 'Pending').toList();
    final permanent = _currentList.where((d) => d.status == 'Permanent').toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      
      // 👇 PERBAIKAN: AppBar SELALU MUNCUL 👇
      appBar: AppBar(
        // Sembunyikan tombol back HANYA jika ini adalah tab
        automaticallyImplyLeading: false,
        leading: widget.isTab ? null : IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Diagnostic',
          style: TextStyle(
            fontFamily: 'Manrope', 
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
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
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isNormal 
                        ? AppColors.success.withValues(alpha: 0.15)
                        : AppColors.anomali.withValues(alpha: 0.15),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isNormal 
                          ? AppColors.success.withValues(alpha: 0.25)
                          : AppColors.anomali.withValues(alpha: 0.25),
                    ),
                    child: Icon(
                      isNormal ? Icons.check : Icons.warning_rounded,
                      size: 48,
                      color: isNormal ? AppColors.success : AppColors.anomali,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  isNormal 
                      ? 'Tidak ada anomali\natau masalah ditemukan'
                      : '${_currentList.length} Masalah ditemukan',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          Expanded(
            child: isNormal
                ? const SizedBox() 
                : ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    children: [
                      if (confirmed.isNotEmpty)
                        ExpansionTile(
                          title: Text('Terkonfirmasi DTC (${confirmed.length})'),
                          initiallyExpanded: true,
                          children: confirmed.map((dtc) => _buildDtcCard(context, dtc)).toList(),
                        ),
                      if (pending.isNotEmpty)
                        ExpansionTile(
                          title: Text('Pending DTC (${pending.length})'),
                          children: pending.map((dtc) => _buildDtcCard(context, dtc)).toList(),
                        ),
                      if (permanent.isNotEmpty)
                        ExpansionTile(
                          title: Text('Permanent DTC (${permanent.length})'),
                          children: permanent.map((dtc) => _buildDtcCard(context, dtc)).toList(),
                        ),
                      const SizedBox(height: 24),
                    ],
                  ),
          ),
          
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: AppButton(
              label: 'Scan Ulang',
              variant: AppButtonVariant.filled,
              onPressed: _performScan,
            ),
          ),
        ],
      ),

      // BottomNavBar TETAP disembunyikan jika dipanggil di dalam tab (agar tidak dobel)
      bottomNavigationBar: widget.isTab ? null : BottomNavBar(
        currentIndex: 2, 
        onTap: (index) {
          if (index == 2) {
            Navigator.pop(context);
          } else {
            Navigator.popUntil(context, (route) => route.isFirst); 
            MainScreen.mainKey.currentState?.setState(() {
              MainScreen.mainKey.currentState!.currentIndex = index;
            });
          }
        },
      ),
    );
  }

  Widget _buildDtcCard(BuildContext context, DtcModel dtc) {
    return DtcCard(
      code: dtc.code,
      title: dtc.title,
      description: dtc.description,
      onCardPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiagnosticDetailScreen(dtc: dtc),
          ),
        );
      },
      onAIPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TanyaAiScreen(dtcContext: dtc),
          ),
        );
      },
    );
  }
}