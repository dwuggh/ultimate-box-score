import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/app_error.dart';
import '../domain/models.dart';
import '../domain/recording.dart';
import '../l10n/app_localizations.dart';
import '../providers.dart';

extension LocalizedLabels on AppLocalizations {
  String teamTypeLabel(TeamType value) => switch (value) {
    TeamType.mixed => teamTypeMixed,
    TeamType.single => teamTypeSingle,
  };

  String genderLabel(PlayerGender value) => switch (value) {
    PlayerGender.male => genderMale,
    PlayerGender.female => genderFemale,
  };

  String positionLabel(PlayerPosition value) => switch (value) {
    PlayerPosition.cutter => positionCutter,
    PlayerPosition.handler => positionHandler,
    PlayerPosition.any => positionAny,
  };

  String modeLabel(PossessionMode value) => switch (value) {
    PossessionMode.offense => offense,
    PossessionMode.defense => defense,
  };

  String ratioLabel(GenderRatio value) => switch (value) {
    GenderRatio.fourMale => ratioFourMale,
    GenderRatio.fourFemale => ratioFourFemale,
  };

  String gameStatusLabel(GameStatus value) => switch (value) {
    GameStatus.draft => gameStatusDraft,
    GameStatus.inProgress => gameStatusInProgress,
    GameStatus.completed => gameStatusCompleted,
  };

  String lineupWarningLabel(LineupWarning warning) => switch (warning.kind) {
    LineupWarningKind.playerCount => lineupCountWarning(warning.playerCount!),
    LineupWarningKind.genderRatio => genderRatioWarning(
      warning.maleCount!,
      warning.femaleCount!,
      warning.expectedMale!,
      warning.expectedFemale!,
    ),
  };
}

String playerLabel(AppLocalizations strings, GamePlayerSnapshot? player) {
  if (player == null) return strings.unknownPlayer;
  final number = player.number;
  return number == null ? player.name : '#$number ${player.name}';
}

String participantLabel(
  AppLocalizations strings,
  GameBundle bundle,
  String? participantId,
) {
  if (participantId == null) return '—';
  final participant = bundle.participant(participantId);
  if (participant == null || participant.unknown) return strings.unknownPlayer;
  return playerLabel(strings, bundle.participantSnapshot(participantId));
}

String opponentLabel(AppLocalizations strings, String name) {
  return name.isEmpty ? strings.unnamedOpponent : name;
}

String errorMessage(AppLocalizations strings, Object error) {
  if (error is! AppException) return strings.unexpectedError;
  return switch (error.code) {
    AppErrorCode.teamNameRequired => strings.errorTeamNameRequired,
    AppErrorCode.playerNameRequired => strings.errorPlayerNameRequired,
    AppErrorCode.teamNotFound => strings.errorTeamNotFound,
    AppErrorCode.eventNameRequired => strings.errorEventNameRequired,
    AppErrorCode.eventEndBeforeStart => strings.errorEventEndBeforeStart,
    AppErrorCode.invalidTeam => strings.errorInvalidTeam,
    AppErrorCode.eventTeamLocked => strings.errorEventTeamLocked,
    AppErrorCode.eventNotFound => strings.errorEventNotFound,
    AppErrorCode.eventRosterWrongTeam => strings.errorEventRosterWrongTeam,
    AppErrorCode.lineNameRequired => strings.errorLineNameRequired,
    AppErrorCode.linePlayersOutsideRoster =>
      strings.errorLinePlayersOutsideRoster,
    AppErrorCode.duplicateLineName => strings.errorDuplicateLineName,
    AppErrorCode.eventWithGamesCannotDelete =>
      strings.errorEventWithGamesCannotDelete,
    AppErrorCode.eventTeamNotFound => strings.errorEventTeamNotFound,
    AppErrorCode.archivedEventCannotCreateGame =>
      strings.errorArchivedEventCannotCreateGame,
    AppErrorCode.startedGameImmutable => strings.errorStartedGameImmutable,
    AppErrorCode.gameNotDraft => strings.errorGameNotDraft,
    AppErrorCode.anotherGameActive => strings.errorAnotherGameActive(
      error.arguments['teamName']! as String,
      opponentLabel(strings, error.arguments['opponentName']! as String),
    ),
    AppErrorCode.eventRosterEmpty => strings.errorEventRosterEmpty,
    AppErrorCode.cannotStartPoint => strings.errorCannotStartPoint,
    AppErrorCode.cannotStartHalftime => strings.errorCannotStartHalftime,
    AppErrorCode.notInHalftime => strings.errorNotInHalftime,
    AppErrorCode.noScoringHolder => strings.errorNoScoringHolder,
    AppErrorCode.gameAlreadyActive => strings.errorGameAlreadyActive,
    AppErrorCode.onlyCompletedGameCanReopen =>
      strings.errorOnlyCompletedGameCanReopen,
    AppErrorCode.targetMustExceedScore => strings.errorTargetMustExceedScore,
    AppErrorCode.actionNotAllowed => strings.errorActionNotAllowed,
    AppErrorCode.noActivePoint => strings.errorNoActivePoint,
    AppErrorCode.actorNotInLineup => strings.errorActorNotInLineup,
    AppErrorCode.targetNotInLineup => strings.errorTargetNotInLineup,
    AppErrorCode.samePasserReceiver => strings.errorSamePasserReceiver,
    AppErrorCode.gameNotFound => strings.errorGameNotFound,
    AppErrorCode.gameNotInProgress => strings.errorGameNotInProgress,
    AppErrorCode.capMustBePositive => strings.errorCapMustBePositive,
    AppErrorCode.softCapAfterTotalCap => strings.errorSoftCapAfterTotalCap,
    AppErrorCode.targetMustBePositive => strings.errorTargetMustBePositive,
  };
}

