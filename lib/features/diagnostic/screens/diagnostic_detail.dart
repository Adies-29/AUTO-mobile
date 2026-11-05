import 'package:auto/core/theme/colors.dart';
import 'package:auto/features/diagnostic/screens/models/dtc_model.dart';
import 'package:flutter/material.dart';

class DiagnosticDetailScreen extends StatelessWidget {
  final DtcModel dtc;

  const DiagnosticDetailScreen({super.key, required this.dtc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'DTC Detail',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header Card (Kode, Judul, Deskripsi singkat) ---
            _buildHeaderCard(),
            const SizedBox(height: 24),

            // --- Deskripsi ---
            if (dtc.detailDescription != null) ...[
              _buildSectionTitle('Deskripsi'),
              const SizedBox(height: 8),
              Text(
                dtc.detailDescription!,
                style: const TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 14,
                  color: AppColors.secondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
            ],

            // --- Kemungkinan Masalah ---
            if (dtc.possibleCauses != null && dtc.possibleCauses!.isNotEmpty) ...[
              _buildSectionTitle('Kemungkinan masalah'),
              const SizedBox(height: 8),
              _buildBulletList(dtc.possibleCauses!),
              const SizedBox(height: 24),
            ],

            // --- Saran Tindakan ---
            if (dtc.suggestedActions != null && dtc.suggestedActions!.isNotEmpty) ...[
              _buildSectionTitle('Saran Tindakan'),
              const SizedBox(height: 8),
              _buildBulletList(dtc.suggestedActions!),
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }

  // Widget Header Card: menampilkan kode DTC, judul, dan deskripsi singkat
  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dtc.code,
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            dtc.title,
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            dtc.description,
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  // Widget judul section (Deskripsi, Kemungkinan masalah, Saran Tindakan)
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Manrope',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      ),
    );
  }

  // Widget bullet list (• item)
  Widget _buildBulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '• ',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 14,
                      color: AppColors.secondary,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 14,
                        color: AppColors.secondary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}