import 'dart:convert';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:mentoring_app/api/my_api.dart';
import 'package:mentoring_app/auth/auth_page.dart';
import 'package:mentoring_app/models/get_article_info.dart';
import 'package:mentoring_app/singup_login/sign_in.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var articles = <ArticleInfo>[];
  var _totalDots = 1;
  int _currentPosition = 0;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  int _validPosition(int position) {
    if (position >= _totalDots) return _totalDots - 1;
    if (position < 0) return 0;
    return position;
  }

  void _updatePosition(int position) {
    setState(() {
      _currentPosition = _validPosition(position);
    });
  }

  Widget _buildRow(List<Widget> widgets) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widgets,
      ),
    );
  }

  String getCurrentPositionPretty() {
    return (_currentPosition + 1).toStringAsPrecision(2);
  }

  Future<void> _initData() async {
    var response = await CallApi().getPublicData("welcomeinfo");
    if (response != null && response.statusCode == 200) {
      setState(() {
        print(response.body);  // Lihat response body di console
        Iterable list = json.decode(response.body);
        articles = list.map((model) => ArticleInfo.fromJson(model)).toList();
        _totalDots = articles.length;
        print(articles);  // Lihat daftar artikel yang dihasilkan
      });
    } else {
      print('Failed to load articles');
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPosition = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 51, 148, 91),
      body: SingleChildScrollView( // Tambahkan SingleChildScrollView di sini
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 2,  // Atur ukuran sesuai kebutuhan Anda
              child: Image.asset(
                "img/logo.png",
                fit: BoxFit.contain,  // Mengubah ukuran gambar agar tetap sesuai dengan kontainer
              ),
            ),
            _buildRow([
              DotsIndicator(
                dotsCount: _totalDots,
                position: _currentPosition.toInt(),
                axis: Axis.horizontal,
                decorator: DotsDecorator(
                  size: Size.square(9.0),
                  activeSize: Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onTap: (pos) {
                  setState(() {
                    _currentPosition = pos.toInt();
                  });
                },
              ),
            ]),
            Container(
              height: 180,
              color: Color.fromARGB(255, 51, 148, 91),
              child: PageView.builder(
                onPageChanged: _onPageChanged,
                controller: PageController(viewportFraction: 1.0),
                itemCount: articles.isEmpty ? 0 : articles.length,
                itemBuilder: (_, i) {
                  return Container(
                    height: 180,
                    padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(right: 10),
                    child: Text(
                      articles[i].article_content ?? "Nothing",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "Avenir",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4, // Atur ukuran sesuai kebutuhan Anda
              child: Stack(
                children: [
                  Positioned(
                    height: 60,
                    bottom: 50,
                    left: (MediaQuery.of(context).size.width - 200) / 2,
                    right: (MediaQuery.of(context).size.width - 200) / 2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                        );
                      },
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color.fromARGB(255, 164, 175, 2),
                        ),
                        child: const Center(
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
