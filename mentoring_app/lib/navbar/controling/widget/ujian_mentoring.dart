import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UjianMentoring extends StatefulWidget {
  @override
  _UjianMentoringState createState() => _UjianMentoringState();
}

class _UjianMentoringState extends State<UjianMentoring> {
  bool _isWudhuCompleted = false;
  bool _isSholatWajibCompleted = false;
  bool _isUjianBersamaCompleted = false;
  List<String> _evaluations = [];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isWudhuCompleted = prefs.getBool('isWudhuCompleted') ?? false;
      _isSholatWajibCompleted = prefs.getBool('isSholatWajibCompleted') ?? false;
      _isUjianBersamaCompleted = prefs.getBool('isUjianBersamaCompleted') ?? false;
      _evaluations = prefs.getStringList('evaluations') ?? [];
    });
  }

  Future<void> _savePreference(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> _addEvaluation(String evaluation) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _evaluations.add(evaluation);
    });
    await prefs.setStringList('evaluations', _evaluations);
  }

  Future<void> _resetEvaluations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _evaluations.clear();
    });
    await prefs.setStringList('evaluations', _evaluations);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ujian Mentoring',
          style: TextStyle(color: Colors.white), // Ubah warna teks menjadi putih
        ),
        backgroundColor: Color.fromARGB(255, 128, 167, 131),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Color(0xFFE8F5E9), // Warna hijau soft pada body
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Text(
              'Ujian Praktek',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: _isWudhuCompleted,
                  onChanged: (value) {
                    setState(() {
                      _isWudhuCompleted = value!;
                    });
                    _savePreference('isWudhuCompleted', value!);
                  },
                ),
                Text('Wudhu'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _isSholatWajibCompleted,
                  onChanged: (value) {
                    setState(() {
                      _isSholatWajibCompleted = value!;
                    });
                    _savePreference('isSholatWajibCompleted', value!);
                  },
                ),
                Text('Sholat Wajib/Jenazah'),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Ujian Tulis',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: _isUjianBersamaCompleted,
                  onChanged: (value) {
                    setState(() {
                      _isUjianBersamaCompleted = value!;
                    });
                    _savePreference('isUjianBersamaCompleted', value!);
                  },
                ),
                Text('Ujian Bersama'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Tambah Evaluasi'),
                      content: EvaluationBottomSheet(
                        onSave: (evaluation) {
                          _addEvaluation(evaluation);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                );
              },
              child: Text(
                'Evaluasi',
                style: TextStyle(color: Colors.green),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Background putih
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Evaluasi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ..._evaluations.map((evaluation) => ListTile(
              title: Text(evaluation),
            )),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _resetEvaluations();
                });
              },
              child: Text(
                'Reset Evaluasi',
                style: TextStyle(color: Colors.green),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Background putih
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EvaluationBottomSheet extends StatefulWidget {
  final Function(String) onSave;

  EvaluationBottomSheet({required this.onSave});

  @override
  _EvaluationBottomSheetState createState() => _EvaluationBottomSheetState();
}

class _EvaluationBottomSheetState extends State<EvaluationBottomSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Tambah evaluasi...',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              widget.onSave(_controller.text);
            }
          },
          child: Text('Simpan Evaluasi'),
        ),
      ],
    );
  }
}
