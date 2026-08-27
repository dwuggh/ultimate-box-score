import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/app_error.dart';
import '../domain/models.dart';
import '../domain/recording.dart';
import '../l10n/app_localizations.dart';
import '../providers.dart';
import 'common.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    final gamesValue = ref.watch(gamesProvider);
    final events =
        ref.watch(eventsProvider).valueOrNull ?? const <CompetitionEvent>[];
    final selected = ref.watch(selectedGameIdProvider).valueOrNull;
    return gamesValue.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) => Scaffold(body: ErrorState(error)),
      data: (games) {
        final eventNames = {for (final event in events) event.id: event.name};
        final selectedGame = _selectedGame(games, selected);
        return Scaffold(
          appBar: AppBar(
            title: games.isEmpty
                ? Text(strings.stats)
                : DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedGame?.id,
                      isExpanded: true,
                      items: [
                        for (final game in games)
                          DropdownMenuItem(
                            value: game.id,
                            child: Text(
                              strings.gameOptionLabel(
                                eventNames[game.eventId] ?? strings.event,
                                game.teamName,
                                opponentLabel(strings, game.opponentName),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                      onChanged: (value) =>
                          ref.read(gameRepositoryProvider).selectGame(value),
                    ),
                  ),
            actions: const [ExportAllButton()],
          ),
          body: selectedGame == null
              ? EmptyState(
                  icon: Icons.query_stats_outlined,
                  message: strings.noGames,
                )
              : _SelectedGameView(gameId: selectedGame.id),
        );
      },
    );
  }

  Game? _selectedGame(List<Game> games, String? selected) {
    for (final game in games) {
      if (game.id == selected) return game;
    }
    for (final game in games) {
      if (game.status == GameStatus.inProgress) return game;
    }
    return games.isEmpty ? null : games.first;
  }
}

class _SelectedGameView extends ConsumerWidget {
  const _SelectedGameView({required this.gameId});

  final String gameId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(gameBundleProvider(gameId))
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => ErrorState(error),
          data: (bundle) => switch (bundle.game.status) {
            GameStatus.draft => _DraftGameView(bundle: bundle),
            GameStatus.inProgress => _LiveGameView(
              key: ValueKey(bundle.game.id),
              initialBundle: bundle,
            ),
            GameStatus.completed => _CompletedGameView(bundle: bundle),
          },
        );
  }
}

class _DraftGameView extends ConsumerWidget {
  const _DraftGameView({required this.bundle});

  final GameBundle bundle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    return ref
        .watch(eventBundleProvider(bundle.game.eventId))
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => ErrorState(error),
          data: (event) => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _ScoreCard(bundle: bundle),
              const SizedBox(height: 16),
              Text(
                strings.eventRoster,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final player in event.roster)
                        Chip(label: Text(_playerName(player))),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                strings.quickLines,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              if (event.lines.isEmpty)
                Text(strings.noConfiguredLines)
              else
                Wrap(
                  spacing: 8,
                  children: [
                    for (final line in event.lines)
                      Chip(
                        label: Text(
                          strings.linePlayerCount(
                            line.name,
                            line.memberPlayerIds.length,
                          ),
                        ),
                      ),
                  ],
                ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () async {
                  try {
                    await ref
                        .read(gameRepositoryProvider)
                        .startGame(bundle.game.id);
                  } catch (error) {
                    if (context.mounted) showError(context, error);
                  }
                },
                icon: const Icon(Icons.play_arrow),
                label: Text(strings.startGame),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () =>
                    context.go('/games/game/${bundle.game.id}/edit'),
                icon: const Icon(Icons.edit_outlined),
                label: Text(strings.editGameSettings),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () =>
                    runExport(context, ref, ExportScope.game(bundle.game.id)),
                icon: const Icon(Icons.ios_share),
                label: Text(strings.exportGameData),
              ),
            ],
          ),
        );
  }
}

class _CompletedGameView extends ConsumerWidget {
  const _CompletedGameView({required this.bundle});

  final GameBundle bundle;

