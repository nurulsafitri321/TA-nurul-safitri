import 'package:flutter/material.dart';
import 'package:mentoring_app/navbar/controling/widget/Amal_Yaumi_screen.dart';
import 'package:mentoring_app/navbar/controling/widget/hafalan_screen.dart';
import 'package:mentoring_app/navbar/controling/widget/materi_screen.dart';
import 'package:mentoring_app/navbar/controling/widget/presesnsi_screen.dart';
import 'package:mentoring_app/navbar/controling/widget/ujian_mentoring.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key});

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  TextEditingController _groupNameController = TextEditingController();
  String _selectedGender = "akhwat";
  String? _savedGroupName;
  String? _savedGender;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedGroupName = prefs.getString('groupName');
      _savedGender = prefs.getString('gender');
    });
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('groupName', _groupNameController.text);
    await prefs.setString('gender', _selectedGender);
    _loadSavedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Controlling Mentoring"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              shadowColor: Colors.grey,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Halo Mentor Tangguh! Ayo lanjutkan progres kelompok mentoringnya :)",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _groupNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Silahkan isi nama kelompok mentoring",
                hintText: "25 | ummu Darda",
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedGender,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Pilih gender kelompok",
              ),
              items: ["akhwat", "ikhwan"]
                  .map((label) => DropdownMenuItem(
                        child: Text(label),
                        value: label,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveData,
              child: Text("Save Data"),
            ),
            if (_savedGroupName != null && _savedGender != null) ...[
              SizedBox(height: 20),
              Text(
                "Saved Data:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text("Nama Kelompok: $_savedGroupName"),
              Text("Gender: $_savedGender"),
            ],
            SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 5,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildButton(context, "1. Presensi", PresensiScreen()),
                _buildButton(context, "2. Materi", MateriScreen()),
                _buildButton(context, "3. Amal Yaumi", AmalYaumiScreen()),
                _buildButton(context, "4. Hafalan Surah Pendek", HafalanScreen()),
                _buildButton(context, "5. Ujian Mentoring", UjianMentoring()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label, [Widget? page]) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.grey,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: page != null
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              }
            : null,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
