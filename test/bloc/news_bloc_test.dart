import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:newsapp/bloc/news_bloc.dart';
import 'package:newsapp/client/news_api_client.dart';
import 'package:newsapp/models/models.dart';

class MockClient extends Mock implements NewsApiClient {}

void main() {
  group('NewsBloc', () {
    const mockNews = [Articles(source: Source())];
    const extraMockNews = [Articles(source: Source())];
    late NewsApiClient httpClient;

    setUpAll(() {
      registerFallbackValue(Uri());
    });
    setUp(() {
      httpClient = MockClient();
    });
    test('initial state is NewsState()', () {
      expect(NewsBloc(httpClient: httpClient).state, const NewsState());
    });

    group('NewsFetched', () {
      blocTest<NewsBloc, NewsState>(
        'emits nothing when news has reached maximum amount',
        build: () => NewsBloc(httpClient: httpClient),
        seed: () => const NewsState(hasReachedMax: true),
        act: (bloc) => bloc.add(FetchNews()),
        expect: () => <NewsState>[],
      );
    });

    blocTest<NewsBloc, NewsState>(
      'emits successful status when http fetches initial News',
      setUp: () {
        when(() => httpClient.fetchNews(language: 'en', pageSize: 20))
            .thenAnswer((_) async {
          return [const Articles(source: Source())];
        });
      },
      build: () => NewsBloc(httpClient: httpClient),
      act: (bloc) => bloc.add(FetchNews()),
      expect: () => const <NewsState>[
        NewsState(
          status: NewsStatus.success,
          news: mockNews,
          hasReachedMax: false,
        )
      ],
      verify: (_) {
        verify(() => httpClient.fetchNews(
            startIndex: 0, pageSize: 20, language: 'en')).called(1);
      },
    );

    blocTest<NewsBloc, NewsState>(
      'throttles events',
      setUp: () {
        when(() => httpClient.fetchNews(language: 'en', pageSize: 20))
            .thenAnswer((_) async {
          return [const Articles(source: Source())];
        });
      },
      build: () => NewsBloc(httpClient: httpClient),
      act: (bloc) async {
        bloc.add(FetchNews());
        await Future<void>.delayed(Duration.zero);
        bloc.add(FetchNews());
      },
      expect: () => const <NewsState>[
        NewsState(
          status: NewsStatus.success,
          news: mockNews,
          hasReachedMax: false,
        )
      ],
      verify: (_) {
        verify(() => httpClient.fetchNews(
            language: 'en', startIndex: 0, pageSize: 20)).called(1);
      },
    );

    blocTest<NewsBloc, NewsState>(
      'emits failure status when http fetches news and throw exception',
      setUp: () {
        when(() => httpClient.fetchNews(language: 'en', pageSize: 20))
            .thenAnswer((_) async {
          return throw Exception('error fetching news');
        });
      },
      build: () => NewsBloc(httpClient: httpClient),
      act: (bloc) => bloc.add(FetchNews()),
      expect: () => <NewsState>[const NewsState(status: NewsStatus.failure)],
      verify: (_) {
        verify(() => httpClient.fetchNews(language: 'en', pageSize: 20))
            .called(1);
      },
    );

    blocTest<NewsBloc, NewsState>(
      'emits successful status and reaches max news when '
      '0 additional posts are fetched',
      setUp: () {
        when(() => httpClient.fetchNews(language: 'en', pageSize: 20))
            .thenAnswer((_) async {
          return [];
        });
      },
      build: () => NewsBloc(httpClient: httpClient),
      seed: () => const NewsState(
        status: NewsStatus.success,
        news: mockNews,
      ),
      act: (bloc) => bloc.add(FetchNews()),
      expect: () => const <NewsState>[
        NewsState(
          status: NewsStatus.success,
          news: mockNews,
          hasReachedMax: true,
        )
      ],
      verify: (_) {
        verify(() => httpClient.fetchNews(language: 'en', pageSize: 20))
            .called(1);
      },
    );

    blocTest<NewsBloc, NewsState>(
      'emits successful status and does not reach max news'
      'when additional posts are fetched',
      setUp: () {
        when(() => httpClient.fetchNews(language: 'en', pageSize: 20))
            .thenAnswer((_) async {
          return [const Articles(source: Source())];
        });
      },
      build: () => NewsBloc(httpClient: httpClient),
      seed: () => const NewsState(
        status: NewsStatus.success,
        news: mockNews,
      ),
      act: (bloc) => bloc.add(FetchNews()),
      expect: () => const <NewsState>[
        NewsState(
          status: NewsStatus.success,
          news: [...mockNews, ...extraMockNews],
          hasReachedMax: false,
        )
      ],
      verify: (_) {
        verify(() => httpClient.fetchNews(language: 'en', pageSize: 20))
            .called(1);
      },
    );
  });
}
