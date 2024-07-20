// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   Future<void> login() async {
//     final response = await http.post(
//       Uri.parse('http://your-server/login.php'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'email': _emailController.text,
//         'password': _passwordController.text,
//       }),
//     );

//     final data = jsonDecode(response.body);
//     if (data['status'] == 'success') {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.setString('user', jsonEncode(data['user']));
//       // Navigate to home page or show success message
//     } else {
//       // Show error message
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             ElevatedButton(
//               onPressed: login,
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
