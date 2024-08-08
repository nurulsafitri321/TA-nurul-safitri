import 'package:flutter/material.dart';
import 'package:mentoring_app/models/activity_calender.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';


class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Activity> _activities = [];

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? activitiesJson = prefs.getString('activities');
    if (activitiesJson != null) {
      Iterable list = json.decode(activitiesJson);
      setState(() {
        _activities = list.map((model) => Activity.fromJson(model)).toList();
      });
    }
  }

  Future<void> _saveActivities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String activitiesJson = json.encode(_activities.map((e) => e.toJson()).toList());
    prefs.setString('activities', activitiesJson);
  }

  List<Activity> _getActivitiesForDay(DateTime day) {
    return _activities.where((activity) => isSameDay(activity.date, day)).toList();
  }

  void _addActivity(Activity activity) {
    setState(() {
      _activities.add(activity);
    });
    _saveActivities();
  }

  void _deleteActivity(Activity activity) {
    setState(() {
      _activities.remove(activity);
    });
    _saveActivities();
  }

  Future<void> _showAddActivityDialog() async {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Aktivitas'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Judul',
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Deskripsi',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Tambah'),
              onPressed: () {
                _addActivity(Activity(
                  title: titleController.text,
                  description: descriptionController.text,
                  date: _selectedDay ?? _focusedDay,
                ));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2000, 1, 1),
          lastDay: DateTime.utc(2100, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay; // update `_focusedDay` here as well
            });
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _showAddActivityDialog,
          child: Text(
            'Tambah Aktivitas',
            style: TextStyle(color: Color.fromARGB(255, 51, 148, 91)), // Mengubah warna tulisan menjadi hijau
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 7, // Mengubah warna latar belakang tombol jika diperlukan
          ),
        ),

        SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: _getActivitiesForDay(_selectedDay ?? _focusedDay).length,
            itemBuilder: (context, index) {
              Activity activity = _getActivitiesForDay(_selectedDay ?? _focusedDay)[index];
              return ListTile(
                title: Text(activity.title),
                subtitle: Text(activity.description),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteActivity(activity);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
