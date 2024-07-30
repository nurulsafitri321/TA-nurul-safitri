import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HafalanScreen extends StatefulWidget {
  @override
  _HafalanScreenState createState() => _HafalanScreenState();
}

class _HafalanScreenState extends State<HafalanScreen> {
  List<String> _tasks = [
    'Surat Ad-Dhuha',
    'Surat Al-Insyirah',
    'Surat At-Tin',
    'Surat Al-Alaq',
    'Surat Al-Bayyinah',
    'Surat Al-Zalzalah',
    'Surat Al-Adiyat',
    'Surat Al-Qariah',
    'Surat At-Takasur',
    'Surat Al-Asr',
    'Surat Al-Humazah',
    'Surat Al-Fil',
    'Surat Quraisy',
    'Surat Al-Maun',
    'Surat Al-Kautsar',
    'Surat Al-Kafirun',
    'Surat An-Nasr',
    'Surat Al-Lahab',
    'Surat Al-Ikhlas',
    'Surat Al-Falaq',
    'Surat An-Nas',
  ];

  List<String> _taskStatus = List.filled(21, 'Not Yet'); // Sesuaikan jumlahnya dengan jumlah _tasks

  @override
  void initState() {
    super.initState();
    _loadTaskStatus();
  }

  Future<void> _loadTaskStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < _tasks.length; i++) {
        _taskStatus[i] = prefs.getString('hafalan_task_status_$i') ?? 'Not Yet';
      }
    });
  }

  Future<void> _saveTaskStatus(int index, String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('hafalan_task_status_$index', status);
  }

  void _updateTaskStatus(int index, String status) {
    setState(() {
      _taskStatus[index] = status;
    });
    _saveTaskStatus(index, status);
  }

  void _resetTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _taskStatus = List.filled(_tasks.length, 'Not Yet'); // Reset status semua task
    });
    for (int i = 0; i < _tasks.length; i++) {
      await prefs.setString('hafalan_task_status_$i', 'Not Yet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hafalan',
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
        child: ListView.builder(
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: ListTile(
                title: Text(_tasks[index]),
                trailing: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green), // Tambah border hijau
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: DropdownButton<String>(
                    value: _taskStatus[index],
                    onChanged: (value) {
                      _updateTaskStatus(index, value!);
                    },
                    items: <String>[
                      'Finish',
                      'Not Yet',
                      'Start',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: _getColorForStatus(value),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _resetTasks,
              child: Text(
                'Reset',
                style: TextStyle(color: Color.fromARGB(255, 128, 167, 131)),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForStatus(String status) {
    switch (status) {
      case 'Finish':
        return Colors.green;
      case 'Not Yet':
        return Colors.red;
      case 'Start':
        return Colors.orange;
      default:
        return Colors.black;
    }
  }
}
