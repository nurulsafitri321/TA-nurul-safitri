import 'package:flutter/material.dart';

class tentang_hrd extends StatefulWidget {
  const tentang_hrd({Key? key}) : super(key: key);

  @override
  State<tentang_hrd> createState() => _tentang_hrdState();
}

class _tentang_hrdState extends State<tentang_hrd> {
  @override
  Widget build(BuildContext context) {
    String explanation = "Human Resource Development Lembaga Responsi Agama Islam Politeknik"
"Negeri Padang (HRD-LRAI PNP) merupakan Identitas Organisasi yang bergerak"
"di bidang pengkaderan yang bertujuan memfasilitasi LRAI dalam memberikan"
"pemahaman kepada para calon mentor dan mentor demi kelancaran dakwah islam"
"dikampus Politeknik Negeri Padang."
"\n\nAdapun rincian tugas dari divisi HRD berdasarkan hasil keputusan"
"Musyawarah Umum LRAI 2023 adalah sebagasi berikut :\n"
"\n1. Open recruitment LRAI PNP"
"\n2. Mengelola dan mengkoordinir jenjang pengkaderan calon anggota LRAI PNP"
"\n3. Pendataan calon anggota LRAI PNP"
"\n4. Memberikan motivasi kepada anggota baru LRAI PNP dalam kegiatan"
"training atau berupa pelatihan ";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HRD',
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
                  'img/hrd.png',
                  width: 150, // Atur lebar gambar
                  height: 150, // Atur tinggi gambar
                  fit: BoxFit.cover, // Atur cara gambar menyesuaikan dalam container
                ),
                SizedBox(height: 20),
                Text(
                  'Human Resources Development',
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
