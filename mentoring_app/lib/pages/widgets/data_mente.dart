import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mentoring_app/models/mente_model.dart';

class DataMenteePage extends StatefulWidget {
  @override
  _DataMenteePageState createState() => _DataMenteePageState();
}

class _DataMenteePageState extends State<DataMenteePage> {
  late Future<List<Mentee>> futureMentees;

  @override
  void initState() {
    super.initState();
    futureMentees = fetchMentees();
  }

  Future<List<Mentee>> fetchMentees() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/mentees'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((mentee) => Mentee.fromJson(mentee)).toList();
    } else {
      throw Exception('Failed to load mentees');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Mentee", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 51, 148, 91),
      ),
      body: Center(
        child: FutureBuilder<List<Mentee>>(
          future: futureMentees,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text("No mentees found.");
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final mentee = snapshot.data![index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(mentee.nama),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("NIM: ${mentee.nim}"),
                            Text("Kelas: ${mentee.kelas}"),
                            Text("Jurusan: ${mentee.jurusan}"),
                            Text("Prodi: ${mentee.prodi}"),
                            Text("Jenis Kelamin: ${mentee.jenisKelamin}"),
                            Text("Status Mentoring: ${mentee.statusMentoring.toString().split('.').last}"),
                            Text("Kehadiran: ${mentee.kehadiran.toString()}%"),
                            Text("Amalan: ${mentee.amalan.toString()}%"),
                            Text("Keaktifan: ${mentee.keaktifan.toString()}%"),
                            Text("Pengetahuan: ${mentee.pengetahuan.toString()}%"),
                            Text("Nilai Akhir: ${mentee.nilaiAkhir.toString()}%"),
                            Text("Ujian Praktek: ${mentee.ujianPraktek.toString().split('.').last}"),
                            Text("Ujian Tulis: ${mentee.ujianTulis ? 'Ya' : 'Tidak'}"),
                            // Menggunakan loop untuk menampilkan pertemuan
                            for (int i = 0; i < mentee.pertemuan.length; i++)
                              Text("Pertemuan ${i + 1}: ${mentee.pertemuan[i] ? 'Hadir' : 'Tidak Hadir'}"),
                            Text("Catatan: ${mentee.catatan ?? 'Tidak ada catatan'}"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
