import 'package:flutter/material.dart';
import 'package:auto/features/diagnostic/screens/models/dtc_model.dart';

class CarStatusProvider extends ChangeNotifier {
  bool _hasError = false;
  bool _isConnected = false; // 👈 Tambahkan ini
  List<DtcModel> _dtcList = [];

  bool get hasError => _hasError;
  bool get isConnected => _isConnected;
  List<DtcModel> get dtcList => _dtcList;

  void updateCarStatus({
    required bool hasError, 
    required List<DtcModel> dtcList, 
    bool isConnected = true, // 👈 Default true jika dipanggil dari Home
  }) {
    _hasError = hasError;
    _dtcList = dtcList;
    _isConnected = isConnected;
    notifyListeners();
  }
}