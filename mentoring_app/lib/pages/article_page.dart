import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mentoring_app/api/my_api.dart';
import 'package:mentoring_app/components/text_widget.dart';
import 'package:mentoring_app/models/get_article_info.dart';
import 'package:mentoring_app/navbar/controling/widget/amal_yaumi_screen.dart';
import 'package:mentoring_app/navbar/controling/widget/hafalan_screen.dart';
import 'package:mentoring_app/navbar/controling/widget/materi_screen.dart';
import 'package:mentoring_app/navbar/controling/widget/presesnsi_screen.dart';
import 'package:mentoring_app/navbar/controling/widget/ujian_mentoring.dart';
import 'package:mentoring_app/navbar/home_page/profile_lrai/Tentang_m2ss.dart';
import 'package:mentoring_app/navbar/home_page/profile_lrai/tentang_danus.dart';
import 'package:mentoring_app/navbar/home_page/profile_lrai/tentang_hrd.dart';
import 'package:mentoring_app/navbar/home_page/profile_lrai/tentang_mai.dart';
import 'package:mentoring_app/pages/detail_book.dart';
import 'package:mentoring_app/pages/widgets/CalendarWidget.dart';
import 'package:mentoring_app/pages/widgets/CircleButton.dart';
import 'package:mentoring_app/pages/widgets/DashedLInedPainter.dart';
import 'package:mentoring_app/pages/widgets/data_group_mentoring.dart';
import 'package:mentoring_app/pages/widgets/data_mente.dart';
import 'package:mentoring_app/pages/widgets/data_mentor.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  var articles = <ArticleInfo>[];
  var allarticles = <ArticleInfo>[];

  @override
  void initState() {
    _getArticles();
    super.initState();
  }

  _getArticles() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString("user");

    await _initData();
  }

  _initData() async {
  await CallApi().getPublicData("allarticles").then((response) {
    if (response != null && response.body != null) {
      if (mounted) {  // Check if the widget is still mounted
        setState(() {
          Iterable list = json.decode(response.body);
          allarticles = list.map((model) => ArticleInfo.fromJson(model)).toList();
        });
      }
    } else {
      print('Response is null');
    }
  });
}


  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    debugPrint(height.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      backgroundColor: Color(0xFFffffff),
      elevation: 0.0,
      automaticallyImplyLeading: false,
      toolbarHeight: 75,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "Selamat Datang, \nMentor Lrai Pnp !",
              style: TextStyle(
                color: Color.fromARGB(255, 51, 148, 91),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 15), // Jarak antara teks dan logo
          Image.asset(
            'img/lrai.png',
            height: 70,
          ),
        ],
      ),
    ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height * 0.02),
            CustomPaint(
              size: Size(double.infinity, 1),
              painter: DashedLinePainter(),
            ),
            SizedBox(height: height * 0.02),
            Container(
            padding: const EdgeInsets.only(left: 20, right: 30, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: "Divisi LRAI Pnp",
                  fontSize: 20,
                  color: Color.fromARGB(255, 51, 148, 91),
                ),
              ],
            ),
          ),
            Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleButton(
                  icon: Icons.person_add_alt_1, // Ikon yang lebih sesuai untuk HRD
                  label: 'HRD',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const tentang_hrd()),
                    );
                  },
                ),
                CircleButton(
                  icon: Icons.admin_panel_settings, // Ikon yang lebih sesuai untuk MAI
                  label: 'MAI',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const tentang_mai()),
                    );
                  },
                ),
                CircleButton(
                  icon: Icons.attach_money, // Ikon yang lebih sesuai untuk DANUS
                  label: 'HUDAS',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const tentang_danus()),
                    );
                  },
                ),
                CircleButton(
                  icon: Icons.art_track, // Ikon yang lebih sesuai untuk M2SS (Media Pengeditan)
                  label: 'M2SS',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const tentang_m2ss()),
                    );
                  },
                ),
              ],
            ),
          ),

            SizedBox(height: height * 0.02),
            CustomPaint(
              size: Size(double.infinity, 1),
              painter: DashedLinePainter(),
            ),
            SizedBox(height: height * 0.02),
            Container(
            padding: const EdgeInsets.only(left: 20, right: 30, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: "Sekilas Tentang Materi",
                  fontSize: 20,
                  color: Color.fromARGB(255, 51, 148, 91),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.01), // Kurangi jarak di sini
          Container(
            height: height * 0.3,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: allarticles.isEmpty ? 0 : allarticles.length,
              itemBuilder: (_, i) {
                return GestureDetector(
                  onTap: () {
                    debugPrint(i.toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailBookPage(
                          articleInfo: allarticles[i],
                          index: i,
                        ),
                      ),
                    );
                  },
                  child: allarticles.isEmpty
                      ? CircularProgressIndicator()
                      : Container(
                          width: 150,
                          margin: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Image.network(
                                  "http://10.0.2.2:8000/uploads/" +
                                      (allarticles[i].img ?? 'default_image.png'),
                                  fit: BoxFit.contain,
                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                    return Text('Failed to load image');
                                  },
                                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              TextWidget(
                                text: allarticles[i].title,
                                fontSize: 15,
                              ),
                              TextWidget(
                                text: allarticles[i].author == null
                                    ? "Author: Unknown"
                                    : "Author: " + allarticles[i].author,
                                fontSize: 14,
                                color: Color(0xFFa9b3bd),
                              ),
                            ],
                          ),
                        ),
                );
              },
            ),
          ),
          
          CustomPaint(
              size: Size(double.infinity, 1),
              painter: DashedLinePainter(),
            ),
            SizedBox(height: height * 0.02),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 30, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: "Pengelolaan Mentoring", 
                    fontSize: 20, 
                    color: Color.fromARGB(255, 51, 148, 91),
                  ),
                ],
              ),
            ),
          
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleButton(
                    icon: Icons.calendar_today,
                    label: 'Kehadiran',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PresensiScreen()),
                      );
                    }, 
                  ),
                  CircleButton(
                    icon: Icons.book,
                    label: 'Materi',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MateriScreen()),
                      );
                    }, 
                  ),
                  CircleButton(
                    icon: Icons.favorite,
                    label: 'Amal Yaumi',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AmalYaumiScreen()),
                      );
                    },
                  ),
                  CircleButton(
                    icon: Icons.memory,
                    label: 'Hafalan',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HafalanScreen()),
                      );
                    }, 
                  ),
                  CircleButton(
                    icon: Icons.school,
                    label: 'Ujian',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UjianMentoring()),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.02),
            CustomPaint(
            size: Size(double.infinity, 1),
            painter: DashedLinePainter(),
          ),
          SizedBox(height: height * 0.02), // Kurangi jarak di sini
          Container(
            padding: const EdgeInsets.only(left: 20, right: 30, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: "Data Mentoring",
                  fontSize: 20,
                  color: Color.fromARGB(255, 51, 148, 91),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Card(
                      color: Color.fromARGB(255, 51, 148, 91),
                      shadowColor: Colors.grey.withOpacity(0.9),
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Data Mentor',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DataMentorPage(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  shadowColor: Colors.grey.withOpacity(0.5),
                                  minimumSize: Size(30, 30),
                                ),
                                child: Text(
                                  'Klik',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Card(
                      color: Color.fromARGB(255, 51, 148, 91),
                      shadowColor: Colors.grey.withOpacity(0.9),
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Data Mente',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DataMenteePage(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  shadowColor: Colors.grey.withOpacity(0.5),
                                  minimumSize: Size(30, 30),
                                ),
                                child: Text(
                                  'Klik',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Card(
                color: Color.fromARGB(255, 51, 148, 91),
                shadowColor: Colors.grey.withOpacity(0.9),
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Data Group Mentoring',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DataGroupMentorPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 252, 252, 252),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadowColor: Colors.grey.withOpacity(0.5),
                            minimumSize: Size(30, 30),
                          ),
                          child: Text(
                            'Klik',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: height * 0.03),
        CustomPaint(
            size: Size(double.infinity, 1),
            painter: DashedLinePainter(),
          ),
          SizedBox(height: height * 0.02),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 30, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: "Kalender",
                  fontSize: 20,
                  color: Color.fromARGB(255, 51, 148, 91),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          Container(
              height: height * 0.7, // Berikan tinggi tetap pada container kalender
              child: CalendarWidget(), // Menambahkan CalendarWidget di sini
            ),
          SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }
}
