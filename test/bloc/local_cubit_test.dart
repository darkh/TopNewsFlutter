import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:newsapp/bloc/local_cubit.dart';

class MockLang extends Mock implements LocalCubit {}

void main() {
  group('LocalCubit', () {
    late LocalCubit localCubit;

    setUp(() {
      localCubit = MockLang();
    });

    blocTest<LocalCubit, Locale>('emit for secssfull task load',
        build: () => localCubit,
        act: (cubit) => cubit.changeStartLang(),
        verify: (_) {
          verify(() => localCubit.changeStartLang()).called(1);
        });

    tearDown(() {
      localCubit.close();
    });
  });
}
