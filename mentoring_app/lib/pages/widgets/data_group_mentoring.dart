import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mentoring_app/models/groupmentoring_model.dart';


class DataGroupMentorPage extends StatefulWidget {
  @override
  _DataGroupMentorPageState createState() => _DataGroupMentorPageState();
}

class _DataGroupMentorPageState extends State<DataGroupMentorPage> {
  final _formKey = GlobalKey<FormState>();
  late Future<List<GroupMentoring>> futureGroups;
  late String namaKelompok, namaMentor, noHpMentor, namaMente, jurusanMente;

  @override
  void initState() {
    super.initState();
    futureGroups = fetchGroups();
  }

  Future<List<GroupMentoring>> fetchGroups() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/groupmentorings'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((group) => GroupMentoring.fromJson(group)).toList();
    } else {
      throw Exception('Failed to load group mentorings');
    }
  }

  Future<GroupMentoring> createGroupMentoring(GroupMentoring group) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/groupmentorings'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(group.toJson()),
    );

    if (response.statusCode == 201) {
      return GroupMentoring.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create group mentoring');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Group Mentoring",style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 51, 148, 91),
      ),
      body: Center(
        child: FutureBuilder<List<GroupMentoring>>(
          future: futureGroups,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text("No groups found.");
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          margin: EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(snapshot.data![index].namaKelompok),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Nama Mentor: ${snapshot.data![index].namaMentor}"),
                                  Text("No HP Mentor: ${snapshot.data![index].noHpMentor}"),
                                  Text("Nama Mente: ${snapshot.data![index].namaMente}"),
                                  Text("Jurusan Mente: ${snapshot.data![index].jurusanMente}"),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