  Future<void> _reopen(BuildContext context, WidgetRef ref) async {
    final target = bundle.game.maxPoints;
    final leader = bundle.state.ourScore > bundle.state.opponentScore
        ? bundle.state.ourScore
        : bundle.state.opponentScore;
    if (target != null && leader >= target) {
      final changed = await showMutableGameEditor(context, ref, bundle.game);
      if (!changed || !context.mounted) return;
      final updated = await ref
          .read(gameRepositoryProvider)
          .getGameBundle(bundle.game.id);
      if (updated.game.maxPoints != null && leader >= updated.game.maxPoints!) {
        if (context.mounted) {
          showError(
            context,
            const AppException(AppErrorCode.targetMustExceedScore),
          );
        }
        return;
      }
    }
    try {
      await ref.read(gameRepositoryProvider).reopenGame(bundle.game.id);
    } catch (error) {
      if (context.mounted) showError(context, error);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _ScoreCard(bundle: bundle),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilledButton.icon(
              onPressed: () => _reopen(context, ref),
              icon: const Icon(Icons.restart_alt),
              label: Text(strings.reopen),
            ),
            OutlinedButton.icon(
              onPressed: () => showMutableGameEditor(context, ref, bundle.game),
              icon: const Icon(Icons.tune),
              label: Text(strings.adjustGameSettings),
            ),
            OutlinedButton.icon(
              onPressed: () =>
                  runExport(context, ref, ExportScope.game(bundle.game.id)),
              icon: const Icon(Icons.ios_share),
              label: Text(strings.exportData),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          strings.playerStats,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        StatsTable(
          stats: bundle.state.stats,
          nameForId: (id) => _statsName(strings, bundle, id),
        ),
        const SizedBox(height: 24),
        Text(
          strings.pointEvents,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        SizedBox(height: 520, child: _TimelinePanel(bundle: bundle)),
      ],
    );
  }
}

class _LiveGameView extends ConsumerStatefulWidget {
  const _LiveGameView({required this.initialBundle, super.key});

  final GameBundle initialBundle;

