import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mentoring_app/models/pdf_model.dart';

Future<List<Pdf>> fetchPdfs() async {
  // Replace 'http://your-api-url/api/pdfs' with the actual URL of your API endpoint
  final uri = Uri.parse('http://10.0.2.2:8000/api/pdfs'); // Assuming your server is at 10.0.2.2 and port 8000

  try {
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // Decode response body as a list of JSON objects
      final decodedData = jsonDecode(response.body) as List;
      // Return a list of Pdf objects by mapping each JSON object to a Pdf model
      return decodedData.map((data) => Pdf.fromJson(data)).toList();
    } else {
      // Handle error by throwing an exception with a descriptive message
      throw Exception('Failed to load PDFs. Status code: ${response.statusCode}');
    }
  } on SocketException catch (e) {
    // Handle socket exception (network issues)
    throw Exception('Failed to connect to server. Check your internet connection. ($e)');
  } catch (e) {
    // Handle other exceptions
    throw Exception('An unexpected error occurred: $e');
  }
}