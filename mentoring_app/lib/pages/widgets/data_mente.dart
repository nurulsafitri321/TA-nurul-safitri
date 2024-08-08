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
        title: Text("Data Mentee",style: TextStyle(color: Colors.white)),
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
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(snapshot.data![index].nama),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("NIM: ${snapshot.data![index].nim}"),
                            Text("Kelas: ${snapshot.data![index].kelas}"),
                            Text("Jurusan: ${snapshot.data![index].jurusan}"),
                            Text("Prodi: ${snapshot.data![index].prodi}"),
                            Text("Jenis Kelamin: ${snapshot.data![index].jenisKelamin}"),
                            Text("Status Mentoring: ${snapshot.data![index].statusMentoring}"),
                            Text("Kehadiran: ${snapshot.data![index].kehadiran}"),
                            Text("Amalan: ${snapshot.data![index].amalan}"),
                            Text("Keaktifan: ${snapshot.data![index].keaktifan}"),
                            Text("Pengetahuan: ${snapshot.data![index].pengetahuan}"),
                            Text("Nilai Akhir: ${snapshot.data![index].nilaiAkhir}"),
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
