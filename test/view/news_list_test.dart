import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:newsapp/bloc/news_bloc.dart';
import 'package:newsapp/models/models.dart';
import 'package:newsapp/ui/views/news_list.dart';
import 'package:newsapp/ui/widgets/widgets.dart';

class MockNewsBloc extends MockBloc<NewsEvent, NewsState> implements NewsBloc {}

extension on WidgetTester {
  Future<void> pumpNewsList(NewsBloc newsBloc) {
    return pumpWidget(
      Material(
        child: MaterialApp(
          home: BlocProvider.value(
            value: newsBloc,
            child: const NewsList(),
          ),
        ),
      ),
    );
  }
}

void main() {
  final mockNews = List.generate(
      5, (index) => Articles(source: Source(id: '$index', name: '')));
  late NewsBloc newsBloc;

  setUp(() {
    newsBloc = MockNewsBloc();
  });
  group('NewsList', () {
    testWidgets(
        'renders CircularProgressIndicator '
        'when News status is initial', (tester) async {
      when(() => newsBloc.state).thenReturn(const NewsState());
      await tester.pumpNewsList(newsBloc);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  testWidgets(
      'renders 5 News and a bottom loader when news max is not reached yet',
      (tester) async {
    when(() => newsBloc.state).thenReturn(NewsState(
      status: NewsStatus.success,
      news: mockNews,
    ));
    await tester.pumpNewsList(newsBloc);
    expect(find.byType(NewsListItem), findsNWidgets(5));
    expect(find.byType(Loader), findsOneWidget);
  });

  testWidgets('does not render bottom loader when news max is reached',
      (tester) async {
    when(() => newsBloc.state).thenReturn(NewsState(
      status: NewsStatus.success,
      news: mockNews,
      hasReachedMax: true,
    ));
    await tester.pumpNewsList(newsBloc);
    expect(find.byType(Loader), findsNothing);
  });

  testWidgets('fetches more news when scrolled to the bottom', (tester) async {
    when(() => newsBloc.state).thenReturn(
      NewsState(
        status: NewsStatus.success,
        news: List.generate(
          10,
          (i) => Articles(source: Source(id: '$i', name: '')),
        ),
      ),
    );
    await tester.pumpNewsList(newsBloc);
    await tester.drag(find.byType(NewsList), const Offset(0, -500));
    verify(() => newsBloc.add(FetchNews())).called(1);
  });
}
