import 'package:flutter/material.dart';
import 'package:mentoring_app/navbar/controling/controlling_page.dart';
import 'package:mentoring_app/pages/article_page.dart';
import 'package:mentoring_app/navbar/profile/profile_page.dart';



class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ArticlePage(),
    ControllerPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    print('Navigating to index: $index'); // Print statement for debugging
    setState(() {
      _selectedIndex = index;
      print('Updated selectedIndex: $_selectedIndex'); // Print statement for debugging
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Building MainPage with selectedIndex: $_selectedIndex'); // Print statement for debugging
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Controller',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          print('BottomNavigationBar tapped, index: $index'); // Debug print
          _onItemTapped(index);
        },
      ),
    );
  }
}
