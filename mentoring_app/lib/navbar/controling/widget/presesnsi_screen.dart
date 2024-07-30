import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PresensiScreen extends StatefulWidget {
  @override
  _PresensiScreenState createState() => _PresensiScreenState();
}

class _PresensiScreenState extends State<PresensiScreen> {
  List<String?> _selectedPercentages = List.filled(10, 'Belum diisi'); // Nilai default
  List<String> _percentages = [
    'Belum diisi',
    'Hadir',
    'Izin',
    'Sakit',
    'Tidak hadir/tidak konfirmasi',
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedPercentages();
  }

  Future<void> _loadSelectedPercentages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < 10; i++) {
        _selectedPercentages[i] = prefs.getString('presence_$i') ?? 'Belum diisi';
      }
    });
  }

  Future<void> _saveSelectedPercentage(int index, String? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('presence_$index', value ?? 'Belum diisi');
  }

  void _onDropdownChanged(String? newValue, int index) {
    if (newValue != null) {
      setState(() {
        _selectedPercentages[index] = newValue;
      });
      _saveSelectedPercentage(index, newValue);
    }
  }

  void _resetSelection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedPercentages = List.filled(10, 'Belum diisi'); // Mengatur kembali ke nilai default
    });
    for (int i = 0; i < 10; i++) {
      await prefs.setString('presence_$i', 'Belum diisi');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Presensi Kehadiran',
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
          itemCount: 10, // Ubah menjadi 10
          itemBuilder: (context, index) {
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pekan ${index + 1}',
                    style: TextStyle(color: Colors.green), // Warna hijau pada tulisan
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.green), // Warna putih untuk DropdownButton
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedPercentages[index],
                      onChanged: (newValue) {
                        _onDropdownChanged(newValue, index);
                      },
                      items: _percentages.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: _getColorForPercentage(value), // Memberikan warna sesuai persen
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _resetSelection,
        label: Text('Reset'),
        icon: Icon(
          Icons.refresh,
          color: Colors.green, // Warna hijau pada ikon reset
        ),
        backgroundColor: Colors.white, // Warna putih pada bottom
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Color _getColorForPercentage(String percentage) {
    switch (percentage) {
      case 'Hadir':
        return Colors.green;
      case 'Izin':
        return Colors.blue;
      case 'Sakit':
        return Colors.orange;
      case 'Tidak hadir/tidak konfirmasi':
        return Colors.red;
      case 'Belum diisi':
        return Colors.black;
      default:
        return Colors.black;
    }
  }
}
