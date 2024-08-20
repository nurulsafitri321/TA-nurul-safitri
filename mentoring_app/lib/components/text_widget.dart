import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  final String text;
  final int fontSize;
  final bool isUnderLine;
  final Color color;
  final int maxLines; // Menambahkan properti untuk batas maksimal baris

  TextWidget({
    Key? key,
    required this.text,
    this.fontSize = 14,
    this.isUnderLine = false,
    this.color = const Color.fromARGB(255, 51, 148, 91),
    this.maxLines = 3, // Batas maksimal baris yang ditampilkan sebelum menunjukkan "Lihat Semua"
  }) : super(key: key);

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  bool isExpanded = false; // Mengontrol apakah teks diperluas atau tidak

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            bottom: 3, // space between underline and text
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: widget.isUnderLine
                    ? Color.fromARGB(255, 213, 216, 12)
                    : Color(0xFFffffff),
                width: 1.0, // Underline width
              ),
            ),
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: widget.fontSize.toDouble(),
              fontFamily: "Avenir",
              fontWeight: FontWeight.w900,
              color: widget.color,
            ),
            maxLines: isExpanded ? null : widget.maxLines, // Logic untuk batas maksimal baris
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis, // Overflow logic
          ),
        ),
        if (widget.text.length > 100) // Menambahkan tombol "Lihat Semua" jika teks terlalu panjang
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? 'Tampilkan Lebih Sedikit' : 'Lihat Semua',
              style: TextStyle(
                color: Colors.blue, // Ganti warna sesuai kebutuhan Anda
              ),
            ),
          ),
      ],
    );
  }
}
