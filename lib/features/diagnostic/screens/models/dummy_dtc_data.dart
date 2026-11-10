import 'package:auto/features/diagnostic/screens/models/dtc_model.dart';

class DummyDtcData {
  // 👇 Satu-satunya tempat di mana data dummy ini ditulis 👇
  static final List<DtcModel> engineErrors = [
    DtcModel(
      code: 'P03200',
      title: 'Engine Temp',
      description: 'Suhu radiator terlalu tinggi, suhu mesin terlalu tinggi',
      status: 'Terkonfirmasi',
      detailDescription: 'Sensor ETC mendeteksi anomali suhu yang tidak wajar. Suhu menunjukan 120 derajat secara terus menerus selama beberapa hari.',
      possibleCauses: ['Masalah pada sensor WTS', 'Radiator mampet', 'Air Radiator berkurang'],
      suggestedActions: ['Ngecek sensor', 'Segera ke bengkel terdekat'],
    ),
    DtcModel(
      code: 'P04400',
      title: 'Engine and Transmission',
      description: 'Fuel Volume Regulator Control high',
      status: 'Terkonfirmasi',
      detailDescription: 'ECM mendeteksi tegangan kontrol regulator volume bahan bakar melebihi ambang batas.',
      possibleCauses: ['Fuel Volume Regulator rusak', 'Tekanan bahan bakar berlebih'],
      suggestedActions: ['Periksa konektor dan kabel regulator', 'Bersihkan atau ganti Fuel Volume Regulator'],
    ),
    DtcModel(
      code: 'P01000',
      title: 'Mass Air Flow Sensor',
      description: 'Mass or Volume Air Flow Circuit low',
      status: 'Pending',
      detailDescription: 'Sinyal dari sensor MAF berada di bawah nilai minimum.',
      possibleCauses: ['Filter udara kotor', 'Sensor MAF kotor'],
      suggestedActions: ['Bersihkan sensor MAF', 'Ganti filter udara'],
    ),
    DtcModel(
      code: 'P03000',
      title: 'Random/Multiple Cylinder Misfire',
      description: 'Engine misfire detected',
      status: 'Permanent',
      detailDescription: 'ECM mendeteksi misfire pada beberapa silinder secara acak.',
      possibleCauses: ['Busi aus atau rusak', 'Koil pengapian lemah'],
      suggestedActions: ['Ganti busi', 'Periksa kondisi koil pengapian'],
    ),
  ];
}