import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _email;

  bool get isLoggedIn => _isLoggedIn;
  String? get email => _email;

  Future<void> login(String email, String password) async {
    // TODO: ganti dengan API call
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email dan password wajib diisi');
    }
    _isLoggedIn = true;
    _email = email;
    notifyListeners();
  }

  Future<void> register(String name, String email, String password) async {
    // TODO: ganti dengan API call
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Data belum lengkap');
    }
    _isLoggedIn = true;
    _email = email;
    notifyListeners();
  }

  Future<void> signOut() async {
    _isLoggedIn = false;
    _email = null;
    notifyListeners();
  }
}