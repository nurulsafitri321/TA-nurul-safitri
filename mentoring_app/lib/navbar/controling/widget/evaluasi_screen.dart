import 'package:flutter/material.dart';
import 'package:mentoring_app/models/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EvaluasiScreen extends StatefulWidget {
  const EvaluasiScreen({super.key});

  @override
  State<EvaluasiScreen> createState() => _EvaluasiScreenState();
}

class _EvaluasiScreenState extends State<EvaluasiScreen> {
  final _formKey = GlobalKey<FormState>();
  final _evaluasiController = TextEditingController();
  bool _isSubmitting = false;
  String? _reply; // Variable to store the server's reply

  // Fungsi untuk mengirim evaluasi
  Future<void> _submitEvaluasi() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Ambil data pengguna dari UserProvider
    final user = Provider.of<UserProvider>(context, listen: false).user;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User tidak ditemukan')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
      _reply = null; // Reset the reply before new submission
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/evaluasi'), // Pastikan URL endpoint benar
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_id': user.id, // Menggunakan ID pengguna dari UserProvider
          'evaluasi': _evaluasiController.text,
          'status': 'belum',
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Evaluasi berhasil disimpan')),
        );
        _evaluasiController.clear();

        // Setelah submit, ambil data evaluasi terbaru termasuk balasan jika ada
        await _fetchEvaluasi(user.id);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan evaluasi: ${response.body}')),
        );
      }
    } catch (error) {
      print(error); // Cetak error di konsol
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $error')),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  // Fungsi untuk mengambil evaluasi terbaru termasuk balasan
  Future<void> _fetchEvaluasi(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/evaluasi'), // Pastikan URL endpoint benar
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Cari evaluasi yang baru saja dikirim oleh user ini dan perbarui _reply
        setState(() {
          final latestEvaluasi = data.lastWhere((eval) => eval['user_id'] == userId);
          _reply = latestEvaluasi['reply'];  // Update balasan (reply)
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengambil data evaluasi')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Evaluasi',
          style: TextStyle(
            color: Color.fromARGB(255, 51, 148, 91),
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 51, 148, 91)),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              final user = Provider.of<UserProvider>(context, listen: false).user;
              if (user != null) {
                _fetchEvaluasi(user.id);  // Refresh data untuk mengecek apakah ada balasan
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _evaluasiController,
                    decoration: InputDecoration(labelText: 'Evaluasi'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Evaluasi tidak boleh kosong';
                      }
                      return null;
                    },
                    maxLines: 4,
                  ),
                  const SizedBox(height: 20),
                  _isSubmitting
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _submitEvaluasi,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 51, 148, 91),
                          ),
                          child: Text('Kumpulkan'),
                        ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (_reply != null && _reply!.isNotEmpty)
              if (_reply != null && _reply!.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Tambahkan padding agar lebih rapi
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align ke kiri
                  children: [
                    Text(
                      'Balasan dari Admin :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0), // Tambahkan jarak antara judul dan subtitle
                    Text(
                      _reply!,
                      style: TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
