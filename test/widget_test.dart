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
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('队伍'), findsWidgets);
    expect(find.text('比赛'), findsOneWidget);
    expect(find.text('统计'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.event_note_outlined));
    await tester.pumpAndSettle();
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('还没有活动。先创建活动，再配置阵容、阵线和比赛。'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.query_stats_outlined));
    await tester.pumpAndSettle();
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('还没有可显示的比赛。请先在“比赛”页创建活动和比赛。'), findsOneWidget);
  });

  testWidgets('opens the team creation flow', (tester) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    await tester.tap(find.text('添加队伍'));
    await tester.pumpAndSettle();

    expect(find.text('队伍名称'), findsOneWidget);
    expect(find.text('混合组'), findsOneWidget);
    expect(find.text('单一性别组'), findsOneWidget);
  });
}
