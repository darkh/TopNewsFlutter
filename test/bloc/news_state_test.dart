import 'package:flutter_test/flutter_test.dart';
import 'package:newsapp/bloc/news_bloc.dart';

void main() {
  group('NewsState', () {
    test('supports value comparison', () {
      expect(const NewsState(), const NewsState());
      expect(
        const NewsState().toString(),
        const NewsState().toString(),
      );
    });
  });
}
