import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final int fontSize; // Make this final
  final bool isUnderLine; // Make this final
  final Color color;

  TextWidget({
    Key? key,
    required this.text,
    this.fontSize = 14, // Provide a default value
    this.isUnderLine = false,
    this.color = const Color.fromARGB(255, 51, 148, 91),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 3, // space between underline and text
      ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(
            color: isUnderLine?Color.fromARGB(255, 213, 216, 12):Color(0xFFffffff),  // Text colour here
            width: 1.0, // Underline width
          ))
      ),

      child: Text(this.text, style: TextStyle(
        fontSize:this.fontSize.toDouble(),fontFamily: "Avenir",
        fontWeight: FontWeight.w900,
        color:this.color,

      ),),
    );
  }
}
