class Article {
  late String author;
  late String title;

  Article(
    this.author,
    this.title,
  );

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      json['author'] as String,
      json['title'] as String,
    );
  }
}
