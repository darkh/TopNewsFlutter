import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String status;
  final int totalResults;
  final List<Articles> articles;
  const News(
      {required this.articles,
      required this.status,
      required this.totalResults});

  static News fromJson(dynamic json) => News(
      articles:
          (json['articles'] as List).map((i) => Articles.fromJson(i)).toList(),
      status: json['status'],
      totalResults: json['totalResults']);

  @override
  List<Object?> get props => [status, totalResults, articles];
}

class Articles extends Equatable {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  const Articles(
      {required this.source,
      this.author = '',
      this.title = '',
      this.description = '',
      this.url = '',
      this.urlToImage = '',
      this.publishedAt = '',
      this.content = ''});

  static Articles fromJson(dynamic json) => Articles(
      source: Source.fromJson(json['source']),
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '');

  @override
  List<Object?> get props =>
      [author, title, description, url, urlToImage, publishedAt, content];
}

class Source extends Equatable {
  final String id;
  final String name;

  const Source({
    this.id = '',
    this.name = '',
  });

  static Source fromJson(dynamic json) => Source(
        id: json['id'] ?? '',
        name: json['name'],
      );

  @override
  List<Object?> get props => [id, name];
}
