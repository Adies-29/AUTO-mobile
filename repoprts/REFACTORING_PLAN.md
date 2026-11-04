# REFACTORING PLAN

## 1. Objective

Melakukan refactoring pada project Flutter dengan tujuan meningkatkan kualitas arsitektur kode melalui pemisahan tanggung jawab setiap komponen.

Refactoring dilakukan tanpa mengubah fungsionalitas, alur aplikasi, desain antarmuka, dan perilaku sistem yang sudah berjalan.

## 2. Architecture Approach

Menggunakan pendekatan **Feature-Based Architecture**.

Setiap fitur memiliki struktur kode yang terorganisasi berdasarkan tanggung jawabnya.

### Recommended Structure

```text
lib/
├── core/
│   ├── constants/
│   ├── utils/
│   └── theme/
│       ├── colors.dart
│       ├── spacing.dart
│       └── typography.dart
│
├── features/
│   ├── auth/
│   │   ├── screens/
│   │   ├── widgets/
│   │   ├── services/
│   │   ├── models/
│   │   └── controllers/
│   │
│   ├── home/
│   │   ├── screens/
│   │   ├── widgets/
│   │   ├── services/
│   │   ├── models/
│   │   └── controllers/
│   │
│   ├── diagnostic/
│   │   ├── screens/
│   │   ├── widgets/
│   │   ├── services/
│   │   ├── models/
│   │   └── controllers/
│   │
│   ├── live_data/
│   │   ├── screens/
│   │   ├── widgets/
│   │   ├── services/
│   │   ├── models/
│   │   └── controllers/
│   │
│   └── settings/
│       ├── screens/
│       └── widgets/
│
├── shared/
│   └── widgets/
│
├── app.dart
├── main.dart
└── router.dart
```

Catatan:
- Struktur di atas merupakan target arsitektur, bukan kewajiban membuat seluruh folder sekaligus.
- Folder dibuat ketika memang dibutuhkan.
- Pertahankan library dan state management yang sudah digunakan project.
- Jangan memindahkan file sebelum dependensinya dianalisis.

## 3. Component Separation Guidelines

### 3.1. Screens

Lokasi: `features/[feature_name]/screens/`

Tanggung jawab:
- Menyusun tampilan halaman.
- Mengatur komposisi widget.
- Menghubungkan tampilan dengan state yang diperlukan.
- Mengatur interaksi navigasi pada tingkat halaman.

Screen tidak seharusnya menjadi tempat seluruh implementasi business logic dan komponen UI.

### 3.2. Widgets

Lokasi: `features/[feature_name]/widgets/`

Tanggung jawab:
- Menampung komponen UI khusus fitur.
- Memisahkan widget yang kompleks.
- Menyediakan komponen yang dapat digunakan kembali dalam fitur terkait.

### 3.3. Shared Widgets

Lokasi: `shared/widgets/`

Tanggung jawab:
- Menampung komponen UI yang digunakan oleh beberapa fitur.
- Menjaga konsistensi desain aplikasi.
- Menghindari duplikasi komponen.

Jangan memindahkan widget ke shared jika hanya digunakan oleh satu fitur dan memiliki ketergantungan khusus terhadap fitur tersebut.

### 3.4. Services

Lokasi: `features/[feature_name]/services/`

Tanggung jawab:
- Menangani komunikasi API.
- Mengelola proses komunikasi dengan sumber data.
- Menangani operasi eksternal yang berkaitan dengan fitur.

### 3.5. Models

Lokasi: `features/[feature_name]/models/`

Tanggung jawab:
- Mendefinisikan struktur data.
- Menangani proses serialisasi dan deserialisasi jika diperlukan.
- Menjaga konsistensi representasi data.

### 3.6. Controllers

Lokasi: `features/[feature_name]/controllers/`

Tanggung jawab:
- Mengelola state dan interaksi fitur jika sesuai dengan arsitektur yang digunakan.
- Memisahkan logika pengelolaan state dari UI.
- Mengatur proses yang berkaitan dengan interaksi pengguna.

