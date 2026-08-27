import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ultimate_box_score/app.dart';
import 'package:ultimate_box_score/domain/models.dart';
import 'package:ultimate_box_score/providers.dart';

void main() {
  Widget app() {
    return ProviderScope(
      overrides: [
        teamsProvider.overrideWith((ref) => Stream.value(const <Team>[])),
        eventsProvider.overrideWith(
          (ref) => Stream.value(const <CompetitionEvent>[]),
        ),
        gamesProvider.overrideWith((ref) => Stream.value(const <Game>[])),
        selectedGameIdProvider.overrideWith((ref) => Stream.value(null)),
      ],
      child: const UltimateBoxScoreApp(),
    );
  }

  testWidgets('keeps the three-page dock visible while switching pages', (
    tester,
  ) async {
    tester.binding.platformDispatcher.localesTestValue = const [Locale('en')];
    addTearDown(tester.binding.platformDispatcher.clearLocalesTestValue);
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Teams'), findsWidgets);
    expect(find.text('Games'), findsOneWidget);
    expect(find.text('Stats'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.event_note_outlined));
    await tester.pumpAndSettle();
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(
      find.text(
        'No events yet. Create an event, then configure its roster, lines, and games.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.byIcon(Icons.query_stats_outlined));
    await tester.pumpAndSettle();
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('No games yet.'), findsOneWidget);
  });

  testWidgets('opens the team creation flow', (tester) async {
    tester.binding.platformDispatcher.localesTestValue = const [Locale('zh')];
    addTearDown(tester.binding.platformDispatcher.clearLocalesTestValue);
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    await tester.tap(find.text('添加队伍'));
    await tester.pumpAndSettle();

    expect(find.text('队伍名称'), findsOneWidget);
    expect(find.text('混合组'), findsOneWidget);
    expect(find.text('单一性别组'), findsOneWidget);
  });

  testWidgets('falls back to English for unsupported device locales', (
    tester,
  ) async {
    tester.binding.platformDispatcher.localesTestValue = const [Locale('fr')];
    addTearDown(tester.binding.platformDispatcher.clearLocalesTestValue);

    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.text('Teams'), findsWidgets);
    expect(find.text('Add team'), findsOneWidget);
  });
}
