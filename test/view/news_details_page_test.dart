import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:newsapp/generated/l10n.dart';
import 'package:newsapp/models/models.dart';
import 'package:newsapp/ui/views/news_details_page.dart';

void main() {
  group('NewsPage', () {
    testWidgets('render en NewsDetailsPage', (tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Localizations(
              delegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
              locale: const Locale('en'),
              child: const NewsDetailsPage(
                articles: Articles(source: Source()),
              ))));
      await tester.pumpAndSettle();
      expect(find.byType(NewsDetailsPage), findsOneWidget);
    });

    testWidgets('render ar NewsDetilsPage', (tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Localizations(
              delegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
              locale: const Locale('ar'),
              child: const NewsDetailsPage(
                articles: Articles(source: Source()),
              ))));
      await tester.pumpAndSettle();
      expect(find.byType(NewsDetailsPage), findsOneWidget);
    });
  });
}
