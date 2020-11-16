/// Data class for mapping a News JSON to Dart object.
class Article {
  final String title;
  final String content;
  final String url;
  final String imageUrl;
  final String publishedAt;

  Article(
      {this.title, this.content, this.url, this.imageUrl, this.publishedAt});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      imageUrl: json['urlToImage'],
      url: json['url'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
}
