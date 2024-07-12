class Article {
  final String title;
  final String summary;
  final String image;
  final String content;

  Article({
    required this.title,
    required this.summary,
    required this.image,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['article_title'],
      summary: json['article_summary'],
      image: json['article_image'],
      content: json['article_content'],
    );
  }
}
