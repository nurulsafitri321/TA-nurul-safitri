import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  CircleButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 51, 148, 91), // Ganti warna sesuai kebutuhan
            ),
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }
}
