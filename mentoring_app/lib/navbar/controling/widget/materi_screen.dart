import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MateriScreen extends StatefulWidget {
  @override
  _MateriScreenState createState() => _MateriScreenState();
}

class _MateriScreenState extends State<MateriScreen> {
  List<String> _tasks = [
    'Adab Menuntut Ilmu',
    'Ma\'rifatullah',
    'Ma\'rifatul Rasul',
    'Ma\'rifatul Islam',
    'Ma\'rifatul Insan',
    'Ghazwul Fikri',
    'Ukhuwah Islamiyah',
    'Peranan Penting Islam',
    'Peranan Pemuda',
  ];

  List<String> _taskStatus = List.filled(9, 'Not Yet'); // Sesuaikan jumlahnya dengan jumlah _tasks

  @override
  void initState() {
    super.initState();
    _loadTaskStatus();
  }

  Future<void> _loadTaskStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < _tasks.length; i++) {
        _taskStatus[i] = prefs.getString('task_status_$i') ?? 'Not Yet';
      }
    });
  }

  Future<void> _saveTaskStatus(int index, String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('task_status_$index', status);
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
      _taskStatus = List.filled(9, 'Not Yet'); // Reset status semua task
    });
    for (int i = 0; i < _tasks.length; i++) {
      await prefs.setString('task_status_$i', 'Not Yet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Materi',
          style: TextStyle(color: Colors.white), // Ubah warna teks menjadi putih
        ),
        backgroundColor: Color.fromARGB(255, 51, 148, 91),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 255, 255, 255), // Warna hijau soft pada body
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
                      'Progres',
                      'Start',
                      'Not Yet'
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
                style: TextStyle(color: Colors.green),
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
      case 'Progres':
        return Colors.pink;
      case 'Start':
        return Colors.orange;
      case 'Not Yet':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
