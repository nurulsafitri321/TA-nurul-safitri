import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mentoring_app/models/mente_model.dart';


class MenteeService {
  final String baseUrl = 'http://10.0.2.2:8000/api'; // Sesuaikan baseUrl

  Future<List<Mentee>> getMentees() async {
    final response = await http.get(Uri.parse('$baseUrl/mentees'), headers: {
      "Authorization": "Bearer <YOUR_TOKEN_HERE>",
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
        "Authorization": "Bearer <YOUR_TOKEN_HERE>",
        "Accept": "application/json",
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Mentee.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create mentee');
    }
  }

  Future<void> updateMentee(String nim, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/mentees/$nim'),  // Gunakan nim untuk melakukan update
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer <YOUR_TOKEN_HERE>",
        "Accept": "application/json",
      },
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      print('Error response: ${response.body}');
      throw Exception('Failed to update mentee');
    }
  }

  Future<void> deleteMentee(String nim) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/mentees/$nim'),  // Gunakan nim untuk melakukan delete
      headers: {
        "Authorization": "Bearer <YOUR_TOKEN_HERE>",
        "Accept": "application/json",
      },
    );

    if (response.statusCode != 204 && response.statusCode != 200) {
      print('Error response: ${response.body}');
      throw Exception('Failed to delete mentee');
    }
  }
}
