// class DtcModel {
//   final String code;
//   final String title;
//   final String description;
//   final String status;
//   DtcModel({
//     required this.code,
//     required this.title,
//     required this.description,
//     required this.status,
//   });
// }
class DtcModel {
  final String code;
  final String title;
  final String description;
  final String status;
  
  // --- Field baru untuk halaman detail ---
  final String? detailDescription;        // Penjelasan panjang untuk bagian "Deskripsi"
  final List<String>? possibleCauses;     // Daftar "Kemungkinan masalah"
  final List<String>? suggestedActions;   // Daftar "Saran Tindakan"

  DtcModel({
    required this.code,
    required this.title,
    required this.description,
    required this.status,
    this.detailDescription,
    this.possibleCauses,
    this.suggestedActions,
  });
}

