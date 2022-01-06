part of 'news_bloc.dart';

enum NewsStatus { initial, success, failure }

class NewsState extends Equatable {
  final NewsStatus status;
  final List<Articles> news;
  final bool hasReachedMax;

  const NewsState({
    this.status = NewsStatus.initial,
    this.news = const <Articles>[],
    this.hasReachedMax = false,
  });

  NewsState copyWith({
    NewsStatus? status,
    List<Articles>? news,
    bool? hasReachedMax,
  }) {
    return NewsState(
      status: status ?? this.status,
      news: news ?? this.news,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''NewsState { status: $status, hasReachedMax: $hasReachedMax, news: ${news.length} }''';
  }

  @override
  List<Object?> get props => [status, news, hasReachedMax];
}
