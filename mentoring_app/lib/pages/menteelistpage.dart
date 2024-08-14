import 'package:flutter/material.dart';
import 'package:mentoring_app/models/mente_model.dart';
import 'package:mentoring_app/pages/menteeformpage.dart';
import 'package:mentoring_app/service/mente_service.dart';


class MenteeListPage extends StatefulWidget {
  @override
  _MenteeListPageState createState() => _MenteeListPageState();
}

class _MenteeListPageState extends State<MenteeListPage> {
  final MenteeService _menteeService = MenteeService();
  List<Mentee> _mentees = [];

  @override
  void initState() {
    super.initState();
    _fetchMentees();
  }

  Future<void> _fetchMentees() async {
    final mentees = await _menteeService.getMentees();
    setState(() {
      _mentees = mentees;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Mentee'),
        backgroundColor: const Color.fromARGB(255, 51, 148, 91),
      ),
      body: _mentees.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _mentees.length,
              itemBuilder: (context, index) {
                final mentee = _mentees[index];
                return ListTile(
                  title: Text(mentee.nama),
                  subtitle: Text(mentee.nim),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MenteeFormPage(mentee: mentee),
                      ),
                    ).then((_) => _fetchMentees());
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MenteeFormPage()),
          );
          if (result != null) {
            _fetchMentees(); // Refresh daftar mentee setelah menambah atau mengedit mentee
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
