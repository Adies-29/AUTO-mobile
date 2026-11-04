import 'package:auto/core/theme/colors.dart';
import 'package:flutter/material.dart';

class CarStatusCard extends StatelessWidget {
  final String carName;
  final String statusText;
  final bool isNormal;
  final String detailText;
  final String detailLink;

  // Statistik dibagi menjadi beberapa kelompok.
  final List<List<Map<String, String>>> statGroups;

  const CarStatusCard({
    super.key,
    required this.carName,
    required this.statusText,
    required this.detailText,
    required this.statGroups,
    this.detailLink = 'Lihat detail mobil →',
    this.isNormal = true,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = isNormal ? AppColors.success : AppColors.anomali;

    final valueColor = isNormal ? AppColors.primary : AppColors.anomali;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =========================
          // HEADER KENDARAAN
          // =========================
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      carName,
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),

                        const SizedBox(width: 8),

                        Text(
                          statusText,
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      detailText,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 12,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Flexible(
                child: Text(
                  detailLink,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // =========================
          // KELOMPOK STATISTIK
          // =========================
          if (statGroups.isNotEmpty)
            Column(
              children: [
                // BARIS PERTAMA: 2 KELOMPOK
                if (statGroups.length >= 2)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: StatGroupCard(
                          stats: statGroups[0],
                          valueColor: valueColor,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: StatGroupCard(
                          stats: statGroups[1],
                          valueColor: valueColor,
                        ),
                      ),
                    ],
                  )
                else
                  StatGroupCard(stats: statGroups[0], valueColor: valueColor),

                // BARIS KEDUA DAN SETERUSNYA
                for (int i = 2; i < statGroups.length; i++) ...[
                  const SizedBox(height: 16),

                  StatGroupCard(stats: statGroups[i], valueColor: valueColor),
                ],
              ],
            ),
        ],
      ),
    );
  }
}

// =====================================================
// STAT GROUP CARD (OUTER CARD)
// =====================================================

class StatGroupCard extends StatelessWidget {
  final List<Map<String, String>> stats;
  final Color valueColor;

  const StatGroupCard({
    super.key,
    required this.stats,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    if (stats.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFF0F0F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: stats.map((stat) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: StatCard(
                value: stat['value'] ?? '-',
                unit: stat['unit'] ?? '',
                label: stat['label'] ?? '',
                valueColor: valueColor,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// =====================================================
// STAT CARD (INNER CARD)
// =====================================================

class StatCard extends StatelessWidget {
  final String value;
  final String unit;
  final String label;
  final Color valueColor;

  const StatCard({
    super.key,
    required this.value,
    this.unit = '',
    required this.label,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 110),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFF1F1F1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ANGKA DAN SATUAN
          FittedBox(
            fit: BoxFit.scaleDown,
            child: RichText(
              maxLines: 1,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: valueColor,
                    ),
                  ),

                  if (unit.isNotEmpty)
                    TextSpan(
                      text: ' $unit',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: valueColor,
                      ),
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 5),

          // LABEL METRIK
          SizedBox(
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                maxLines: 1,
                softWrap: false,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


