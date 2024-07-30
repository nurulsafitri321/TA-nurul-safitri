import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mentoring_app/api/my_api.dart';
import 'package:mentoring_app/components/text_widget.dart';
import 'package:mentoring_app/models/get_article_info.dart';
import 'package:mentoring_app/pages/detail_book.dart';
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
    await CallApi().getPublicData("recommendedarticles").then((response) {
      if (response != null && response.body != null) {
        setState(() {
          Iterable list = json.decode(response.body);
          articles = list.map((model) => ArticleInfo.fromJson(model)).toList();
        });
      } else {
        print('Response is null');
      }
    });
    await CallApi().getPublicData("allarticles").then((response) {
      if (response != null && response.body != null) {
        setState(() {
          Iterable list = json.decode(response.body);
          allarticles = list.map((model) => ArticleInfo.fromJson(model)).toList();
        });
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
        toolbarHeight: 30,
        backgroundColor: Color(0xFFffffff),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu_book_sharp, color: Color.fromARGB(255, 51, 148, 91)),
                  Icon(Icons.menu, color: Color.fromARGB(255, 51, 148, 91))
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  TextWidget(
                    text: "Today",
                    fontSize: 36,
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SearchBar(),
                )),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                      text: "view all", fontSize: 16, color: Color.fromARGB(255, 51, 148, 91)),
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios_new_outlined,
                          color: Color.fromARGB(255, 51, 148, 91)),
                      onPressed: () {})
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
                height: height * 0.27,
                child: PageView.builder(
                  controller: PageController(viewportFraction: .9),
                  itemCount: articles.isEmpty ? 0 : articles.length,
                  itemBuilder: (_, i) {
                    return GestureDetector(
                      onTap: () {
                        debugPrint(i.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailBookPage(
                                articleInfo: articles[i], index: i),
                          ),
                        );
                      },
                      child: articles.isEmpty
                          ? CircularProgressIndicator()
                          : Stack(
                              children: [
                                Positioned(
                                    top: 35,
                                    child: Material(
                                      elevation: 0.0,
                                      child: Container(
                                        height: 180.0,
                                        width: width * 0.85,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color:
                                                    Colors.grey.withOpacity(0.3),
                                                offset: Offset(-10.0, 0.0),
                                                blurRadius: 20.0,
                                                spreadRadius: 4.0),
                                          ],
                                        ),
                                      ),
                                    )),
                                Positioned(
                                  top: 0,
                                  left: 10,
                                  child: Card(
                                    elevation: 10.0,
                                    shadowColor: Colors.grey.withOpacity(0.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      height: 200,
                                      width: width * 0.85,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Image.network(
                                        "http://10.0.2.2:8000/uploads/" +
                                            (articles[i].img ?? 'default_image.jpg'),
                                        fit: BoxFit.cover,
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
                                  ),
                                ),
                                Positioned(
                                  top: 45,
                                  left: width * 0.4,
                                  child: Container(
                                    height: 200,
                                    width: 150,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text: articles[i].title,
                                          fontSize: 20,
                                        ),
                                        TextWidget(
                                            color: Colors.grey,
                                            text: articles[i].author == null
                                                ? "Unknown"
                                                : articles[i].author,
                                            fontSize: 16),
                                        Divider(color: Colors.black),
                                        TextWidget(
                                            text: articles[i].description ?? '',
                                            fontSize: 16,
                                            color: Colors.grey),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    );
                  },
                )),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              height: height * 0.4,
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
                                    fontSize: 20,
                                  ),
                                  TextWidget(
                                      text: allarticles[i].author == null
                                          ? "Author: Unknown"
                                          : "Author: " + allarticles[i].author,
                                      fontSize: 16,
                                      color: Color(0xFFa9b3bd)),
                                ],
                              ),
                            ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
