import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto/core/theme/colors.dart';
import 'package:auto/core/providers/reminder_provider.dart';

class ReminderSettingsSheet extends StatefulWidget {
  const ReminderSettingsSheet({super.key});

  @override
  State<ReminderSettingsSheet> createState() => _ReminderSettingsSheetState();
}

class _ReminderSettingsSheetState extends State<ReminderSettingsSheet> {
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ReminderProvider>(context, listen: false);
    _dateController = TextEditingController(text: provider.formatDate(provider.lastServiceDate));
  }

  // Fungsi menampilkan kalender
  Future<void> _pickDate(BuildContext context) async {
    final provider = Provider.of<ReminderProvider>(context, listen: false);
    
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: provider.lastServiceDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary, // Warna kalender hitam
              onPrimary: Colors.white,
              onSurface: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      provider.setLastServiceDate(picked);
      setState(() {
        _dateController.text = provider.formatDate(picked);
      });
    }
  }

  // Fungsi matematika untuk menambah bulan
  DateTime _addMonths(DateTime date, int months) {
    int year = date.year;
    int month = date.month + months;
    while (month > 12) {
      month -= 12;
      year++;
    }
    int day = date.day;
    final daysInMonth = DateUtils.getDaysInMonth(year, month);
    if (day > daysInMonth) day = daysInMonth;
    return DateTime(year, month, day);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReminderProvider>(context);
    final lastDate = provider.lastServiceDate;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Indikator Bar
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 24),
          
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.black.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.calendar_month_rounded, color: AppColors.black, size: 28),
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Atur Jadwal Servis', style: TextStyle(fontFamily: 'Manrope', fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Pilih tanggal terakhir ganti oli', style: TextStyle(fontFamily: 'Manrope', fontSize: 12, color: AppColors.secondary)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Kolom Tanggal
          const Text('Tanggal Terakhir Ganti Oli', style: TextStyle(fontFamily: 'Manrope', fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _dateController,
            readOnly: true,
            onTap: () => _pickDate(context),
            style: const TextStyle(fontFamily: 'Manrope', fontSize: 14, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF2F2F7),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              suffixIcon: const Icon(Icons.calendar_today_outlined, size: 20, color: AppColors.secondary),
            ),
          ),
          
          const SizedBox(height: 24),
          const Divider(color: AppColors.border),
          const SizedBox(height: 16),

          // Prediksi Otomatis
          const Text('Estimasi Servis Berikutnya', style: TextStyle(fontFamily: 'Manrope', fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          
          _buildPredictionCard('Ganti Oli (3 Bulan)', provider.formatDate(_addMonths(lastDate, 3))),
          const SizedBox(height: 8),
          _buildPredictionCard('Servis Besar (6 Bulan)', provider.formatDate(_addMonths(lastDate, 6))),
          const SizedBox(height: 8),
          _buildPredictionCard('Servis Tahunan (1 Tahun)', provider.formatDate(_addMonths(lastDate, 12))),

          const SizedBox(height: 32),

          // Tombol Simpan
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              child: const Text('Simpan Pengaturan', style: TextStyle(fontFamily: 'Manrope', fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk kartu prediksi
  Widget _buildPredictionCard(String title, String date) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontFamily: 'Manrope', fontSize: 13, color: AppColors.secondary)),
          Text(date, style: const TextStyle(fontFamily: 'Manrope', fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primary)),
        ],
      ),
    );
  }
}