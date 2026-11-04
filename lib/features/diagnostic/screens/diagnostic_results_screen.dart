import 'package:auto/core/theme/colors.dart';
import 'package:auto/features/diagnostic/screens/models/dtc_model.dart';
import 'package:auto/features/shared/widgets/app_button.dart';
import 'package:auto/features/shared/widgets/dtc_card.dart';
import 'package:flutter/material.dart';

class DiagnosticResultsScreen extends StatelessWidget {
  final List<DtcModel> dtcList;

  const DiagnosticResultsScreen({super.key, required this.dtcList});

  @override
  Widget build(BuildContext context) {
    final confirmed = dtcList
        .where((d) => d.status == 'Terkonfirmasi')
        .toList();
    final pending = dtcList.where((d) => d.status == 'Pending').toList();
    final permanent = dtcList.where((d) => d.status == 'Permanent').toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Diagnostic'),
        elevation: 0,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.help_outline)),
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
                  '${dtcList.length} Masalah ditemukan',
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
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              children: [
                if (confirmed.isNotEmpty)
                  ExpansionTile(
                    title: Text('Terkonfirmasi DTC (${confirmed.length})'),
                    trailing: const Icon(Icons.arrow_drop_up),
                    initiallyExpanded: true,
                    children: confirmed
                        .map(
                          (dtc) => DtcCard(
                            code: dtc.code,
                            title: dtc.title,
                            description: dtc.description,
                            onSearchPressed: () {},
                            onAIPressed: () {},
                          ),
                        )
                        .toList(),
                  ),
                if (pending.isNotEmpty)
                  ExpansionTile(
                    title: Text('Pending DTC (${pending.length})'),
                    trailing: const Icon(Icons.arrow_drop_down),
                    children: pending
                        .map(
                          (dtc) => DtcCard(
                            code: dtc.code,
                            title: dtc.title,
                            description: dtc.description,
                            onSearchPressed: () {},
                            onAIPressed: () {},
                          ),
                        )
                        .toList(),
                  ),
                if (permanent.isNotEmpty)
                  ExpansionTile(
                    title: Text('Permanent DTC (${permanent.length})'),
                    trailing: const Icon(Icons.arrow_drop_down),
                    children: permanent
                        .map(
                          (dtc) => DtcCard(
                            code: dtc.code,
                            title: dtc.title,
                            description: dtc.description,
                            onSearchPressed: () {},
                            onAIPressed: () {},
                          ),
                        )
                        .toList(),
                  ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            ), // Tambah padding bawah
            child: AppButton(
              label: 'Scan Ulang',
              variant: AppButtonVariant.filled,
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
