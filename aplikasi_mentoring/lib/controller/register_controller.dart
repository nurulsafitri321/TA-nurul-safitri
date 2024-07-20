// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class RegisterPage extends StatefulWidget {
//   @override
//   _RegisterPageState createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final _usernameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   Future<void> register() async {
//     final response = await http.post(
//       Uri.parse('http://your-server/register.php'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'username': _usernameController.text,
//         'email': _emailController.text,
//         'password': _passwordController.text,
//       }),
//     );

//     final data = jsonDecode(response.body);
//     if (data['status'] == 'success') {
//       // Navigate to login page or show success message
//     } else {
//       // Show error message
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Register')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _usernameController,
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
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
//               onPressed: register,
//               child: Text('Register'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
