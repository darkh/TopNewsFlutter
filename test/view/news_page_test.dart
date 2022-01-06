import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:newsapp/generated/l10n.dart';
import 'package:newsapp/ui/views/views.dart';

void main() {
  group('NewsPage', () {
    testWidgets('render en NewsList', (tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Localizations(delegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ], locale: const Locale('en'), child: const NewsPage())));
      await tester.pumpAndSettle();
      expect(find.byType(NewsList), findsOneWidget);
    });

    testWidgets('render ar NewsList', (tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Localizations(delegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ], locale: const Locale('ar'), child: const NewsPage())));
      await tester.pumpAndSettle();
      expect(find.byType(NewsList), findsOneWidget);
    });
  });
}
