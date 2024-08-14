import 'package:flutter/material.dart';
import 'package:mentoring_app/pages/widgets/DashedLInedPainter.dart';
import 'package:url_launcher/url_launcher.dart';

class PPTPage extends StatelessWidget {
  const PPTPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PPT'),
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Klik Disini untuk mendapatkan fasilitas mentoring',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        const url ='https://balsamiq.cloud/sxd3ux2/pn33z2x/rF4E1';
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
                      ),
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
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color.fromARGB(255, 51, 148, 91),
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${index + 1}. ${_getMateriTitle(index)}',
                            style: TextStyle(color: Colors.white),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Ganti dengan path file PDF yang sesuai
                              _openPDF(context, 'assets/materi${index + 1}.pdf');
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMateriTitle(int index) {
    const titles = [
      "Pengenalan Mentoring",
      "Ma'rifatullah",
      "Ma'rifatullah",
      "Ma'rifatullah",
      "Ma'rifatullah",
      "Ma'rifatullah",
      "Ma'rifatullah",
      "Ma'rifatullah",
      "Ma'rifatullah",
      "Ma'rifatullah",
    ];
    return titles[index];
  }

  void _openPDF(BuildContext context, String path) {
    // Implementasi untuk membuka PDF
    // Anda bisa menggunakan package seperti 'flutter_full_pdf_viewer' atau 'open_file'
    print('Opening PDF at path: $path');
  }
}