  @override
  ConsumerState<_LiveGameView> createState() => _LiveGameViewState();
}

class _LiveGameViewState extends ConsumerState<_LiveGameView> {
  final _selectedRosterIds = <String>{};
  final _shownCaps = <String>{};
  Timer? _timer;
  var _busy = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _run(Future<void> Function() operation) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await operation();
    } catch (error) {
      if (mounted) showError(context, error);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _scheduleCapCheck(GameBundle bundle) {
    final strings = AppLocalizations.of(context);
    final startedAt = bundle.game.startedAt;
    if (startedAt == null) return;
    final elapsed = DateTime.now().difference(startedAt).inMinutes;
    final checks = [
      if (bundle.game.softCapMinutes case final minutes?)
        (
          'soft',
          minutes,
          bundle.game.softCapAcknowledged,
          strings.softCapReached,
        ),
      if (bundle.game.totalCapMinutes case final minutes?)
        (
          'total',
          minutes,
          bundle.game.totalCapAcknowledged,
          strings.totalCapReached,
        ),
    ];
    for (final check in checks) {
      if (elapsed < check.$2 || check.$3 || _shownCaps.contains(check.$1)) {
        continue;
      }
      _shownCaps.add(check.$1);
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!mounted) return;
        await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(check.$4),
            content: Text(strings.gameElapsed(check.$2)),
            actions: [
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: Text(strings.acknowledge),
              ),
            ],
          ),
        );
        await ref
            .read(gameRepositoryProvider)
            .acknowledgeCap(
              bundle.game.id,
              soft: check.$1 == 'soft',
              total: check.$1 == 'total',
            );
      });
    }
  }

  Future<GenderRatio?> _chooseFirstRatio() {
    final strings = AppLocalizations.of(context);
    return showDialog<GenderRatio>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(strings.chooseFirstRatio),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, GenderRatio.fourMale),
            child: Text(strings.ratioFourMale),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, GenderRatio.fourFemale),
            child: Text(strings.ratioFourFemale),
          ),
        ],
      ),
    );
  }

  Future<void> _startPoint(GameBundle bundle) async {
    final strings = AppLocalizations.of(context);
    final selected = bundle.roster
        .where((player) => _selectedRosterIds.contains(player.id))
        .toList();
    var firstRatio = bundle.game.firstRatio;
    if (bundle.game.isMixed && firstRatio == null) {
      firstRatio = RecordingRules.inferFirstRatio(selected);
      firstRatio ??= await _chooseFirstRatio();
      if (firstRatio == null || !mounted) return;
      await ref
          .read(gameRepositoryProvider)
          .updateFirstRatio(bundle.game.id, firstRatio);
    }
    final required = firstRatio == null
        ? null
        : RecordingRules.requiredRatio(
            firstRatio,
            bundle.state.completedPoints,
          );
    final warnings = RecordingRules.lineupWarnings(
      lineup: selected,
      requiredRatio: required,
    );
    if (!mounted) return;
    if (warnings.isNotEmpty) {
      final confirmed = await confirmDialog(
        context,
        title: strings.lineupWarningTitle,
        message: strings.lineupWarningPrompt(
          warnings.map(strings.lineupWarningLabel).join('\n'),
        ),
        confirmLabel: strings.startAnyway,
      );
      if (!confirmed) return;
    }
    await _run(() async {
      await ref
          .read(gameRepositoryProvider)
          .startPoint(bundle.game.id, _selectedRosterIds.toList());
      _selectedRosterIds.clear();
    });
  }

  void _applyLine(GameBundle bundle, LinePreset line) {
    final strings = AppLocalizations.of(context);
    final byPlayerId = {
      for (final player in bundle.roster) player.playerId: player,
    };
    final available = <String>{};
    final missing = <String>[];
    for (final playerId in line.memberPlayerIds) {
      final player = byPlayerId[playerId];
      if (player == null) {
        missing.add(playerId);
      } else {
        available.add(player.id);
      }
    }
    setState(() {
      _selectedRosterIds
        ..clear()
        ..addAll(available);
    });
    if (missing.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(strings.missingLinePlayers(missing.length))),
      );
    }
  }

  Future<void> _finish(GameBundle bundle) async {
    final strings = AppLocalizations.of(context);
    final confirmed = await confirmDialog(
      context,
      title: strings.finishGame,
      message: bundle.state.pointInProgress
          ? strings.finishCurrentPointMessage
          : strings.finishCompletedPointMessage,
      confirmLabel: strings.finishGame,
    );
    if (confirmed) {
      await _run(
        () => ref.read(gameRepositoryProvider).completeGame(bundle.game.id),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final bundleValue = ref.watch(
      gameBundleProvider(widget.initialBundle.game.id),
    );
    return bundleValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => ErrorState(error),
      data: (bundle) {
        _scheduleCapCheck(bundle);
        return Column(
          children: [
            _ScoreHeader(bundle: bundle),
            Material(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    IconButton(
                      tooltip: strings.undo,
                      onPressed:
                          _busy ||
                              !bundle.actions.any((action) => !action.voided)
                          ? null
                          : () => _run(
                              () => ref
                                  .read(gameRepositoryProvider)
                                  .undoLast(bundle.game.id),
                            ),
                      icon: const Icon(Icons.undo),
                    ),
                    IconButton(
                      tooltip: strings.adjustGameSettings,
                      onPressed: _busy
                          ? null
                          : () => showMutableGameEditor(
                              context,
                              ref,
                              bundle.game,
                            ),
                      icon: const Icon(Icons.tune),
                    ),
                    IconButton(
                      tooltip: strings.exportGameData,
                      onPressed: _busy
                          ? null
                          : () => runExport(
                              context,
                              ref,
                              ExportScope.game(bundle.game.id),
                            ),
                      icon: const Icon(Icons.ios_share),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: _busy ? null : () => _finish(bundle),
                      icon: const Icon(Icons.stop_circle_outlined),
                      label: Text(strings.finish),
                    ),
                  ],
                ),
              ),
            ),
            if (_busy) const LinearProgressIndicator(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final recorder = _stageBody(bundle);
                  if (constraints.maxWidth >= 900) {
                    return Row(
                      children: [
                        Expanded(child: recorder),
                        const VerticalDivider(width: 1),
                        SizedBox(
                          width: 380,
                          child: _TimelinePanel(bundle: bundle),
                        ),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      _RecentActionStrip(bundle: bundle),
                      Expanded(child: recorder),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _stageBody(GameBundle bundle) {
    return switch (bundle.state.stage) {
      RecordingStage.betweenPoints => _lineupView(bundle),
      RecordingStage.halftime => _halftimeView(bundle),
      RecordingStage.awaitingPickup ||
      RecordingStage.offense ||
      RecordingStage.defense => _participantView(bundle),
    };
  }

  Widget _lineupView(GameBundle bundle) {
    final strings = AppLocalizations.of(context);
    final ratio = bundle.game.firstRatio == null
        ? null
        : RecordingRules.requiredRatio(
            bundle.game.firstRatio!,
            bundle.state.completedPoints,
          );
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    strings.pointModeTitle(
                      bundle.state.nextPointNumber,
                      strings.modeLabel(bundle.state.nextPointMode),
                    ),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  if (bundle.game.isMixed)
                    Text(
                      ratio == null
                          ? strings.inferFirstRatio
                          : strings.abbaRatio(strings.ratioLabel(ratio)),
                    ),
                ],
              ),
            ),
            Text(strings.selectedPlayers(_selectedRosterIds.length)),
          ],
        ),
        if (bundle.lines.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final line in bundle.lines)
                ActionChip(
                  avatar: const Icon(Icons.bolt, size: 18),
                  label: Text(
                    strings.linePlayerCount(
                      line.name,
                      line.memberPlayerIds.length,
                    ),
                  ),
                  onPressed: _busy ? null : () => _applyLine(bundle, line),
                ),
            ],
          ),
        ],
        const SizedBox(height: 12),
        for (final player in bundle.roster)
          CheckboxListTile(
            value: _selectedRosterIds.contains(player.id),
            title: Text(playerLabel(strings, player)),
            subtitle: Text(
              '${strings.genderLabel(player.gender)} · '
              '${strings.positionLabel(player.position)}',
            ),
            onChanged: _busy
                ? null
                : (value) => setState(() {
                    if (value ?? false) {
                      _selectedRosterIds.add(player.id);
                    } else {
                      _selectedRosterIds.remove(player.id);
                    }
                  }),
          ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: _busy ? null : () => _startPoint(bundle),
          icon: const Icon(Icons.play_arrow),
          label: Text(strings.startPoint),
        ),
        if (!bundle.state.halftimeTaken) ...[
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _busy
                ? null
                : () => _run(
                    () => ref
                        .read(gameRepositoryProvider)
                        .startHalftime(bundle.game.id),
                  ),
            icon: const Icon(Icons.pause_circle_outline),
            label: Text(strings.halftime),
          ),
        ],
      ],
    );
  }

  Widget _halftimeView(GameBundle bundle) {
    final strings = AppLocalizations.of(context);
    return Center(
      child: FilledButton.icon(
        onPressed: _busy
            ? null
            : () => _run(
                () => ref
                    .read(gameRepositoryProvider)
                    .endHalftime(bundle.game.id),
              ),
        icon: const Icon(Icons.play_arrow),
        label: Text(strings.endHalftime),
      ),
    );
  }

  Widget _participantView(GameBundle bundle) {
    final strings = AppLocalizations.of(context);
    final state = bundle.state;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(switch (state.stage) {
          RecordingStage.awaitingPickup => strings.selectPickupPlayer,
          RecordingStage.offense => strings.ourOffense,
          RecordingStage.defense => strings.ourDefense,
          _ => '',
        }, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        for (final participantId in state.currentParticipants) ...[
          _ParticipantCard(
            bundle: bundle,
            participantId: participantId,
            busy: _busy,
            run: _run,
          ),
          const SizedBox(height: 8),
        ],
        if (state.stage == RecordingStage.defense) ...[
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _busy
                ? null
                : () => _run(
                    () => ref
                        .read(gameRepositoryProvider)
                        .recordOpponentThrowaway(bundle.game.id),
                  ),
            icon: const Icon(Icons.swap_horiz),
            label: Text(strings.opponentThrowaway),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: _busy
                ? null
                : () => _run(
                    () => ref
                        .read(gameRepositoryProvider)
                        .recordOpponentGoal(bundle.game.id),
                  ),
            icon: const Icon(Icons.flag),
            label: Text(strings.opponentGoal),
          ),
        ],
      ],
    );
  }
}

