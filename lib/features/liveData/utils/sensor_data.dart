/// Static OBD sensor definitions for the Live Data screen.
class SensorDefinitions {
  const SensorDefinitions._();

  static const sensors = [
    {'pid': 'LOAD', 'name': 'Calculated Engine Load', 'value': '40%'},
    {'pid': 'ECT', 'name': 'Engine Coolant Temperature', 'value': '72 °C'},
    {'pid': 'MAP', 'name': 'Intake Manifold Pressure', 'value': '70.0kPa'},
    {'pid': 'RPM', 'name': 'Engine Speed (RPM)', 'value': '3200'},
    {'pid': 'VSS', 'name': 'Vehicle Speed Sensor', 'value': '70 km/j'},
    {'pid': 'IAT', 'name': 'Intake Air Temperature', 'value': '30 °C'},
    {'pid': 'MAF', 'name': 'Mass Air Flow Rate', 'value': '78gram/sec'},
    {'pid': 'FRP', 'name': 'Fuel Rail Pressure', 'value': '73.0kPa'},
    {'pid': 'BARO', 'name': 'Barometric Pressure', 'value': '29.0kPa'},
    {'pid': 'VPWR', 'name': 'Control Module Voltage', 'value': '80v'},
    {'pid': 'AAT', 'name': 'Ambient Air Temperature', 'value': '25 °C'},
  ];
}