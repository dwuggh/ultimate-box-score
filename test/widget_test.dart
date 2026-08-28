import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ultimate_box_score/app.dart';
import 'package:ultimate_box_score/data/database.dart';
import 'package:ultimate_box_score/data/repository.dart';
import 'package:ultimate_box_score/domain/models.dart';
import 'package:ultimate_box_score/providers.dart';

void main() {
  late _FakeSettingsRepository settings;

  setUp(() {
    settings = _FakeSettingsRepository(AppDatabase(NativeDatabase.memory()));
  });

  tearDown(() => settings.close());

  Widget app() {
    return ProviderScope(
      overrides: [
        settingsRepositoryProvider.overrideWithValue(settings),
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

  testWidgets('keeps the four-page dock visible while switching pages', (
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
    expect(find.text('Settings'), findsOneWidget);

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

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Language'), findsOneWidget);
    expect(find.text('System default'), findsOneWidget);
  });

  testWidgets('language selection applies immediately and can follow system', (
    tester,
  ) async {
    tester.binding.platformDispatcher.localesTestValue = const [Locale('en')];
    addTearDown(tester.binding.platformDispatcher.clearLocalesTestValue);
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    await tester.tap(find.text('System default'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('简体中文').last);
    await tester.pumpAndSettle();

    expect(find.text('设置'), findsWidgets);
    expect(find.text('语言'), findsOneWidget);
    expect(find.text('队伍'), findsOneWidget);

    await tester.tap(find.text('简体中文'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('跟随系统').last);
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsWidgets);
    expect(find.text('Language'), findsOneWidget);
    expect(find.text('Teams'), findsOneWidget);
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

class _FakeSettingsRepository extends SettingsRepository {
  _FakeSettingsRepository(super.database);

  final _changes = StreamController<AppLanguagePreference>.broadcast();
  AppLanguagePreference _language = AppLanguagePreference.system;

  @override
  Stream<AppLanguagePreference> watchLanguagePreference() async* {
    yield _language;
    yield* _changes.stream;
  }

  @override
  Future<void> setLanguagePreference(AppLanguagePreference preference) async {
    _language = preference;
    _changes.add(preference);
  }

  Future<void> close() async {
    await _changes.close();
    await database.close();
  }
}
