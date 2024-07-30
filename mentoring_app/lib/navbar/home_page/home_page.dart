import 'package:flutter/material.dart';
import 'package:mentoring_app/pages/article_page.dart'; // Import the ArticlePage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Instead of showing just text, navigate to ArticlePage directly
    return ArticlePage(); // Directly return the ArticlePage widget
  }
}
