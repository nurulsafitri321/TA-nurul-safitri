import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mentoring_app/api/my_api.dart';
import 'package:mentoring_app/models/get_article_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detail_book.dart';

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
      body: Column(
        children: [
          // Add your widget here
        ],
      ),
    );
  }
}