Jangan membuat controller baru jika project sudah memiliki mekanisme state management yang menjalankan tanggung jawab tersebut.

## 4. Refactoring Priority

Urutan awal pengerjaan:

1. Home
2. Auth
3. Diagnostic
4. Live Data
5. Settings
6. Shared Widgets
7. Core dan konfigurasi global

Urutan tersebut dapat disesuaikan berdasarkan hasil CODE_REVIEW.md dan tingkat risiko masing-masing fitur.

## 5. Refactoring Workflow

### Phase 1 - Project Analysis

- Periksa struktur folder.
- Identifikasi dependensi antar-file.
- Periksa implementasi setiap Screen.
- Identifikasi duplikasi kode.
- Identifikasi komponen yang dapat dipisahkan.
- Periksa mekanisme state management.

Output:
- Laporan code review.
- Daftar masalah.
- Rekomendasi struktur.

### Phase 2 - Refactoring Preparation

- Tentukan file yang akan dipisahkan.
- Tentukan lokasi file baru.
- Identifikasi dependensi dan import.
- Identifikasi risiko perubahan.
- Tentukan urutan pengerjaan.

Output:
- Rencana refactoring per fitur.

### Phase 3 - Implementation

- Refactor satu fitur dalam satu waktu.
- Pisahkan komponen UI.
- Pisahkan business logic.
- Pisahkan services dan models jika diperlukan.
- Perbarui import dan navigasi.
- Pertahankan implementasi yang sudah berjalan.

Output:
- Source code yang sudah direstrukturisasi.

### Phase 4 - Validation

Jalankan pemeriksaan berikut:

```bash
flutter analyze
```

Jalankan pengujian:

```bash
flutter test
```

Jika aplikasi menggunakan perangkat fisik atau integrasi eksternal, lakukan pengujian tambahan sesuai kebutuhan.

Periksa:
- Tidak ada error kompilasi.
- Tidak ada import yang rusak.
- Navigasi tetap berjalan.
- UI tetap konsisten.
- Business logic tetap berfungsi.
- Integrasi eksternal tetap berjalan.

Output:
- Hasil validasi.
- Daftar masalah yang masih tersisa.

### Phase 5 - Documentation

- Catat perubahan yang telah dilakukan.
- Catat file baru.
- Catat file yang dipindahkan.
- Catat file yang dihapus jika ada.
- Catat hasil pengujian.
- Perbarui REFACTORING_HISTORY.md.

## 6. Refactoring Rules

1. Jangan mengubah fungsionalitas aplikasi.
2. Jangan mengubah desain UI tanpa persetujuan.
3. Jangan menghapus fitur yang sudah tersedia.
4. Jangan mengganti package atau dependency tanpa persetujuan.
5. Jangan mengganti state management tanpa persetujuan.
6. Jangan membuat abstraksi berlebihan.
7. Jangan memisahkan kode hanya untuk mengurangi jumlah baris.
8. Jangan melakukan refactoring besar secara bersamaan.
9. Pertahankan kompatibilitas dengan router dan konfigurasi aplikasi.
10. Pastikan setiap perubahan dapat ditelusuri.

## 7. Definition of Done

Refactoring dinyatakan selesai apabila:

- [ ] Tanggung jawab setiap file sudah jelas.
- [ ] Tidak ada duplikasi kode yang tidak diperlukan.
- [ ] Screen lebih fokus pada komposisi UI.
- [ ] Komponen kompleks telah dipisahkan secara tepat.
- [ ] Business logic berada pada lokasi yang sesuai.
- [ ] Import dan navigasi tetap berjalan.
- [ ] Tidak ada error baru dari Flutter Analyze.
- [ ] Pengujian yang relevan berhasil.
- [ ] Tidak ada perubahan fungsionalitas yang tidak disengaja.
- [ ] Dokumentasi perubahan telah diperbarui.

## 8. Final Goal

Menghasilkan struktur project Flutter yang modular, maintainable, scalable, dan mengikuti prinsip clean code dengan tetap mempertahankan seluruh fungsionalitas aplikasi.