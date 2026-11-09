import 'package:flutter/material.dart';

class ReminderProvider extends ChangeNotifier {
  bool _isReminderActive = true;
  // Default: Hari ini
  DateTime _lastServiceDate = DateTime.now(); 

  bool get isReminderActive => _isReminderActive;
  DateTime get lastServiceDate => _lastServiceDate;

  void toggleReminder(bool value) {
    _isReminderActive = value;
    notifyListeners();
  }

  void setLastServiceDate(DateTime date) {
    _lastServiceDate = date;
    notifyListeners();
  }

  // Fungsi untuk memformat tanggal (Contoh: 10 Mei 2024)
  String formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 
      'Jul', 'Ags', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return "${date.day} ${months[date.month - 1]} ${date.year}";
  }
}