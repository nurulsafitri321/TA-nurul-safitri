// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HomePage extends StatelessWidget {
//   Future<void> logout(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.remove('user');
//     // Navigate to login page or show success message
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Home')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => logout(context),
//           child: Text('Logout'),
//         ),
//       ),
//     );
//   }
// }
