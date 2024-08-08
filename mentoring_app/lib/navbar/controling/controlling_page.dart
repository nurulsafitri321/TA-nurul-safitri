import 'package:flutter/material.dart';
import 'package:mentoring_app/components/text_widget.dart';
import 'package:mentoring_app/models/user_provider.dart';
import 'package:mentoring_app/navbar/controling/widget/Amal_Yaumi_screen.dart';
import 'package:mentoring_app/navbar/controling/widget/evaluasi_screen.dart';
import 'package:mentoring_app/navbar/controling/widget/hafalan_screen.dart';
import 'package:mentoring_app/navbar/controling/widget/materi_screen.dart';
import 'package:mentoring_app/navbar/controling/widget/presesnsi_screen.dart';
import 'package:mentoring_app/navbar/controling/widget/ujian_mentoring.dart';
import 'package:mentoring_app/pages/widgets/DashedLInedPainter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

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

  void _showNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Semoga Allah mudahkan jalan mu di setiap langkah!"),
        backgroundColor: Colors.green, // Mengubah warna latar belakang notifikasi
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengelolaan Mentoring"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Color.fromARGB(255, 51, 148, 91),
              shadowColor: Colors.grey,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Hallo ${user?.name ?? 'Mentor'}! Ayo lanjutkan progres kelompok mentoringnya :)",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomRight, // Mengatur posisi tombol
                      child: ElevatedButton(
                        onPressed: () {
                          _showNotification();
                        },
                        child: Text("OK"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 51, 148, 91), backgroundColor: Colors.white, // Mengubah warna teks tombol
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _groupNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green), // Mengubah warna garis tepi
                ),
                labelText: "Silahkan isi nama kelompok mentoring",
                hintText: "25 | ummu Darda",
                filled: false,
                //fillColor: Colors.white, // Mengubah warna latar belakang field
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
            Align(
              alignment: Alignment.centerRight, // Mengatur posisi tombol Save
              child: ElevatedButton(
                onPressed: _saveData,
                child: Text("Simpan"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 51, 148, 91), // Mengubah warna teks tombol
                ),
              ),
            ),
            if (_savedGroupName != null && _savedGender != null) ...[
              SizedBox(height: 20),
              Text(
                "Data Kelompok:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text("Nama Kelompok: $_savedGroupName"),
              Text("Gender: $_savedGender"),
            ],
             SizedBox(height: 10),
            CustomPaint(
              size: Size(double.infinity, 1),
              painter: DashedLinePainter(),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 30, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: "Progres Aktivitas Mentoring", 
                    fontSize: 20, 
                    color: Color.fromARGB(255, 51, 148, 91),
                  ),
                ],
              ),
            ),
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
                _buildButton(context, "6. Evaluasi Mentoring", EvaluasiScreen()),
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
              color: const Color.fromARGB(255, 51, 148, 91),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
