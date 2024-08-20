import 'package:flutter/material.dart';

class tentang_danus extends StatefulWidget {
  const tentang_danus({Key? key}) : super(key: key);

  @override
  State<tentang_danus> createState() => _tentang_danusState();
}

class _tentang_danusState extends State<tentang_danus> {
  @override
  Widget build(BuildContext context) {
    String explanation = "Humas dan Danus adalah salah satu divisi di LRAI yang memfokuskan untuk"
    "mendukung segala kegiatan yang berkaitan dengan LRAI dalam hal keuangan."
    "Humas dan Danus merupakan salah satu divisi di LRAI Politeknik negeri Padang"
    "yang berperan dalam mencukupi kebutuhan keuangan LRAI. \n\nGambaran kegiatan Humas"
    "dan Danus berupa Menyusun strategi dan taktik pendanaan bersama dengan bendahara"
    "dan mengadakan segala usaha yang halal, kreatif dan produktif untuk mendapatkan dana"
    "demi kelancaran kegiatan internal dan eksternal LRAI, meliputi mencari donator tetap"
    "untuk LRAI melalui proposal global dan membangun suasana ilmiah di kampus. ";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HUMAS & DANUS',
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
                  'img/danus.png',
                  width: 150, // Atur lebar gambar
                  height: 150, // Atur tinggi gambar
                  fit: BoxFit.cover, // Atur cara gambar menyesuaikan dalam container
                ),
                SizedBox(height: 20),
                Text(
                  'Humas & Danus',
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

// void main() {
//   runApp(MaterialApp(
//     home: HRDPage(),
//   ));
// }
