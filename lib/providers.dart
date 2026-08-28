import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/database.dart';
import 'data/export_service.dart';
import 'data/repository.dart';
import 'domain/models.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository(ref.watch(databaseProvider));
});

final appLanguagePreferenceProvider = StreamProvider<AppLanguagePreference>((
  ref,
) {
  return ref.watch(settingsRepositoryProvider).watchLanguagePreference();
});

final teamRepositoryProvider = Provider<TeamRepository>((ref) {
  return TeamRepository(ref.watch(databaseProvider));
});

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return EventRepository(
    ref.watch(databaseProvider),
    ref.watch(teamRepositoryProvider),
  );
});

final gameRepositoryProvider = Provider<GameRepository>((ref) {
  return GameRepository(
    ref.watch(databaseProvider),
    ref.watch(eventRepositoryProvider),
  );
});

final exportServiceProvider = Provider<ExportService>((ref) {
  return ExportService(
    ref.watch(databaseProvider),
    ref.watch(gameRepositoryProvider),
  );
});

final teamsProvider = StreamProvider<List<Team>>((ref) {
  return ref.watch(teamRepositoryProvider).watchTeams();
});

final playersProvider = StreamProvider.family<List<Player>, String>((
  ref,
  teamId,
) {
  return ref.watch(teamRepositoryProvider).watchPlayers(teamId);
});

final eventsProvider = StreamProvider<List<CompetitionEvent>>((ref) {
  return ref.watch(eventRepositoryProvider).watchEvents();
});

final eventBundleProvider = StreamProvider.family<EventBundle, String>((
  ref,
  eventId,
) {
  return ref.watch(eventRepositoryProvider).watchEventBundle(eventId);
});

final gamesProvider = StreamProvider<List<Game>>((ref) {
  return ref.watch(gameRepositoryProvider).watchGames();
});

final gameBundleProvider = StreamProvider.family<GameBundle, String>((
  ref,
  gameId,
) {
  return ref.watch(gameRepositoryProvider).watchGameBundle(gameId);
});

final teamStatsProvider =
    StreamProvider.family<Map<String, PlayerStats>, String>((ref, teamId) {
      return ref.watch(gameRepositoryProvider).watchTeamStats(teamId);
    });

final selectedGameIdProvider = StreamProvider<String?>((ref) {
  return ref.watch(gameRepositoryProvider).watchSelectedGameId();
});
