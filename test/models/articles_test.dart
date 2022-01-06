import 'package:flutter_test/flutter_test.dart';
import 'package:newsapp/models/models.dart';

void main() {
  group('Artcles', () {
    test('supports value comparison', () {
      expect(const Articles(source: Source(id: '', name: '')),
          const Articles(source: Source(id: '', name: '')));
    });
  });
}
