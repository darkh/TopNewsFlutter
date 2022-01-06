import 'package:flutter_test/flutter_test.dart';
import 'package:newsapp/bloc/news_bloc.dart';

void main() {
  group('NewsEvent', () {
    group('FetchNews', () {
      test('supports value comparison', () {
        expect(FetchNews(), FetchNews());
      });
    });
  });
}
