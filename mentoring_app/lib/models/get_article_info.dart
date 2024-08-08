class ArticleInfo {
  final int id;
  final String article_content;
  final String title;
  final String description;
  final String created_at;
  final String img;
  final String author;

  // Constructor with initializer list
  ArticleInfo({
    required this.id,
    required this.article_content,
    required this.title,
    required this.description,
    required this.created_at,
    required this.img,
    required this.author,
  });

  // Named constructor for creating an instance from JSON
  ArticleInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        article_content = json['article_content'] ?? '', // Provide default value
        title = json['title'] ?? '', // Provide default value
        description = json['description'] ?? '', // Provide default value
        created_at = json['created_at'] ?? '', // Provide default value
        img = json['img'] ?? '', // Provide default value
        author = json['author'] ?? '';

  String? get imageUrl => null; // Provide default value

  // Method to convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'article_content': article_content,
      'title': title,
      'description': description,
      'created_at': created_at,
      'img': img,
      'author': author,
    };
  }
}

void main() {
  // Example of creating an ArticleInfo instance
  ArticleInfo article = ArticleInfo(
    id: 1,
    article_content: 'This is the content of the article.',
    title: 'Article Title',
    description: 'This is the description of the article.',
    created_at: '2023-07-17',
    img: 'image_path',
    author: 'Author Name',
  );

  // Example of creating an ArticleInfo instance from JSON
  Map<String, dynamic> json = {
    'id': 1,
    'article_content': 'This is the content of the article.',
    'title': 'Article Title',
    'description': 'This is the description of the article.',
    'created_at': '2023-07-17',
    'img': 'image_path',
    'author': 'Author Name',
  };
  ArticleInfo articleFromJson = ArticleInfo.fromJson(json);

  // Example of converting an ArticleInfo instance to JSON
  Map<String, dynamic> articleToJson = article.toJson();

  print('Article ID: ${article.id}');
  print('Article Title: ${article.title}');
  print('Article Content: ${article.article_content}');
  print('Article Description: ${article.description}');
  print('Created At: ${article.created_at}');
  print('Image: ${article.img}');
  print('Author: ${article.author}');
}
