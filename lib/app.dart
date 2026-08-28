import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'domain/models.dart';
import 'l10n/app_localizations.dart';
import 'providers.dart';
import 'ui/game_screens.dart';
import 'ui/home_screen.dart';
import 'ui/recording_screen.dart';
import 'ui/settings_screen.dart';
import 'ui/team_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/team',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/team',
                builder: (context, state) => const TeamHomeScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) =>
                        TeamScreen(teamId: state.pathParameters['id']!),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/games',
                builder: (context, state) => const EventListScreen(),
                routes: [
                  GoRoute(
                    path: 'event/:id',
                    builder: (context, state) =>
                        EventDetailScreen(eventId: state.pathParameters['id']!),
                  ),
                  GoRoute(
                    path: 'event/:eventId/game/new',
                    builder: (context, state) => GameEditorScreen(
                      eventId: state.pathParameters['eventId']!,
                    ),
                  ),
                  GoRoute(
                    path: 'game/:id/edit',
                    builder: (context, state) =>
                        GameEditorScreen(gameId: state.pathParameters['id']!),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/stats',
                builder: (context, state) => const StatsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

class UltimateBoxScoreApp extends ConsumerWidget {
  const UltimateBoxScoreApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final language =
        ref.watch(appLanguagePreferenceProvider).valueOrNull ??
        AppLanguagePreference.system;
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      locale: switch (language) {
        AppLanguagePreference.system => null,
        AppLanguagePreference.english => const Locale('en'),
        AppLanguagePreference.simplifiedChinese => const Locale('zh'),
      },
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff006a61),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        cardTheme: const CardThemeData(margin: EdgeInsets.zero),
      ),
      routerConfig: router,
    );
  }
}
