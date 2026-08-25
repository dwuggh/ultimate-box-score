import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/models.dart';
import '../domain/recording.dart';
import '../providers.dart';
import 'common.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                ? const Text('统计')
                : DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedGame?.id,
                      isExpanded: true,
                      items: [
                        for (final game in games)
                          DropdownMenuItem(
                            value: game.id,
                            child: Text(
                              '${eventNames[game.eventId] ?? '活动'} · '
                              '${game.teamName} vs ${game.opponentName}',
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
              ? const EmptyState(
                  icon: Icons.query_stats_outlined,
                  message: '还没有可显示的比赛。请先在“比赛”页创建活动和比赛。',
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
              Text('赛前阵容', style: Theme.of(context).textTheme.titleLarge),
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
              Text('快捷阵线', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              if (event.lines.isEmpty)
                const Text('未设置快捷阵线。')
              else
                Wrap(
                  spacing: 8,
                  children: [
                    for (final line in event.lines)
                      Chip(
                        label: Text(
                          '${line.name} · ${line.memberPlayerIds.length}人',
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
                label: const Text('开始比赛'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () =>
                    context.go('/games/game/${bundle.game.id}/edit'),
                icon: const Icon(Icons.edit_outlined),
                label: const Text('编辑比赛设置'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () =>
                    runExport(context, ref, ExportScope.game(bundle.game.id)),
                icon: const Icon(Icons.ios_share),
                label: const Text('导出比赛数据'),
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
          showError(context, StateError('继续比赛前，目标分必须高于当前比分'));
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
              label: const Text('重新打开'),
            ),
            OutlinedButton.icon(
              onPressed: () => showMutableGameEditor(context, ref, bundle.game),
              icon: const Icon(Icons.tune),
              label: const Text('调整比赛设置'),
            ),
            OutlinedButton.icon(
              onPressed: () =>
                  runExport(context, ref, ExportScope.game(bundle.game.id)),
              icon: const Icon(Icons.ios_share),
              label: const Text('导出'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text('球员统计', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        StatsTable(
          stats: bundle.state.stats,
          nameForId: (id) => _statsName(bundle, id),
        ),
        const SizedBox(height: 24),
        Text('逐分事件', style: Theme.of(context).textTheme.titleLarge),
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
    final startedAt = bundle.game.startedAt;
    if (startedAt == null) return;
    final elapsed = DateTime.now().difference(startedAt).inMinutes;
    final checks = [
      if (bundle.game.softCapMinutes case final minutes?)
        ('soft', minutes, bundle.game.softCapAcknowledged, '已到软封顶时间'),
      if (bundle.game.totalCapMinutes case final minutes?)
        ('total', minutes, bundle.game.totalCapAcknowledged, '已到总封顶时间'),
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
            content: Text('比赛已经进行 ${check.$2} 分钟。'),
            actions: [
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('知道了'),
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
    return showDialog<GenderRatio>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('选择首分性别比例 A'),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, GenderRatio.fourMale),
            child: const Text('4男 / 3女'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, GenderRatio.fourFemale),
            child: const Text('3男 / 4女'),
          ),
        ],
      ),
    );
  }

  Future<void> _startPoint(GameBundle bundle) async {
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
        title: '阵容提示',
        message: '${warnings.join('\n')}\n\n仍要开始本分吗？',
        confirmLabel: '仍然开始',
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
        SnackBar(content: Text('${missing.length} 名阵线成员不在本场比赛快照中，已忽略。')),
      );
    }
  }

  Future<void> _finish(GameBundle bundle) async {
    final confirmed = await confirmDialog(
      context,
      title: '结束比赛',
      message: bundle.state.pointInProgress
          ? '当前分将标记为中止，已经记录的事件和上场分会保留。'
          : '比赛结束后将计入队伍累计统计。',
      confirmLabel: '结束比赛',
    );
    if (confirmed) {
      await _run(
        () => ref.read(gameRepositoryProvider).completeGame(bundle.game.id),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      tooltip: '撤销上一步',
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
                      tooltip: '调整比赛设置',
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
                      tooltip: '导出比赛',
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
                      label: const Text('结束'),
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
                    '第 ${bundle.state.nextPointNumber} 分 · '
                    '${modeLabel(bundle.state.nextPointMode)}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  if (bundle.game.isMixed)
                    Text(
                      ratio == null
                          ? '首分比例将由阵容推断'
                          : 'ABBA：${ratioLabel(ratio)}',
                    ),
                ],
              ),
            ),
            Text('已选 ${_selectedRosterIds.length}/7'),
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
                  label: Text('${line.name} (${line.memberPlayerIds.length})'),
                  onPressed: _busy ? null : () => _applyLine(bundle, line),
                ),
            ],
          ),
        ],
        const SizedBox(height: 12),
        for (final player in bundle.roster)
          CheckboxListTile(
            value: _selectedRosterIds.contains(player.id),
            title: Text(playerLabel(player)),
            subtitle: Text(
              '${genderLabel(player.gender)} · ${positionLabel(player.position)}',
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
          label: const Text('开始本分'),
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
            label: const Text('进入中场'),
          ),
        ],
      ],
    );
  }

  Widget _halftimeView(GameBundle bundle) {
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
        label: const Text('结束中场'),
      ),
    );
  }

  Widget _participantView(GameBundle bundle) {
    final state = bundle.state;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(switch (state.stage) {
          RecordingStage.awaitingPickup => '选择捡盘球员',
          RecordingStage.offense => '本队进攻',
          RecordingStage.defense => '本队防守',
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
            label: const Text('对手传盘失误'),
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
            label: const Text('对手得分'),
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
                    participantLabel(bundle, participantId),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (holder) const Chip(label: Text('持盘')),
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
                    child: const Text('捡盘'),
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
                    child: const Text('传盘失误'),
                  ),
                  FilledButton(
                    onPressed: busy || !state.canConfirmGoal
                        ? null
                        : () => run(
                            () => repository.confirmHolderGoal(bundle.game.id),
                          ),
                    child: const Text('得分'),
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
                    child: const Text('接盘'),
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
                    child: const Text('接盘失误'),
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
                    child: const Text('接盘得分'),
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
                    child: const Text('防守成功 D'),
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
                  modeLabel(
                    bundle.state.currentMode ?? bundle.state.nextPointMode,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Text(
                '${bundle.state.opponentScore}  ${bundle.game.opponentName}',
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              '${bundle.state.ourScore}  :  ${bundle.state.opponentScore}',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text('${bundle.game.teamName}  vs  ${bundle.game.opponentName}'),
            const SizedBox(height: 8),
            Text(gameStatusLabel(bundle.game.status)),
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
    final active = bundle.actions.where((action) => !action.voided).toList();
    final latest = active.isEmpty ? null : active.last;
    return Material(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: ListTile(
        dense: true,
        leading: const Icon(Icons.timeline),
        title: Text(latest == null ? '还没有事件' : _actionLabel(bundle, latest)),
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
    if (bundle.actions.isEmpty) {
      return const EmptyState(icon: Icons.timeline, message: '还没有事件。');
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
            title: Text('第 ${point.number} 分'),
            subtitle: Text(
              '${bundle.participantsForPoint(point.id).where((item) => !item.unknown).length} 人',
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
        _actionLabel(bundle, action),
        style: action.voided
            ? const TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      ),
      subtitle: action.voided ? const Text('已撤销') : null,
    );
  }
}

String _actionLabel(GameBundle bundle, RecordedAction action) {
  final actor = participantLabel(bundle, action.actorParticipantId);
  final target = participantLabel(bundle, action.targetParticipantId);
  return switch (action.kind) {
    RecordedActionKind.startPoint => '开始本分',
    RecordedActionKind.startHalftime => '进入中场',
    RecordedActionKind.endHalftime => '结束中场',
    RecordedActionKind.pickup => '$actor 捡盘',
    RecordedActionKind.completedPass => '$actor → $target 接盘',
    RecordedActionKind.receiverDrop => '$actor → $target 接盘失误',
    RecordedActionKind.passerTurnover => '$actor 传盘失误',
    RecordedActionKind.goalCatch => '$actor → $target 得分',
    RecordedActionKind.confirmGoal => '$actor 确认为得分',
    RecordedActionKind.defensiveBlock => '$actor 防守成功 D',
    RecordedActionKind.opponentThrowaway => '对手传盘失误',
    RecordedActionKind.opponentGoal => '对手得分',
    RecordedActionKind.abandonPoint => '本分中止',
  };
}

Future<bool> showMutableGameEditor(
  BuildContext context,
  WidgetRef ref,
  Game game,
) async {
  final opponent = TextEditingController(text: game.opponentName);
  final soft = TextEditingController(text: '${game.softCapMinutes ?? ''}');
  final total = TextEditingController(text: '${game.totalCapMinutes ?? ''}');
  final target = TextEditingController(text: '${game.maxPoints ?? ''}');
  int? parse(TextEditingController controller) {
    final text = controller.text.trim();
    if (text.isEmpty) return null;
    final value = int.tryParse(text);
    if (value == null || value <= 0) throw const FormatException('请输入正整数');
    return value;
  }

  final saved = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('调整比赛设置'),
      content: SizedBox(
        width: 460,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: opponent,
              decoration: const InputDecoration(labelText: '对手名称'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: soft,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '软封顶分钟（可选）'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: total,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '总封顶分钟（可选）'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: target,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '目标分（可选）'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('保存'),
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
    if (context.mounted) showError(context, error);
    return false;
  } finally {
    opponent.dispose();
    soft.dispose();
    total.dispose();
    target.dispose();
  }
}

String _statsName(GameBundle bundle, String id) {
  if (id == 'unknown') return '未知球员';
  for (final player in bundle.roster) {
    if (player.playerId == id) return playerLabel(player);
  }
  return '已归档球员';
}

String _playerName(Player player) {
  return player.number == null
      ? player.name
      : '#${player.number} ${player.name}';
}