class _ParticipantCard extends ConsumerWidget {
  const _ParticipantCard({
    required this.bundle,
    required this.participantId,
    required this.busy,
    required this.run,
  });

  final GameBundle bundle;
  final String participantId;
  final bool busy;
  final Future<void> Function(Future<void> Function()) run;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    final state = bundle.state;
    final holder = state.holderParticipantId == participantId;
    final repository = ref.read(gameRepositoryProvider);
    return Card(
      color: holder ? Theme.of(context).colorScheme.primaryContainer : null,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    participantLabel(strings, bundle, participantId),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (holder) Chip(label: Text(strings.holder)),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: switch (state.stage) {
                RecordingStage.awaitingPickup => [
                  FilledButton.tonal(
                    onPressed: busy
                        ? null
                        : () => run(
                            () => repository.recordPickup(
                              bundle.game.id,
                              participantId,
                            ),
                          ),
                    child: Text(strings.pickup),
                  ),
                ],
                RecordingStage.offense when holder => [
                  OutlinedButton(
                    onPressed: busy
                        ? null
                        : () => run(
                            () =>
                                repository.recordPasserTurnover(bundle.game.id),
                          ),
                    child: Text(strings.passerTurnover),
                  ),
                  FilledButton(
                    onPressed: busy
                        ? null
                        : () => run(
                            () => repository.confirmHolderGoal(bundle.game.id),
                          ),
                    child: Text(strings.goal),
                  ),
                ],
                RecordingStage.offense => [
                  OutlinedButton(
                    onPressed: busy
                        ? null
                        : () => run(
                            () => repository.recordPass(
                              bundle.game.id,
                              participantId,
                            ),
                          ),
                    child: Text(strings.catchAction),
                  ),
                  OutlinedButton(
                    onPressed: busy
                        ? null
                        : () => run(
                            () => repository.recordReceiverDrop(
                              bundle.game.id,
                              participantId,
                            ),
                          ),
                    child: Text(strings.receiverDrop),
                  ),
                  FilledButton(
                    onPressed: busy
                        ? null
                        : () => run(
                            () => repository.recordGoalCatch(
                              bundle.game.id,
                              participantId,
                            ),
                          ),
                    child: Text(strings.catchGoal),
                  ),
                ],
                RecordingStage.defense => [
                  FilledButton.tonal(
                    onPressed: busy
                        ? null
                        : () => run(
                            () => repository.recordDefensiveBlock(
                              bundle.game.id,
                              participantId,
                            ),
                          ),
                    child: Text(strings.defensiveBlock),
                  ),
                ],
                _ => const <Widget>[],
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ScoreHeader extends StatelessWidget {
  const _ScoreHeader({required this.bundle});

  final GameBundle bundle;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final elapsed = bundle.game.startedAt == null
        ? Duration.zero
        : DateTime.now().difference(bundle.game.startedAt!);
    final time =
        '${elapsed.inHours.toString().padLeft(2, '0')}:'
        '${(elapsed.inMinutes % 60).toString().padLeft(2, '0')}:'
        '${(elapsed.inSeconds % 60).toString().padLeft(2, '0')}';
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${bundle.game.teamName}  ${bundle.state.ourScore}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Column(
              children: [
                Text(time, style: Theme.of(context).textTheme.labelLarge),
                Text(
                  strings.modeLabel(
                    bundle.state.currentMode ?? bundle.state.nextPointMode,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Text(
                '${bundle.state.opponentScore}  '
                '${opponentLabel(strings, bundle.game.opponentName)}',
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScoreCard extends StatelessWidget {
  const _ScoreCard({required this.bundle});

  final GameBundle bundle;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              '${bundle.state.ourScore}  :  ${bundle.state.opponentScore}',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              strings.versusLabel(
                bundle.game.teamName,
                opponentLabel(strings, bundle.game.opponentName),
              ),
            ),
            const SizedBox(height: 8),
            Text(strings.gameStatusLabel(bundle.game.status)),
          ],
        ),
      ),
    );
  }
}

class _RecentActionStrip extends StatelessWidget {
  const _RecentActionStrip({required this.bundle});

  final GameBundle bundle;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final active = bundle.actions.where((action) => !action.voided).toList();
    final latest = active.isEmpty ? null : active.last;
    return Material(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: ListTile(
        dense: true,
        leading: const Icon(Icons.timeline),
        title: Text(
          latest == null
              ? strings.noEventsRecorded
              : _actionLabel(strings, bundle, latest),
        ),
        trailing: const Icon(Icons.expand_less),
        onTap: () => showModalBottomSheet<void>(
          context: context,
          showDragHandle: true,
          isScrollControlled: true,
          builder: (context) => FractionallySizedBox(
            heightFactor: .75,
            child: _TimelinePanel(bundle: bundle),
          ),
        ),
      ),
    );
  }
}

class _TimelinePanel extends StatelessWidget {
  const _TimelinePanel({required this.bundle});

  final GameBundle bundle;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    if (bundle.actions.isEmpty) {
      return EmptyState(
        icon: Icons.timeline,
        message: strings.noEventsRecordedPeriod,
      );
    }
    final gameActions = bundle.actions.where(
      (action) => action.pointId == null,
    );
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        for (final action in gameActions)
          _ActionTile(bundle: bundle, action: action),
        for (final point in bundle.points)
          ExpansionTile(
            initiallyExpanded: point.id == bundle.state.currentPointId,
            title: Text(strings.pointNumber(point.number)),
            subtitle: Text(
              strings.peopleCount(
                bundle
                    .participantsForPoint(point.id)
                    .where((item) => !item.unknown)
                    .length,
              ),
            ),
            children: [
              for (final action in bundle.actions.where(
                (action) => action.pointId == point.id,
              ))
                _ActionTile(bundle: bundle, action: action),
            ],
          ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.bundle, required this.action});

  final GameBundle bundle;
  final RecordedAction action;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final startedAt = bundle.game.startedAt;
    final elapsed = startedAt == null
        ? Duration.zero
        : action.createdAt.difference(startedAt);
    final time =
        '${elapsed.inMinutes.toString().padLeft(2, '0')}:'
        '${(elapsed.inSeconds % 60).toString().padLeft(2, '0')}';
    return ListTile(
      dense: true,
      leading: Text(time),
      title: Text(
        _actionLabel(strings, bundle, action),
        style: action.voided
            ? const TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      ),
      subtitle: action.voided ? Text(strings.voided) : null,
    );
  }
}

