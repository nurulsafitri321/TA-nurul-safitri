import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mentoring_app/models/mente_model.dart';

class MenteeService {
  final String baseUrl = 'http://10.0.2.2:8000/api'; // Sesuaikan baseUrl

  Future<List<Mentee>> getMentees() async {
    final response = await http.get(Uri.parse('$baseUrl/mentees'), headers: {
      "Authorization": "Bearer Z8HQCRReadwzaeZvnIF0Tgzj6Pjfu2CyxezTOadzLwNJ8URb2mVaqzfte9qNg360y",
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map<Mentee>((mentee) => Mentee.fromJson(mentee)).toList();
    } else {
      throw Exception('Failed to load mentees');
    }
  }

  Future<Mentee> createMentee(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/mentees'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer Z8HQCRReadwzaeZvnIF0Tgzj6Pjfu2CyxezTOadzLwNJ8URb2mVaqzfte9qNg360y",
        "Accept": "application/json",
      },
      body: jsonEncode(data),
    );

    // Tambahkan kode ini untuk melihat respons dari API
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Mentee.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create mentee');
    }
  }

  Future<void> updateMentee(Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/mentees/${data['nim']}'), // Sesuaikan URL dengan baseUrl dan data
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer Z8HQCRReadwzaeZvnIF0Tgzj6Pjfu2CyxezTOadzLwNJ8URb2mVaqzfte9qNg360y",
        "Accept": "application/json",
      },
      body: jsonEncode(data),
    );

    // Tambahkan kode ini untuk melihat respons dari API
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to update mentee');
    }
  }

  Future<void> deleteMentee(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/mentees/$id'),  // Sesuaikan URL dengan baseUrl
      headers: {
        "Authorization": "Bearer Z8HQCRReadwzaeZvnIF0Tgzj6Pjfu2CyxezTOadzLwNJ8URb2mVaqzfte9qNg360y",
        "Accept": "application/json",
      },
    );

    // Tambahkan kode ini untuk melihat respons dari API
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 204) {
      throw Exception('Failed to delete mentee');
    }
  }
}
