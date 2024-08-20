import 'package:flutter/material.dart';

class tentang_m2ss extends StatefulWidget {
  const tentang_m2ss({Key? key}) : super(key: key);

  @override
  State<tentang_m2ss> createState() => _tentang_m2ssState();
}

class _tentang_m2ssState extends State<tentang_m2ss> {
  @override
  Widget build(BuildContext context) {
    String explanation = "Divisi Multimedia Support System (M2SS) ini merupakan divisi yang bertanggung"
    "jawab terhadap syiar dakwah di kampus Politeknik Negeri Padang dengan"
    "menggunakan berbagai media yang yang berkembang saat ini, baik syiar melalui poster"
    "atau pamflet, media sosial dll.";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'M2SS',
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
                  'img/m2ss.png',
                  width: 150, // Atur lebar gambar
                  height: 150, // Atur tinggi gambar
                  fit: BoxFit.cover, // Atur cara gambar menyesuaikan dalam container
                ),
                SizedBox(height: 20),
                Text(
                  'Multimedia Support System',
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