String _actionLabel(
  AppLocalizations strings,
  GameBundle bundle,
  RecordedAction action,
) {
  final actor = participantLabel(strings, bundle, action.actorParticipantId);
  final target = participantLabel(strings, bundle, action.targetParticipantId);
  return switch (action.kind) {
    RecordedActionKind.startPoint => strings.actionStartPoint,
    RecordedActionKind.startHalftime => strings.actionStartHalftime,
    RecordedActionKind.endHalftime => strings.actionEndHalftime,
    RecordedActionKind.pickup => strings.actionPickup(actor),
    RecordedActionKind.completedPass => strings.actionCompletedPass(
      actor,
      target,
    ),
    RecordedActionKind.receiverDrop => strings.actionReceiverDrop(
      actor,
      target,
    ),
    RecordedActionKind.passerTurnover => strings.actionPasserTurnover(actor),
    RecordedActionKind.goalCatch => strings.actionGoalCatch(actor, target),
    RecordedActionKind.confirmGoal => strings.actionConfirmGoal(actor),
    RecordedActionKind.defensiveBlock => strings.actionDefensiveBlock(actor),
    RecordedActionKind.opponentThrowaway => strings.opponentThrowaway,
    RecordedActionKind.opponentGoal => strings.opponentGoal,
    RecordedActionKind.abandonPoint => strings.actionAbandonPoint,
  };
}

