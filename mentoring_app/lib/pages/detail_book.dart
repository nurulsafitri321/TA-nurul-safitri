import 'package:flutter/material.dart';
import 'package:mentoring_app/components/text_widget.dart';
import 'package:mentoring_app/models/get_article_info.dart';
import 'package:mentoring_app/pages/all_books.dart';

class DetailBookPage extends StatefulWidget {
  final ArticleInfo articleInfo; // Tambahkan variabel ini
  final int index; // Tambahkan variabel ini

  const DetailBookPage({Key? key, required this.articleInfo, required this.index})
      : super(key: key);

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Color(0xFFffffff),
        elevation: 0.0,
        leading: IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          icon: Icon(Icons.arrow_back_ios, color: Color.fromARGB(255, 51, 148, 91)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 0, right: 30),
              child: Row(
                children: [
                  Material(
                    elevation: 0.0,
                    child: Container(
                      height: 180,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        image: DecorationImage(
                          image: NetworkImage(
                            "http://10.0.2.2:8000/uploads/" + widget.articleInfo.img,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: screenWidth - 30 - 180 - 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        TextWidget(
                          text: widget.articleInfo.title,
                          fontSize: 30,
                        ),
                        TextWidget(
                          text: "Lembaga: ${widget.articleInfo.author}",
                          fontSize: 20,
                          color: Color(0xFF7b8ea3),
                        ),
                        Divider(color: Colors.grey),
                        TextWidget(
                          text: widget.articleInfo.title,
                          fontSize: 16,
                          color: Color(0xFF7b8ea3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Divider(color: Color(0xFF7b8ea3)),
            SizedBox(height: 10),
            // Container(
            //   padding: const EdgeInsets.only(right: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Row(
            //         children: <Widget>[
            //           Icon(Icons.favorite, color: Color(0xFF7b8ea3), size: 40),
            //           SizedBox(width: 10),
            //           TextWidget(text: "Like", fontSize: 20),
            //         ],
            //       ),
            //       Row(
            //         children: <Widget>[
            //           Icon(Icons.share, color: Color(0xFF7b8ea3), size: 40),
            //           SizedBox(width: 10),
            //           TextWidget(text: "Share", fontSize: 20),
            //         ],
            //       ),
            //       Row(
            //         children: <Widget>[
            //           Icon(Icons.bookmarks_sharp, color: Color(0xFF7b8ea3), size: 40),
            //           SizedBox(width: 10),
            //           TextWidget(text: "Bookself", fontSize: 20),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 5),
            Row(
              children: [
                TextWidget(
                  text: "Daftar Isi",
                  fontSize: 30,
                ),
                Expanded(child: Container()),
              ],
            ),
            SizedBox(height: 30),
            Container(
              height: 200,
              child: SingleChildScrollView(
                child: Text(
                  widget.articleInfo.article_content,
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 110, 100, 100),
                  ),
                  textAlign: TextAlign.justify, // Menambahkan justifikasi
                ),
              ),
            ),
            Divider(color: Color(0xFF7b8ea3)),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllBooks()),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    TextWidget(
                      text: "Lihat directory",
                      fontSize: 20,
                    ),
                    Expanded(child: Container()),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: null,
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: Color(0xFF7b8ea3)),
            SizedBox(height: 30), // Jarak antara elemen
            // ElevatedButton(
            //   onPressed: () {
            //     // Tambahkan logika untuk membuka PDF atau melakukan tindakan lain
            //   },
            //   style: ElevatedButton.styleFrom(
            //     foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 54, 141, 57), // Warna teks putih
            //   ),
            //   child: Text("Baca"),
            // ),
          ],
        ),
      ),
    );
  }
}
