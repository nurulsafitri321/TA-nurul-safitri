import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mentoring_app/models/mentor_model.dart';

class DataMentorPage extends StatefulWidget {
  @override
  _DataMentorPageState createState() => _DataMentorPageState();
}

class _DataMentorPageState extends State<DataMentorPage> {
  late Future<List<Mentor>> futureMentors;

  @override
  void initState() {
    super.initState();
    futureMentors = fetchMentors();
  }

  Future<List<Mentor>> fetchMentors() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/mentor'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((mentor) => Mentor.fromJson(mentor)).toList();
    } else {
      throw Exception('Failed to load mentors');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
      title: Text(
        "Data Group Mentor",style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(255, 51, 148, 91),
      iconTheme: IconThemeData(
        color: Colors.white, // Ubah warna ikon kembali menjadi putih
      ),
    ),

      body: Center(
        child: FutureBuilder<List<Mentor>>(
          future: futureMentors,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text("No mentors found.");
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data![index].nama),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("NIM: ${snapshot.data![index].nim}"),
                          Text("Jurusan: ${snapshot.data![index].jurusan}"),
                          Text("Prodi: ${snapshot.data![index].prodi}"),
                          Text("Jenis Kelamin: ${snapshot.data![index].jenisKelamin}"),
                          Text("No Telepon: ${snapshot.data![index].noTelepon}"),
                          Text("Divisi: ${snapshot.data![index].divisi}"),
                          Text("Alamat: ${snapshot.data![index].alamat}"),
                        ],
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
