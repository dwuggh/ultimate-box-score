import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../data/repository.dart';
import '../domain/models.dart';
import '../providers.dart';
import 'common.dart';

class EventListScreen extends ConsumerWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventsProvider);
    final teams = ref.watch(teamsProvider).valueOrNull ?? const <Team>[];
    final teamNames = {for (final team in teams) team.id: team.name};
    return Scaffold(
      appBar: AppBar(
        title: const Text('活动与比赛'),
        actions: const [ExportAllButton()],
      ),
      body: events.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => ErrorState(error),
        data: (items) {
          if (items.isEmpty) {
            return const EmptyState(
              icon: Icons.event_note_outlined,
              message: '还没有活动。先创建活动，再配置阵容、阵线和比赛。',
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final event = items[index];
              final dates = _dateRange(event.startDate, event.endDate);
              return Card(
                child: ListTile(
                  leading: Icon(
                    event.archived ? Icons.inventory_2_outlined : Icons.event,
                  ),
                  title: Text(event.name),
                  subtitle: Text(
                    [
                      teamNames[event.teamId] ?? '未知队伍',
                      ?dates,
                      if (event.archived) '已归档',
                    ].join(' · '),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.go('/games/event/${event.id}'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showEventEditor(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('新建活动'),
      ),
    );
  }
}

class EventDetailScreen extends ConsumerWidget {
  const EventDetailScreen({required this.eventId, super.key});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(eventBundleProvider(eventId))
        .when(
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (error, stack) => Scaffold(body: ErrorState(error)),
          data: (bundle) => _EventDetail(bundle: bundle),
        );
  }
}

class _EventDetail extends ConsumerWidget {
  const _EventDetail({required this.bundle});

  final EventBundle bundle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = bundle.event;
    return Scaffold(
      appBar: AppBar(
        title: Text(event.name),
        actions: [
          IconButton(
            tooltip: '导出活动数据',
            onPressed: () =>
                runExport(context, ref, ExportScope.event(event.id)),
            icon: const Icon(Icons.ios_share),
          ),
          PopupMenuButton<String>(
            onSelected: (value) async {
              try {
                switch (value) {
                  case 'edit':
                    await showEventEditor(context, ref, event: event);
                  case 'archive':
                    await ref
                        .read(eventRepositoryProvider)
                        .setArchived(event.id, !event.archived);
                  case 'delete':
                    final confirmed = await confirmDialog(
                      context,
                      title: '删除活动',
                      message: '只有没有比赛的活动可以永久删除。',
                      confirmLabel: '删除',
                      destructive: true,
                    );
                    if (!confirmed) return;
                    await ref
                        .read(eventRepositoryProvider)
                        .deleteEmptyEvent(event.id);
                    if (context.mounted) context.go('/games');
                }
              } catch (error) {
                if (context.mounted) showError(context, error);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Text('编辑活动')),
              PopupMenuItem(
                value: 'archive',
                child: Text(event.archived ? '恢复活动' : '归档活动'),
              ),
              const PopupMenuItem(value: 'delete', child: Text('永久删除')),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _EventSummary(bundle: bundle),
          const SizedBox(height: 20),
          _SectionHeader(
            title: '活动阵容（${bundle.roster.length}）',
            actionLabel: '管理',
            onPressed: event.archived
                ? null
                : () => showEventRosterEditor(context, ref, bundle),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: bundle.roster.isEmpty
                  ? const Text('活动阵容为空。')
                  : Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final player in bundle.roster)
                          Chip(
                            avatar: player.archived
                                ? const Icon(Icons.archive_outlined, size: 18)
                                : null,
                            label: Text(_playerName(player)),
                          ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 20),
          _SectionHeader(
            title: '快捷阵线',
            actionLabel: '添加',
            onPressed: event.archived
                ? null
                : () => showLineEditor(context, ref, bundle),
          ),
          const SizedBox(height: 8),
          if (bundle.lines.isEmpty)
            const Card(child: ListTile(title: Text('还没有快捷阵线。')))
          else
            for (final line in bundle.lines) ...[
              Card(
                child: ListTile(
                  title: Text(line.name),
                  subtitle: Text('${line.memberPlayerIds.length} 人'),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        tooltip: '编辑',
                        onPressed: event.archived
                            ? null
                            : () => showLineEditor(
                                context,
                                ref,
                                bundle,
                                line: line,
                              ),
                        icon: const Icon(Icons.edit_outlined),
                      ),
                      IconButton(
                        tooltip: '删除',
                        onPressed: event.archived
                            ? null
                            : () => ref
                                  .read(eventRepositoryProvider)
                                  .deleteLine(line.id),
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          const SizedBox(height: 20),
          _SectionHeader(
            title: '比赛',
            actionLabel: '新建',
            onPressed: event.archived
                ? null
                : () => context.go('/games/event/${event.id}/game/new'),
          ),
          const SizedBox(height: 8),
          if (bundle.games.isEmpty)
            const Card(child: ListTile(title: Text('还没有比赛。')))
          else
            for (final game in bundle.games) ...[
              _GameCard(game: game),
              const SizedBox(height: 8),
            ],
        ],
      ),
    );
  }
}

class _GameCard extends ConsumerWidget {
  const _GameCard({required this.game});

  final Game game;

  Future<void> _openStats(BuildContext context, WidgetRef ref) async {
    await ref.read(gameRepositoryProvider).selectGame(game.id);
    if (context.mounted) context.go('/stats');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        child: Row(
          children: [
            Icon(switch (game.status) {
              GameStatus.draft => Icons.schedule,
              GameStatus.inProgress => Icons.radio_button_checked,
              GameStatus.completed => Icons.check_circle_outline,
            }),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${game.teamName} vs ${game.opponentName}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${gameStatusLabel(game.status)} · '
                    '${DateFormat('yyyy-MM-dd HH:mm').format(game.startedAt ?? game.createdAt)}',
                  ),
                ],
              ),
            ),
            if (game.status == GameStatus.draft)
              IconButton(
                tooltip: '编辑',
                onPressed: () => context.go('/games/game/${game.id}/edit'),
                icon: const Icon(Icons.edit_outlined),
              ),
            IconButton(
              tooltip: '在统计页打开',
              onPressed: () => _openStats(context, ref),
              icon: const Icon(Icons.query_stats),
            ),
            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'start') {
                  try {
                    await ref.read(gameRepositoryProvider).startGame(game.id);
                    if (context.mounted) context.go('/stats');
                  } catch (error) {
                    if (context.mounted) showError(context, error);
                  }
                } else if (value == 'delete') {
                  final confirmed = await confirmDialog(
                    context,
                    title: '删除比赛',
                    message: '比赛、阵容快照和完整事件记录都将永久删除。',
                    confirmLabel: '删除',
                    destructive: true,
                  );
                  if (confirmed) {
                    await ref.read(gameRepositoryProvider).deleteGame(game.id);
                  }
                }
              },
              itemBuilder: (context) => [
                if (game.status == GameStatus.draft)
                  const PopupMenuItem(value: 'start', child: Text('开始比赛')),
                const PopupMenuItem(value: 'delete', child: Text('删除比赛')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GameEditorScreen extends ConsumerStatefulWidget {
  const GameEditorScreen({this.eventId, this.gameId, super.key});

  final String? eventId;
  final String? gameId;

  @override
  ConsumerState<GameEditorScreen> createState() => _GameEditorScreenState();
}

class _GameEditorScreenState extends ConsumerState<GameEditorScreen> {
  final _opponent = TextEditingController();
  final _softCap = TextEditingController();
  final _totalCap = TextEditingController();
  final _target = TextEditingController();
  var _openingMode = PossessionMode.offense;
  GenderRatio? _firstRatio;
  String? _loadedGameId;
  var _saving = false;

  @override
  void dispose() {
    _opponent.dispose();
    _softCap.dispose();
    _totalCap.dispose();
    _target.dispose();
    super.dispose();
  }

  int? _number(TextEditingController controller) {
    final text = controller.text.trim();
    if (text.isEmpty) return null;
    final value = int.tryParse(text);
    if (value == null || value <= 0) throw const FormatException('请输入正整数');
    return value;
  }

  void _load(Game game) {
    if (_loadedGameId == game.id) return;
    _loadedGameId = game.id;
    _opponent.text = game.opponentName;
    _softCap.text = '${game.softCapMinutes ?? ''}';
    _totalCap.text = '${game.totalCapMinutes ?? ''}';
    _target.text = '${game.maxPoints ?? ''}';
    _openingMode = game.openingMode;
    _firstRatio = game.firstRatio;
  }

  Future<void> _save(String eventId) async {
    setState(() => _saving = true);
    try {
      await ref
          .read(gameRepositoryProvider)
          .saveDraft(
            GameDraftRequest(
              eventId: eventId,
              opponentName: _opponent.text,
              openingMode: _openingMode,
              softCapMinutes: _number(_softCap),
              totalCapMinutes: _number(_totalCap),
              maxPoints: _number(_target),
              firstRatio: _firstRatio,
            ),
            id: widget.gameId,
          );
      if (mounted) context.go('/games/event/$eventId');
    } catch (error) {
      if (mounted) showError(context, error);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final games = ref.watch(gamesProvider).valueOrNull ?? const <Game>[];
    Game? existing;
    if (widget.gameId != null) {
      for (final game in games) {
        if (game.id == widget.gameId) existing = game;
      }
      if (existing == null && ref.watch(gamesProvider).isLoading) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      if (existing == null) return const Scaffold(body: ErrorState('比赛不存在'));
      _load(existing);
    }
    final eventId = widget.eventId ?? existing!.eventId;
    final eventBundle = ref.watch(eventBundleProvider(eventId));
    return Scaffold(
      appBar: AppBar(title: Text(existing == null ? '新建比赛' : '编辑比赛')),
      body: eventBundle.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => ErrorState(error),
        data: (event) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('活动：${event.event.name} · ${event.team.name}'),
            const SizedBox(height: 16),
            TextField(
              controller: _opponent,
              decoration: const InputDecoration(labelText: '对手名称'),
            ),
            const SizedBox(height: 16),
            SegmentedButton<PossessionMode>(
              segments: const [
                ButtonSegment(
                  value: PossessionMode.offense,
                  label: Text('首分进攻'),
                ),
                ButtonSegment(
                  value: PossessionMode.defense,
                  label: Text('首分防守'),
                ),
              ],
              selected: {_openingMode},
              onSelectionChanged: (value) {
                setState(() => _openingMode = value.single);
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _NumberField(controller: _softCap, label: '软封顶（分钟）'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _NumberField(controller: _totalCap, label: '总封顶（分钟）'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _NumberField(controller: _target, label: '目标分'),
            if (event.team.type == TeamType.mixed) ...[
              const SizedBox(height: 16),
              DropdownButtonFormField<GenderRatio?>(
                initialValue: _firstRatio,
                decoration: const InputDecoration(labelText: '首分性别比例 A'),
                items: const [
                  DropdownMenuItem(value: null, child: Text('由首分阵容推断')),
                  DropdownMenuItem(
                    value: GenderRatio.fourMale,
                    child: Text('4男 / 3女'),
                  ),
                  DropdownMenuItem(
                    value: GenderRatio.fourFemale,
                    child: Text('3男 / 4女'),
                  ),
                ],
                onChanged: (value) => setState(() => _firstRatio = value),
              ),
            ],
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _saving ? null : () => _save(eventId),
              icon: const Icon(Icons.save_outlined),
              label: const Text('保存草稿'),
            ),
          ],
        ),
      ),
    );
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({required this.controller, required this.label});

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: '$label（可选）'),
    );
  }
}

class _EventSummary extends StatelessWidget {
  const _EventSummary({required this.bundle});

  final EventBundle bundle;

  @override
  Widget build(BuildContext context) {
    final event = bundle.event;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bundle.team.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (_dateRange(event.startDate, event.endDate) case final dates?)
              Text(dates),
            if (event.location != null) Text('地点：${event.location}'),
            if (event.notes != null) ...[
              const SizedBox(height: 8),
              Text(event.notes!),
            ],
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.actionLabel,
    required this.onPressed,
  });

  final String title;
  final String actionLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        TextButton(onPressed: onPressed, child: Text(actionLabel)),
      ],
    );
  }
}

Future<void> showEventEditor(
  BuildContext context,
  WidgetRef ref, {
  CompetitionEvent? event,
}) async {
  final teams = ref.read(teamsProvider).valueOrNull ?? const <Team>[];
  final available = teams
      .where((team) => !team.archived || team.id == event?.teamId)
      .toList();
  if (available.isEmpty) {
    showError(context, StateError('请先创建一个可用队伍'));
    return;
  }
  final name = TextEditingController(text: event?.name);
  final location = TextEditingController(text: event?.location);
  final notes = TextEditingController(text: event?.notes);
  var teamId = event?.teamId ?? available.first.id;
  var start = event?.startDate;
  var end = event?.endDate;
  final saved = await showDialog<bool>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setDialogState) => AlertDialog(
        title: Text(event == null ? '新建活动' : '编辑活动'),
        content: SizedBox(
          width: 520,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: name,
                  decoration: const InputDecoration(labelText: '名称'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: teamId,
                  decoration: const InputDecoration(labelText: '队伍'),
                  items: [
                    for (final team in available)
                      DropdownMenuItem(value: team.id, child: Text(team.name)),
                  ],
                  onChanged: event == null
                      ? (value) => setDialogState(() => teamId = value!)
                      : null,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          final value = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            initialDate: start ?? DateTime.now(),
                          );
                          if (value != null) {
                            setDialogState(() => start = value);
                          }
                        },
                        child: Text(
                          start == null
                              ? '开始日期（可选）'
                              : DateFormat('yyyy-MM-dd').format(start!),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          final value = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            initialDate: end ?? start ?? DateTime.now(),
                          );
                          if (value != null) setDialogState(() => end = value);
                        },
                        child: Text(
                          end == null
                              ? '结束日期（可选）'
                              : DateFormat('yyyy-MM-dd').format(end!),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: location,
                  decoration: const InputDecoration(labelText: '地点（可选）'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: notes,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: '备注（可选）'),
                ),
              ],
            ),
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
    ),
  );
  try {
    if (saved == true) {
      await ref
          .read(eventRepositoryProvider)
          .saveEvent(
            EventSaveRequest(
              teamId: teamId,
              name: name.text,
              startDate: start,
              endDate: end,
              location: location.text,
              notes: notes.text,
            ),
            id: event?.id,
          );
    }
  } catch (error) {
    if (context.mounted) showError(context, error);
  } finally {
    name.dispose();
    location.dispose();
    notes.dispose();
  }
}