class EmptyState extends StatelessWidget {
  const EmptyState({required this.icon, required this.message, super.key});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: Theme.of(context).colorScheme.outline),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorState extends StatelessWidget {
  const ErrorState(this.error, {super.key});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return EmptyState(
      icon: Icons.error_outline,
      message: error is AppException
          ? errorMessage(strings, error)
          : strings.loadFailed,
    );
  }
}

class StatsTable extends StatelessWidget {
  const StatsTable({required this.stats, required this.nameForId, super.key});

  final Map<String, PlayerStats> stats;
  final String Function(String id) nameForId;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    if (stats.isEmpty) {
      return EmptyState(
        icon: Icons.table_chart_outlined,
        message: strings.noStats,
      );
    }
    final entries = stats.entries.toList()
      ..sort((a, b) => nameForId(a.key).compareTo(nameForId(b.key)));
    return Scrollbar(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text(strings.player)),
            DataColumn(numeric: true, label: Text(strings.pointsPlayed)),
            DataColumn(numeric: true, label: Text(strings.goals)),
            DataColumn(numeric: true, label: Text(strings.assists)),
            DataColumn(numeric: true, label: Text(strings.defensiveBlocks)),
            DataColumn(numeric: true, label: Text(strings.turnovers)),
            DataColumn(numeric: true, label: Text(strings.touches)),
            DataColumn(numeric: true, label: Text(strings.catches)),
            DataColumn(numeric: true, label: Text(strings.throws)),
            DataColumn(numeric: true, label: Text(strings.receiverDrops)),
            DataColumn(numeric: true, label: Text(strings.passerTurnovers)),
          ],
          rows: [
            for (final entry in entries)
              DataRow(
                cells: [
                  DataCell(Text(nameForId(entry.key))),
                  DataCell(Text('${entry.value.pointsPlayed}')),
                  DataCell(Text('${entry.value.goals}')),
                  DataCell(Text('${entry.value.assists}')),
                  DataCell(Text('${entry.value.ds}')),
                  DataCell(Text('${entry.value.turnovers}')),
                  DataCell(Text('${entry.value.touches}')),
                  DataCell(Text('${entry.value.catches}')),
                  DataCell(Text('${entry.value.throws}')),
                  DataCell(Text('${entry.value.receiverDrops}')),
                  DataCell(Text('${entry.value.passerTurnovers}')),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

Future<bool> confirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String? confirmLabel,
  bool destructive = false,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) {
          final strings = AppLocalizations.of(context);
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(strings.cancel),
              ),
              FilledButton(
                style: destructive
                    ? FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error,
                      )
                    : null,
                onPressed: () => Navigator.pop(context, true),
                child: Text(confirmLabel ?? strings.confirm),
              ),
            ],
          );
        },
      ) ??
      false;
}

void showError(BuildContext context, Object error) {
  final strings = AppLocalizations.of(context);
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(errorMessage(strings, error))));
}

Future<void> runExport(
  BuildContext context,
  WidgetRef ref,
  ExportScope scope,
) async {
  try {
    final strings = AppLocalizations.of(context);
    final delivered = await ref
        .read(exportServiceProvider)
        .buildAndDeliver(scope, shareTitle: strings.exportShareTitle);
    if (context.mounted && delivered) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(strings.exportGenerated)));
    }
  } catch (error) {
    if (context.mounted) showError(context, error);
  }
}

class ExportAllButton extends ConsumerWidget {
  const ExportAllButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    return IconButton(
      tooltip: strings.exportAllData,
      onPressed: () => runExport(context, ref, const ExportScope.all()),
      icon: const Icon(Icons.ios_share),
    );
  }
}
