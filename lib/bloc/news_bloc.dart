import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:newsapp/client/client.dart';
import 'package:newsapp/models/news.dart';
import 'package:stream_transform/stream_transform.dart';
part 'news_event.dart';
part 'news_state.dart';

const _pageLimit = 20;

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

/// NewsBloc class to manage [NewsEvent] and [NewsState]
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsApiClient httpClient;
  NewsBloc({required this.httpClient}) : super(const NewsState()) {
    on<FetchNews>(
      _onNewsFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  /// when news fetched
  /// [event] the news event
  /// [emit] emit the new event
  Future<void> _onNewsFetched(
    FetchNews event,
    Emitter<NewsState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == NewsStatus.initial) {
        final news =
            await httpClient.fetchNews(language: 'en', pageSize: _pageLimit);
        //state.news.articles.addAll(news.articles);
        return emit(state.copyWith(
          status: NewsStatus.success,
          news: news,
          hasReachedMax: false,
        ));
      }
      final news = await httpClient.fetchNews(
          language: 'en',
          pageSize: _pageLimit,
          startIndex: (state.news.length ~/ _pageLimit));
      news.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: NewsStatus.success,
                news: List.of(state.news)..addAll(news),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: NewsStatus.failure));
    }
  }
}
