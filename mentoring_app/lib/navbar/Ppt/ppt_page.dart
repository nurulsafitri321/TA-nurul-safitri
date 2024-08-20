import 'package:flutter/material.dart';
import 'package:mentoring_app/models/pdf_model.dart';
import 'package:mentoring_app/pages/widgets/DashedLInedPainter.dart';
import 'package:mentoring_app/service/fetchPdfs.dart';
import 'package:url_launcher/url_launcher.dart';

class PPTPage extends StatefulWidget {
  const PPTPage({super.key});

  @override
  _PPTPageState createState() => _PPTPageState();
}

class _PPTPageState extends State<PPTPage> {
  late Future<List<Pdf>> futurePdfs;

  @override
  void initState() {
    super.initState();
    futurePdfs = fetchPdfs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Halaman Materi Mentoring',
          style: TextStyle(
            color: Color.fromARGB(255, 51, 148, 91),
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 51, 148, 91)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fasilitas Mentoring',
              style: TextStyle(
                fontSize: 24,
                color: const Color.fromARGB(255, 51, 148, 91),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              color: const Color.fromARGB(255, 51, 148, 91),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Posisi tombol di kanan
                  crossAxisAlignment: CrossAxisAlignment.start, // Mengatur tombol dan teks di bagian atas
                  children: [
                    Expanded(
                      child: Text(
                        'Klik Disini untuk mendapatkan fasilitas mentoring',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0, // Ukuran font
                          fontWeight: FontWeight.bold, // Teks tebal
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 32.0), // Menambahkan jarak vertikal antara teks dan tombol
                        ElevatedButton(
                          onPressed: () async {
                            const url = 'https://s.id/mentoringagamaislam';
                            final uri = Uri.parse(url);

                            print('Attempting to launch $url');
                            if (await canLaunchUrl(uri)) {
                              print('Launching $url');
                              await launchUrl(
                                uri,
                                mode: LaunchMode.externalApplication,
                              );
                            } else {
                              print('Could not launch $url');
                              throw 'Could not launch $url';
                            }
                          },
                          child: Text(
                            'Klik',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 51, 148, 91),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0), // Membuat tombol berbentuk segi empat
                            ),
                            elevation: 5, // Memberikan efek bayangan pada tombol
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CustomPaint(
              size: Size(double.infinity, 1),
              painter: DashedLinePainter(),
            ),
            SizedBox(height: 20),
            Text(
              'Baca Materi Mentoring',
              style: TextStyle(
                fontSize: 24,
                color: const Color.fromARGB(255, 51, 148, 91),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Pdf>>(
                future: futurePdfs,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No PDFs available'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final pdf = snapshot.data![index];
                        return Card(
                          color: const Color.fromARGB(255, 51, 148, 91),
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${index + 1}. ${pdf.title}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    final uri = Uri.parse('http://10.0.2.2:8000/api/pdfs/');
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                                    } else {
                                      throw 'Could not launch ${uri.toString()}';
                                    }
                                  },
                                  child: Text('Baca'),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: const Color.fromARGB(255, 51, 148, 91),
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
