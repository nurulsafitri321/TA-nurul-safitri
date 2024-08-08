import 'package:flutter/material.dart';
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

  Future<void> _submitEvaluasi() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/evaluasi'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'user_id': 1, // Ganti dengan ID user yang sesuai
        'mentor_id': 1, // Ganti dengan ID mentor yang sesuai
        'evaluasi': _evaluasiController.text,
        'status': 'belum',
      }),
    );

    setState(() {
      _isSubmitting = false;
    });

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Evaluasi berhasil disimpan')),
      );
      _evaluasiController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan evaluasi')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Evaluasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
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
                      child: Text('Kumpulkan'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
