import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/models/models.dart';

class NewsApiClient {
  final _baseUrl = 'https://newsapi.org/v2';
  final _apiLink = 'apiKey=fa5772973bdc47acb28571a105f176dc';
  final http.Client httpClient;
  NewsApiClient({
    required this.httpClient,
  });

  /// Fetching future
  /// [startIndex] indect where the current pagniation
  /// [language] in which language retrive the news
  /// [pageSize] how many recored in each request
  Future<List<Articles>> fetchNews(
      {int startIndex = 0,
      required String language,
      required int pageSize}) async {
    final url =
        '$_baseUrl/top-headlines?language=$language&pagesize=$pageSize&page=$startIndex&$_apiLink';
    final response = await httpClient.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final news = News.fromJson(body);
      return news.articles;
    }
    if (response.statusCode == 426) {
      return [];
    }
    throw Exception('error fetching news');
  }
}
