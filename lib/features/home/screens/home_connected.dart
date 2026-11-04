import 'package:auto/features/home/utils/telemetry_data.dart';
import 'package:auto/features/home/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:auto/core/theme/colors.dart';
import 'package:auto/features/settings/widgets/detail_mobil.dart'; 


class HomeConnectedScreen extends StatelessWidget {
  final String carName;
  final bool isConnected;
  final VoidCallback? onProfileTap;
  final VoidCallback? onCarDetailTap;

  const HomeConnectedScreen({
    super.key,
    this.carName = 'Avanza 2016',
    this.isConnected = true,
    this.onProfileTap,
    this.onCarDetailTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardTopBar(onProfileTap: onProfileTap),
          const SizedBox(height: 16),
          _ConnectionStatusLabel(connected: isConnected),
          const SizedBox(height: 10),
          const _CarShowcase(),
          const SizedBox(height: 10),
          CarInfoCard(
            carName: carName,
            onDetailTap: onCarDetailTap,
          ),
          const SizedBox(height: 16),
          _TelemetryRowOne(left: HomeTelemetryData.speedRpm, right: HomeTelemetryData.tempVolt),
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
              text: '• ',
              style: TextStyle(color: connected ? AppColors.success : AppColors.statusGrey),
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
          // Gambar Mobil
          Positioned(
            bottom: 20,
            child: Image.asset(
              'assets/images/avanza.png', // Pastikan file ini ada di folder assets kamu
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

class CarInfoCard extends StatelessWidget {
  const CarInfoCard({required this.carName, this.onDetailTap, super.key});
  final String carName;
  final VoidCallback? onDetailTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 98,
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
                const _StatusRow(),
              ],
            ),
          ),
            Positioned(
            right: 28,
            top: 44,
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
        ],
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.check_circle, size: 25, color: AppColors.success),
        SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status normal',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            Text(
              'Tidak ada masalah terdeteksi',
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: Color(0x80000000),
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
            Expanded(child: _TelemetryTile(item: items[i], boxHeight: 56)),
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
            Expanded(child: _TelemetryTile(item: items[i], boxHeight: 31)),
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
        const SizedBox(height: 4),
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

  static const _big = TextStyle(
    fontSize: 23,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
    height: 1.1,
  );
  static const _small = TextStyle(
    fontSize: 9,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  @override
  Widget build(BuildContext context) {
    if (item.isTemperature) {
      return Text.rich(
        TextSpan(
          children: [
            TextSpan(text: item.value, style: _big),
            WidgetSpan(
              alignment: PlaceholderAlignment.top,
              child: Padding(
                padding: const EdgeInsets.only(left: 2, top: 3),
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.black, width: 0.8),
                  ),
                ),
              ),
            ),
            TextSpan(
              text: ' C',
              style: _big.copyWith(fontWeight: FontWeight.w200),
            ),
          ],
        ),
      );
    }

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: item.value, style: _big),
          if (item.unit != null) TextSpan(text: item.unit, style: _small),
        ],
      ),
    );
  }
}

