import 'package:flutter/material.dart';

class tentang_mai extends StatefulWidget {
  const tentang_mai({Key? key}) : super(key: key);

  @override
  State<tentang_mai> createState() => _tentang_maiState();
}

class _tentang_maiState extends State<tentang_mai> {
  @override
  Widget build(BuildContext context) {
    String explanation = "Kegiatan MAI diselenggarakan dengan maksud untuk membina keimanan dan ketaqwaan seluruh"
    "unsur yang terkait dalam pelaksanaannya, melalui penambahan wawasan keislaman serta nilai-nilai Islam"
    "dalam kehidupan sehari-hari serta melaksanakan kegiatan syiar Islam di kawasan kampus Politeknik Negeri"
    "Padang.\n\n"

    "Pelaksanaan MAI ini bertujuan untuk mencapai keridhaan ALLAH SWT dalam membentuk dan"
    "meningkatkan intelektual muslim melalui pembinaan pribadi muslim (syaksia islamiah) dan pembinaan"
    "kehidupan berjamaah (ukhuwah islamiah) dalam peran sebagai intelektual muslim, memperdalam materi"
    "MKPAI, menumbuhkan keterpautan hati dengan masjid, optimisme perbaikan diri, menambah" 
    "kebanggaan sebagai muslim sejati dan menumbuhkan kemauan berdakwah sehingga lahirlah diploma"
    "muslim yang menguasai iptek berwawasan imtaq sesuai dengan misi PNP itu sendiri “Berakhlak Mulia”"
    "dan tujuan diperguruan tinggi serta tujuan pendidikan NASIONAL.";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MAI',
          style: TextStyle(color: const Color.fromARGB(255, 51, 148, 91), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 51, 148, 91)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'img/mai.png',
                  width: 150, // Atur lebar gambar
                  height: 150, // Atur tinggi gambar
                  fit: BoxFit.cover, // Atur cara gambar menyesuaikan dalam container
                ),
                SizedBox(height: 20),
                Text(
                  'Mentoring Agama Islam',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    explanation,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