Future<bool> showMutableGameEditor(
  BuildContext context,
  WidgetRef ref,
  Game game,
) async {
  final strings = AppLocalizations.of(context);
  final opponent = TextEditingController(text: game.opponentName);
  final soft = TextEditingController(text: '${game.softCapMinutes ?? ''}');
  final total = TextEditingController(text: '${game.totalCapMinutes ?? ''}');
  final target = TextEditingController(text: '${game.maxPoints ?? ''}');
  int? parse(TextEditingController controller) {
    final text = controller.text.trim();
    if (text.isEmpty) return null;
    final value = int.tryParse(text);
    if (value == null || value <= 0) throw const FormatException();
    return value;
  }

  final saved = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(strings.adjustGameSettings),
      content: SizedBox(
        width: 460,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: opponent,
              decoration: InputDecoration(labelText: strings.opponentName),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: soft,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: strings.optionalField(strings.softCapMinutes),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: total,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: strings.optionalField(strings.totalCapMinutes),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: target,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: strings.optionalField(strings.targetScore),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(strings.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(strings.save),
        ),
      ],
    ),
  );
  try {
    if (saved == true) {
      await ref
          .read(gameRepositoryProvider)
          .updateMutableGame(
            gameId: game.id,
            opponentName: opponent.text,
            softCapMinutes: parse(soft),
            totalCapMinutes: parse(total),
            maxPoints: parse(target),
          );
      return true;
    }
    return false;
  } catch (error) {
    if (context.mounted) {
      if (error is FormatException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(strings.positiveIntegerRequired)),
        );
      } else {
        showError(context, error);
      }
    }
    return false;
  } finally {
    opponent.dispose();
    soft.dispose();
    total.dispose();
    target.dispose();
  }
}

String _statsName(AppLocalizations strings, GameBundle bundle, String id) {
  if (id == 'unknown') return strings.unknownPlayer;
  for (final player in bundle.roster) {
    if (player.playerId == id) return playerLabel(strings, player);
  }
  return strings.archivedPlayer;
}

String _playerName(Player player) {
  return player.number == null
      ? player.name
      : '#${player.number} ${player.name}';
}
