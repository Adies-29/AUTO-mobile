import 'package:auto/shared/widgets/car_status_card.dart';
import 'package:auto/shared/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeAppBar(),
            SizedBox(height: 40),

            CarStatusCard(
              carName: 'Avanza 2016',
              statusText: 'Status normal',
              isNormal: true,
              detailText: 'Tidak ada kerusakan terdeteksi',
              detailLink: 'Lihat detail mobil →',

              statGroups: [
                // Kelompok 1: SPEED dan RPM
                [
                  {'value': '70', 'label': 'SPEED KM/J'},
                  {'value': '3200', 'label': 'RPM'},
                ],

                // Kelompok 2: SUHU dan VOLTASE
                [
                  {'value': '72', 'unit': '°C', 'label': 'SUHU'},
                  {'value': '14.4', 'unit': 'V', 'label': 'VOLTASE'},
                ],

                // Kelompok 3: ODO, TRIP OLI, WAKTU PERJALANAN
                [
                  {'value': '130.330', 'label': 'ODO'},
                  {'value': '1200', 'unit': 'KM', 'label': 'Trip Oli'},
                  {'value': '5', 'unit': 'JAM', 'label': 'Waktu'},
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
