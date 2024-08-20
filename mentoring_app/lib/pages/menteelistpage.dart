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
  List<Mentee> mentees = [];

  @override
  void initState() {
    super.initState();
    _fetchMentees();
  }

  Future<void> _fetchMentees() async {
    try {
      List<Mentee> fetchedMentees = await _menteeService.getMentees();
      setState(() {
        mentees = fetchedMentees;
      });
    } catch (e) {
      print('Failed to load mentees: $e');
    }
  }

  void _addMentee(Mentee mentee) {
    setState(() {
      mentees.add(mentee);
    });
  }

  void _editMentee(String nim, Mentee updatedMentee) {
    setState(() {
      int index = mentees.indexWhere((mentee) => mentee.nim == nim);
      if (index != -1) {
        mentees[index] = updatedMentee;
      }
    });
  }

  void _deleteMentee(String nim) async {
    try {
      await _menteeService.deleteMentee(nim);
      setState(() {
        mentees.removeWhere((mentee) => mentee.nim == nim);
      });
    } catch (e) {
      print('Failed to delete mentee: $e');
    }
  }

  void _openMenteeForm([Mentee? mentee]) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MenteeFormPage(
        mentee: mentee,
        idMentor: mentee?.idMentor ?? 0, // Ubah dari '' menjadi nilai idMentor atau default 0
      ),
    ),
  );

  if (result != null && result is Mentee) {
    if (mentee == null) {
      _addMentee(result);
    } else {
      _editMentee(mentee.nim, result);
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false, // Menghilangkan icon back
      backgroundColor: Color.fromARGB(255, 232, 243, 232), // Memberikan background hijau tipis
      title: Text(
        'Daftar Mentee',
        style: TextStyle(
          fontWeight: FontWeight.bold, // Membuat teks menjadi bold
          color: const Color.fromARGB(255, 51, 148, 91), // Mengubah warna teks menjadi hijau
        ),
      ),
    ),

      body: ListView.builder(
        itemCount: mentees.length,
        itemBuilder: (context, index) {
          Mentee mentee = mentees[index];
          return ListTile(
            title: Text(mentee.nama),
            subtitle: Text('NIM: ${mentee.nim}, Kelas: ${mentee.kelas}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _openMenteeForm(mentee),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteMentee(mentee.nim),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openMenteeForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}
