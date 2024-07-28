import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CallApi {
  final String _url = 'http://10.0.2.2:8000/api/';
  final String _imgUrl = 'http://10.0.2.2:8000/uploads/';

  getImage() {
    return _imgUrl;
  }

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: _setHeaders()
    );
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    return await http.get(
      Uri.parse(fullUrl),
      headers: _setHeaders()
    );
  }

  getPublicData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    try {
      final response = await http.get(
        Uri.parse(fullUrl),
        headers: _setHeaders()
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        print('Failed to load data');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  

  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }

  // getArticles(apiUrl) async {

  // }
  // getPublicData(apiUrl) async {

  // }
}
