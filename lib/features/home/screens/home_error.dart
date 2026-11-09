import 'package:flutter/material.dart';
import 'package:auto/core/theme/colors.dart';
import 'package:auto/features/home/widgets/home_app_bar.dart';
import 'package:auto/features/home/utils/telemetry_data.dart';
import 'package:auto/features/settings/widgets/detail_mobil.dart'; 
import 'package:auto/features/diagnostic/screens/diagnostic_results_screen.dart'; 
import 'package:auto/features/diagnostic/screens/models/dummy_dtc_data.dart';
import 'package:auto/features/shared/widgets/service_reminder.dart';

class HomeErrorScreen extends StatelessWidget {
  final String carName;
  final bool isConnected;
  final VoidCallback? onProfileTap;

  const HomeErrorScreen({
    super.key,
    this.carName = 'Avanza 2016',
    this.isConnected = true,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardTopBar(onProfileTap: onProfileTap),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ConnectionStatusLabel(connected: isConnected),
              const ServiceReminderBell(),
            ],
          ),
          const SizedBox(height: 10),
          const _CarShowcase(),
          const SizedBox(height: 10),
          ErrorCarInfoCard(carName: carName),
          const SizedBox(height: 16),
          
          // 👇 Data Telemetri Khusus Error (Suhu 120) 👇
          _TelemetryRowOne(
            left: HomeTelemetryData.speedRpm, 
            right: const [
              // Warna merah akan dideteksi otomatis oleh _TelemetryValue di bawah.
              TelemetryItem(value: '120', label: 'SUHU', isTemperature: true),
              TelemetryItem(value: '14.4 v', label: 'VOLTASE'),
            ],
          ),
          const SizedBox(height: 11),
          _TelemetryWideCard(items: HomeTelemetryData.trip),
        ],
      ),
    );
  }
}

class _ConnectionStatusLabel extends StatelessWidget {
  const _ConnectionStatusLabel({required this.connected});
  final bool connected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              // Titik merah untuk status error
              text: '• ',
              style: const TextStyle(color: AppColors.anomali),
            ),
            TextSpan(text: connected ? 'Connected' : 'Not Connected'),
          ],
        ),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
    );
  }
}

class _CarShowcase extends StatelessWidget {
  const _CarShowcase();

  @override
  Widget build(BuildContext context) {  
    return SizedBox(
      height: 200, 
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 20,
            child: Image.asset(
              'assets/images/avanza.png',
              height: 160,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.directions_car, size: 100, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class ErrorCarInfoCard extends StatelessWidget {
  final String carName;
  
  const ErrorCarInfoCard({required this.carName, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110, // Lebih tinggi karena ada tombol "Lihat Masalah"
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Color(0x26000000), blurRadius: 5, spreadRadius: 1, offset: Offset(0, 2)),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(23, 10, 12, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  carName,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 2),
                const _ErrorStatusRow(),
              ],
            ),
          ),
          
          // Teks "Lihat detail mobil"
          Positioned(
            right: 28,
            top: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailMobilScreen(),
                  ),
                );
              },
              behavior: HitTestBehavior.opaque,
              child: const Text(
                'Lihat detail mobil →',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: Color(0x80000000),
                ),
              ),
            ),
          ),
          
          // 👇 Tombol "Lihat Masalah" 👇
          Positioned(
            right: 28,
            bottom: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiagnosticResultsScreen(
                      dtcList: DummyDtcData.engineErrors,
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.anomali, // Warna merah
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Lihat Masalah',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorStatusRow extends StatelessWidget {
  const _ErrorStatusRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.error, size: 25, color: AppColors.anomali), // Ikon error merah
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Masalah Terdeteksi',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.anomali,
              ),
            ),
            Text(
              'Ada 4 masalah terdeteksi',
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TelemetryRowOne extends StatelessWidget {
  const _TelemetryRowOne({required this.left, required this.right});
  final List<TelemetryItem> left;
  final List<TelemetryItem> right;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _TelemetryGroupCard(items: left)),
        const SizedBox(width: 6),
        Expanded(child: _TelemetryGroupCard(items: right)),
      ],
    );
  }
}

class _TelemetryGroupCard extends StatelessWidget {
  const _TelemetryGroupCard({required this.items});
  final List<TelemetryItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 6, 5, 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Color(0x26000000), blurRadius: 5, spreadRadius: 1, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) const SizedBox(width: 6),
            // 👇 boxHeight diubah dari 56 menjadi 72 👇
            Expanded(child: _TelemetryTile(item: items[i], boxHeight: 72)),
          ],
        ],
      ),
    );
  }
}

class _TelemetryWideCard extends StatelessWidget {
  const _TelemetryWideCard({required this.items});
  final List<TelemetryItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Color(0x26000000), blurRadius: 5, spreadRadius: 1, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) const SizedBox(width: 6),
            // 👇 boxHeight diubah dari 31 menjadi 52 👇
            Expanded(child: _TelemetryTile(item: items[i], boxHeight: 52)),
          ],
        ],
      ),
    );
  }
}

class _TelemetryTile extends StatelessWidget {
  const _TelemetryTile({required this.item, required this.boxHeight});
  final TelemetryItem item;
  final double boxHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: boxHeight,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(13.5),
            boxShadow: const [
              BoxShadow(color: Color(0x26000000), blurRadius: 5, spreadRadius: 1, offset: Offset(0, 2)),
            ],
          ),
          child: FittedBox(fit: BoxFit.scaleDown, child: _TelemetryValue(item)),
        ),
        // 👇 Jarak label ditambah dari 4 menjadi 6 👇
        const SizedBox(height: 6), 
        Text(
          item.label,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}

class _TelemetryValue extends StatelessWidget {
  const _TelemetryValue(this.item);
  final TelemetryItem item;

  bool get isError => item.value == '120' && item.label == 'SUHU'; 

  @override
  Widget build(BuildContext context) {
    // Warna default hitam, berubah menjadi merah (anomali) jika error
    final color = isError ? AppColors.anomali : AppColors.black;

    final bigStyle = TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.bold,
      color: color,
      height: 1.1,
    );
    final smallStyle = TextStyle(
      fontSize: 9,
      fontWeight: FontWeight.bold,
      color: color,
    );

    if (item.isTemperature) {
      return Text.rich(
        TextSpan(
          children: [
            TextSpan(text: item.value, style: bigStyle),
            WidgetSpan(
              alignment: PlaceholderAlignment.top,
              child: Padding(
                padding: const EdgeInsets.only(left: 2, top: 3),
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: color, width: 0.8), // Border ikut berubah warna
                  ),
                ),
              ),
            ),
            TextSpan(
              text: ' C',
              style: bigStyle.copyWith(fontWeight: FontWeight.w200),
            ),
          ],
        ),
      );
    }

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: item.value, style: bigStyle),
          if (item.unit != null) TextSpan(text: item.unit, style: smallStyle),
        ],
      ),
    );
  }
}