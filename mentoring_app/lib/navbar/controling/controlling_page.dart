import 'package:flutter/material.dart';
import 'package:mentoring_app/components/text_widget.dart';
import 'package:mentoring_app/models/user_provider.dart';
import 'package:mentoring_app/navbar/controling/widget/evaluasi_screen.dart';
import 'package:mentoring_app/pages/menteeformpage.dart';
import 'package:mentoring_app/pages/menteelistpage.dart';
import 'package:mentoring_app/pages/widgets/DashedLInedPainter.dart';
import 'package:provider/provider.dart';

class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key});

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  void _showNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Semoga Allah mudahkan jalan mu di setiap langkah!"),
        backgroundColor: Color.fromARGB(255, 51, 148, 91), // Mengubah warna latar belakang notifikasi
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengelolaan Mentoring',
          style: TextStyle(
            color: Color.fromARGB(255, 51, 148, 91),
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 51, 148, 91)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                // Navigasi ke halaman lain saat ikon diklik
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EvaluasiScreen()), // Ganti HalamanLain() dengan page tujuan Anda
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color.fromARGB(255, 51, 148, 91), // Warna bordir hijau
                    width: 2.0,  // Ketebalan bordir
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,  // Background putih
                  radius: 15,  // Ukuran lingkaran
                  child: Icon(
                    Icons.edit,  // Menggunakan ikon pen
                    color: Color.fromARGB(255, 51, 148, 91),  // Ikon berwarna hijau
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0), // Penambahan padding pada SingleChildScrollView
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight, // Membuat widget agar tidak menyebabkan error layout
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: const Color.fromARGB(255, 51, 148, 91),
                      shadowColor: Colors.grey,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0), // Perbaikan padding
                        child: Column(
                          children: [
                            Text(
                              "Hallo ${user?.name ?? 'Mentor'}! Ayo lanjutkan progres kelompok mentoringnya :)",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                onPressed: _showNotification,
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: const Color.fromARGB(255, 51, 148, 91),
                                  backgroundColor: Colors.white,
                                ),
                                child: const Text("OK"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomPaint(
                      size: const Size(double.infinity, 1),
                      painter: DashedLinePainter(),
                    ),
                    // Container(
                    //   padding: const EdgeInsets.only(left: 20, right: 30, top: 10), // Penambahan padding pada Container
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       TextWidget(
                    //         text: "Pengelolaan Mentoring",
                    //         fontSize: 20,
                    //         color: Color.fromARGB(255, 51, 148, 91),
                    //       ),
                    //       Align(
                    //         alignment: Alignment.centerRight,
                    //         child: ElevatedButton(
                    //           onPressed: () {
                    //             Navigator.push(
                    //               context,
                    //               MaterialPageRoute(builder: (context) => const MenteeFormPage()),
                    //             ).then((_) {
                    //               setState(() {}); // Refresh page after returning from form page
                    //             });
                    //           },
                    //           child: const Text("Tambah Mentee"),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: MenteeListPage(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
