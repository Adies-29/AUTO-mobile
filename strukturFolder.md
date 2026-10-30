# 📂 Penjelasan Struktur Folder Project AUTO & Contoh Singkat

Dokumen ini memandu Anda dalam memahami fungsi serta contoh bentuk kode dari setiap folder dan file yang ada di dalam direktori `lib/`.

## 1. Root & Konfigurasi Utama (`lib/`)

* **`main.dart`**: Titik awal (*entry point*) aplikasi dijalankan.

  ```dart
  void main() {
    runApp(const App());
  }
  ```

* **`app.dart`**: Konfigurasi utama aplikasi dan tema global.

  ```dart
  class App extends StatelessWidget {
    const App({super.key});
    @override
    Widget build(BuildContext context) {
      return MaterialApp.router(
        routerConfig: router,
        theme: AppTheme.lightTheme,
      );
    }
  }
  ```

* **`router.dart`**: Pusat pengaturan navigasi (*routing*).

  ```dart
  final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    ],
  );
  ```

## 2. Sistem Desain (`lib/theme/`)

Tempat menyimpan token desain agar konsisten tanpa nilai *hardcoded*.

* **`colors.dart`**: Definisi warna.

  ```dart
  class AppColors {
    static const primary = Color(0xFF6200EE);
    static const background = Color(0xFFFFFFFF);
    static const textDark = Color(0xFF1C1B1F);
  }
  ```

* **`typography.dart`**: Gaya teks terpusat.

* **`spacing.dart`**: Standar ukuran jarak.

  ```dart
  class AppSpacing {
    static const double sm = 8.0;
    static const double md = 16.0;
    static const double lg = 24.0;
  }
  ```

* **`app_theme.dart`**: Menggabungkan semuanya ke `ThemeData`.

## 3. Komponen Bersama (`lib/shared/widgets/`)

Komponen UI reusabel yang dipakai oleh minimal 2 domain.

* **`app_button.dart`**: Tombol kustom standar.

  ```dart
  class AppButton extends StatelessWidget {
    final String label;
    final VoidCallback onPressed;
    
    const AppButton({super.key, required this.label, required this.onPressed});

    @override
    Widget build(BuildContext context) {
      return ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      );
    }
  }
  ```

* **`app_text_field.dart`**: Kotak input form universal.

* **`app_scaffold.dart`**: Kerangka layar standar.

* **`app_dialog.dart`**, **`loading_overlay.dart`**, **`empty_state.dart`**.

## 4. Layar & Fitur (`lib/screens/`)

### A. Domain Auth (`lib/screens/auth/`)

* **`login_screen.dart`**: Halaman login utama.

* **`register_screen.dart`**: Halaman registrasi pengguna baru.

  ```dart
  class RegisterScreen extends StatelessWidget {
    const RegisterScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  AuthHeader(
                    title: 'Daftar Akun Baru',
                    subtitle: 'Lengkapi data untuk membuat akun',
                  ),
                  SizedBox(height: AppSpacing.lg),
                  RegisterForm(),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
  ```

* **`forgot_password_screen.dart`**: Halaman pemulihan sandi.

* **`widgets/` (Khusus Auth):**

  * **`auth_header.dart`**: Judul dan subjudul khusus halaman auth.

    ```dart
    class AuthHeader extends StatelessWidget {
      final String title;
      final String subtitle;

      const AuthHeader({
        super.key,
        required this.title,
        required this.subtitle,
      });

      @override
      Widget build(BuildContext context) {
        return Column(
          children: [
            Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: AppSpacing.sm),
            Text(subtitle, style: TextStyle(color: Colors.grey)),
          ],
        );
      }
    }
    ```

  * **`login_form.dart`**: Formulir khusus login.

    ```dart
    class LoginForm extends StatelessWidget {
      const LoginForm({super.key});

      @override
      Widget build(BuildContext context) {
        return Column(
          children: [
            const AppTextField(hint: 'Email'),
            const SizedBox(height: AppSpacing.md),
            const AppTextField(hint: 'Password', isPassword: true),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Masuk',
              onPressed: () {
                // Logika submit login
              },
            ),
          ],
        );
      }
    }
    ```

  * **`register_form.dart`**: Formulir khusus pendaftaran.

    ```dart
    class RegisterForm extends StatelessWidget {
      const RegisterForm({super.key});

      @override
      Widget build(BuildContext context) {
        return Column(
          children: [
            const AppTextField(hint: 'Nama Lengkap'),
            const SizedBox(height: AppSpacing.md),
            const AppTextField(hint: 'Email'),
            const SizedBox(height: AppSpacing.md),
            const AppTextField(hint: 'Password', isPassword: true),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Daftar Sekarang',
              onPressed: () {
                // Logika submit registrasi
              },
            ),
          ],
        );
      }
    }
    ```

### B. Domain Home (`lib/screens/home/`)

* **`home_screen.dart`**: Tampilan beranda setelah login berhasil.