Future<void> showEventRosterEditor(
  BuildContext context,
  WidgetRef ref,
  EventBundle bundle,
) async {
  final selected = bundle.roster.map((player) => player.id).toSet();
  final saved = await showDialog<bool>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setDialogState) => AlertDialog(
        title: const Text('管理活动阵容'),
        content: SizedBox(
          width: 480,
          height: 520,
          child: ListView(
            children: [
              for (final player in bundle.teamPlayers)
                CheckboxListTile(
                  value: selected.contains(player.id),
                  title: Text(_playerName(player)),
                  subtitle: player.archived ? const Text('已在队伍中归档') : null,
                  onChanged: (value) => setDialogState(() {
                    if (value ?? false) {
                      selected.add(player.id);
                    } else {
                      selected.remove(player.id);
                    }
                  }),
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
    ),
  );
  if (saved != true || !context.mounted) return;
  try {
    final removed = bundle.roster.where(
      (player) => !selected.contains(player.id),
    );
    if (removed.isNotEmpty) {
      final confirmed = await confirmDialog(
        context,
        title: '移出活动阵容',
        message: '移出的球员也会从所有快捷阵线中删除；已经开始的比赛快照不受影响。',
      );
      if (!confirmed) return;
    }
    await ref
        .read(eventRepositoryProvider)
        .setRoster(bundle.event.id, selected);
  } catch (error) {
    if (context.mounted) showError(context, error);
  }
}

Future<void> showLineEditor(
  BuildContext context,
  WidgetRef ref,
  EventBundle bundle, {
  LinePreset? line,
}) async {
  final name = TextEditingController(text: line?.name);
  final selected = (line?.memberPlayerIds ?? const <String>[]).toSet();
  final saved = await showDialog<bool>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setDialogState) => AlertDialog(
        title: Text(line == null ? '添加快捷阵线' : '编辑快捷阵线'),
        content: SizedBox(
          width: 480,
          height: 560,
          child: Column(
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(labelText: '名称'),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView(
                  children: [
                    for (final player in bundle.roster)
                      CheckboxListTile(
                        value: selected.contains(player.id),
                        title: Text(_playerName(player)),
                        onChanged: (value) => setDialogState(() {
                          if (value ?? false) {
                            selected.add(player.id);
                          } else {
                            selected.remove(player.id);
                          }
                        }),
                      ),
                  ],
                ),
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
    ),
  );
  try {
    if (saved == true) {
      await ref
          .read(eventRepositoryProvider)
          .saveLine(
            id: line?.id,
            eventId: bundle.event.id,
            name: name.text,
            playerIds: selected,
          );
    }
  } catch (error) {
    if (context.mounted) showError(context, error);
  } finally {
    name.dispose();
  }
}

String _playerName(Player player) {
  return player.number == null
      ? player.name
      : '#${player.number} ${player.name}';
}

String? _dateRange(DateTime? start, DateTime? end) {
  if (start == null && end == null) return null;
  final format = DateFormat('yyyy-MM-dd');
  if (start == null) return '至 ${format.format(end!)}';
  if (end == null) return format.format(start);
  return '${format.format(start)} – ${format.format(end)}';
}
