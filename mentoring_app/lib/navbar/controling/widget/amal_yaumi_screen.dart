import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AmalYaumiScreen extends StatefulWidget {
  @override
  _AmalYaumiScreenState createState() => _AmalYaumiScreenState();
}

class _AmalYaumiScreenState extends State<AmalYaumiScreen> {
  List<String?> _selectedPercentages = List.filled(4, '0%'); // Nilai default

  List<String> _percentages = [
    '0%',
    '10%',
    '20%',
    '30%',
    '40%',
    '50%',
    '60%',
    '70%',
    '80%',
    '90%',
    '100%',
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedPercentages();
  }

  Future<void> _loadSelectedPercentages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < 4; i++) {
        _selectedPercentages[i] = prefs.getString('amal_yaumi_$i') ?? '0%';
      }
    });
  }

  Future<void> _saveSelectedPercentage(int index, String? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('amal_yaumi_$index', value ?? '0%');
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
      _selectedPercentages = List.filled(4, '0%'); // Mengatur kembali ke nilai default
    });
    for (int i = 0; i < 4; i++) {
      await prefs.setString('amal_yaumi_$i', '0%');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Amal Yaumi',
          style: TextStyle(color: Colors.white), 
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
          itemCount: 4, // 
          itemBuilder: (context, index) {
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bulan ${index + 1}',
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
      floatingActionButton: FloatingActionButton(
        onPressed: _resetSelection,
        child: Icon(
          Icons.refresh,
          color: Colors.green, // Warna hijau pada ikon reset
        ),
        backgroundColor: Colors.white, // Warna hijau pada bottom
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Color _getColorForPercentage(String percentage) {
    switch (percentage) {
      case '0%':
        return Colors.red;
      case '10%':
        return Colors.orange;
      case '20%':
        return Colors.yellow;
      case '30%':
        return Colors.amber;
      case '40%':
        return Colors.lime;
      case '50%':
        return Colors.green;
      case '60%':
        return Colors.teal;
      case '70%':
        return Colors.cyan;
      case '80%':
        return Colors.blue;
      case '90%':
        return Colors.indigo;
      case '100%':
        return Colors.purple;
      default:
        return Colors.black;
    }
  }
}
