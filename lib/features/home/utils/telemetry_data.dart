class TelemetryItem {
  const TelemetryItem({
    required this.value,
    required this.label,
    this.unit,
    this.isTemperature = false,
  });

  final String value;
  final String label;
  final String? unit;
  final bool isTemperature;
}

/// Static telemetry datasets for HomeConnectedScreen.
class HomeTelemetryData {
  const HomeTelemetryData._();

  static const speedRpm = [
    TelemetryItem(value: '70', label: 'SPEED KM/J'),
    TelemetryItem(value: '3200', label: 'RPM'),
  ];

  static const tempVolt = [
    TelemetryItem(value: '72', label: 'SUHU', isTemperature: true),
    TelemetryItem(value: '14.4 v', label: 'VOLTASE'),
  ];

  static const trip = [
    TelemetryItem(value: '130.330', label: 'ODO'),
    TelemetryItem(value: '1200', unit: 'KM', label: 'Trip Oli'),
    TelemetryItem(value: '5', unit: 'JAM', label: 'Waktu Perjalanan/h'),
  ];
}