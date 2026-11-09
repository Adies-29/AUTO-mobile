import 'package:flutter/material.dart';
import 'package:auto/core/theme/colors.dart';
import 'package:auto/features/diagnostic/screens/models/dtc_model.dart'; 

class TanyaAiScreen extends StatefulWidget {
  final DtcModel? dtcContext; // Jika null, berarti mode umum (dari Settings)

  const TanyaAiScreen({super.key, this.dtcContext});

  @override
  State<TanyaAiScreen> createState() => _TanyaAiScreenState();
}

class _TanyaAiScreenState extends State<TanyaAiScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() {
    if (widget.dtcContext != null) {
      // Mode DTC (Dipanggil dari halaman Error/Diagnostic)
      _messages.add({
        'isUser': false,
        'text': 'Halo! Saya melihat Anda ingin bertanya tentang kode **${widget.dtcContext!.code}** (${widget.dtcContext!.title}).\n\n'
            'Berdasarkan sistem OBD-II, kode ini menandakan: *${widget.dtcContext!.description}*.\n\n'
            'Apa yang ingin Anda ketahui lebih lanjut tentang kerusakan ini? (Misal: penyebabnya, atau cara memperbaikinya)',
      });
    } else {
      // Mode Umum (Dipanggil dari Settings)
      _messages.add({
        'isUser': false,
        'text': 'Halo! Saya AUTO AI, asisten pintar Anda. Ada yang bisa saya bantu terkait mobil atau kendala OBD-II Anda hari ini?',
      });
    }
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      // Tambahkan pesan user
      _messages.add({'isUser': true, 'text': text});
      _controller.clear();
    });

    _scrollToBottom();

    // Simulasi AI sedang mengetik dan membalas (Delay 1.5 detik)
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'isUser': false,
            'text': _generateAiResponse(text),
          });
        });
        _scrollToBottom();
      }
    });
  }

  // Simulasi balasan AI (Karena belum menggunakan API OpenAI/Gemini)
  String _generateAiResponse(String userQuery) {
    final query = userQuery.toLowerCase();
    
    // Jika mode DTC
    if (widget.dtcContext != null) {
      if (query.contains('penyebab') || query.contains('kenapa')) {
        final causes = widget.dtcContext!.possibleCauses?.join('\n- ') ?? 'Tidak diketahui';
        return 'Berdasarkan data diagnostik, penyebab umum dari kode ${widget.dtcContext!.code} adalah:\n- $causes';
      } else if (query.contains('solusi') || query.contains('perbaiki') || query.contains('mengatasi')) {
        final actions = widget.dtcContext!.suggestedActions?.join('\n- ') ?? 'Segera bawa ke bengkel terdekat.';
        return 'Berikut adalah tindakan yang disarankan:\n- $actions';
      }
    }

    // Jawaban Default (Mode Umum atau pertanyaan tak dikenal)
    return 'Pertanyaan yang bagus! Sayangnya saya masih dalam tahap pengembangan dan belum bisa menganalisis pertanyaan spesifik tersebut secara langsung. Namun, Anda bisa memeriksa bagian "Diagnostic" untuk melihat kode error (DTC) yang terdeteksi pada mobil Anda.';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC), // Background abu-abu sangat terang
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppColors.blueAccent,
              child: Icon(Icons.smart_toy, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AUTO AI',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Manrope',
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green[600],
                    fontFamily: 'Manrope',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // ─────────────────────────────────────────────────────────────
          // Area Chat (Pesan)
          // ─────────────────────────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['isUser'] as bool;
                return _buildChatBubble(msg['text'], isUser);
              },
            ),
          ),

          // ─────────────────────────────────────────────────────────────
          // Area Input Chat
          // ─────────────────────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: _sendMessage,
                      decoration: InputDecoration(
                        hintText: 'Tanyakan sesuatu...',
                        hintStyle: const TextStyle(fontFamily: 'Manrope', fontSize: 14),
                        filled: true,
                        fillColor: const Color(0xFFF2F2F7),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => _sendMessage(_controller.text),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: AppColors.blueAccent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk Bubble Chat
  Widget _buildChatBubble(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isUser ? AppColors.blueAccent : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
            bottomRight: isUser ? Radius.zero : const Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14,
            height: 1.4,
            color: isUser ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}