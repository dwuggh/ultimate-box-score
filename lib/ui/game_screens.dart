import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../data/repository.dart';
import '../domain/models.dart';
import '../l10n/app_localizations.dart';
import '../providers.dart';
import 'common.dart';

class EventListScreen extends ConsumerWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    final events = ref.watch(eventsProvider);
    final teams = ref.watch(teamsProvider).valueOrNull ?? const <Team>[];
    final teamNames = {for (final team in teams) team.id: team.name};
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.eventsAndGames),
        actions: const [ExportAllButton()],
      ),
      body: events.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => ErrorState(error),
        data: (items) {
          if (items.isEmpty) {
            return EmptyState(
              icon: Icons.event_note_outlined,
              message: strings.noEvents,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final event = items[index];
              final dates = _dateRange(strings, event.startDate, event.endDate);
              return Card(
                child: ListTile(
                  leading: Icon(
                    event.archived ? Icons.inventory_2_outlined : Icons.event,
                  ),
                  title: Text(event.name),
                  subtitle: Text(
                    [
                      teamNames[event.teamId] ?? strings.unknownTeam,
                      ?dates,
                      if (event.archived) strings.archived,
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
        label: Text(strings.newEvent),
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
    final strings = AppLocalizations.of(context);
    final event = bundle.event;
    return Scaffold(
      appBar: AppBar(
        title: Text(event.name),
        actions: [
          IconButton(
            tooltip: strings.exportEventData,
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
                      title: strings.deleteEvent,
                      message: strings.deleteEventMessage,
                      confirmLabel: strings.delete,
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
              PopupMenuItem(value: 'edit', child: Text(strings.editEvent)),
              PopupMenuItem(
                value: 'archive',
                child: Text(
                  event.archived ? strings.restoreEvent : strings.archiveEvent,
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Text(strings.permanentlyDelete),
              ),
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
            title: strings.eventRosterCount(bundle.roster.length),
            actionLabel: strings.manage,
            onPressed: event.archived
                ? null
                : () => showEventRosterEditor(context, ref, bundle),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: bundle.roster.isEmpty
                  ? Text(strings.eventRosterEmpty)
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
            title: strings.quickLines,
            actionLabel: strings.add,
            onPressed: event.archived
                ? null
                : () => showLineEditor(context, ref, bundle),
          ),
          const SizedBox(height: 8),
          if (bundle.lines.isEmpty)
            Card(child: ListTile(title: Text(strings.noQuickLines)))
          else
            for (final line in bundle.lines) ...[
              Card(
                child: ListTile(
                  title: Text(line.name),
                  subtitle: Text(
                    strings.peopleCount(line.memberPlayerIds.length),
                  ),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        tooltip: strings.edit,
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
                        tooltip: strings.delete,
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
            title: strings.games,
            actionLabel: strings.newAction,
            onPressed: event.archived
                ? null
                : () => context.go('/games/event/${event.id}/game/new'),
          ),
          const SizedBox(height: 8),
          if (bundle.games.isEmpty)
            Card(child: ListTile(title: Text(strings.noGames)))
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
    final strings = AppLocalizations.of(context);
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
                    strings.versusLabel(
                      game.teamName,
                      opponentLabel(strings, game.opponentName),
                    ),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${strings.gameStatusLabel(game.status)} · '
                    '${DateFormat.yMd(strings.localeName).add_Hm().format(game.startedAt ?? game.createdAt)}',
                  ),
                ],
              ),
            ),
            if (game.status == GameStatus.draft)
              IconButton(
                tooltip: strings.edit,
                onPressed: () => context.go('/games/game/${game.id}/edit'),
                icon: const Icon(Icons.edit_outlined),
              ),
            IconButton(
              tooltip: strings.openInStats,
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
                    title: strings.deleteGame,
                    message: strings.deleteGameMessage,
                    confirmLabel: strings.delete,
                    destructive: true,
                  );
                  if (confirmed) {
                    await ref.read(gameRepositoryProvider).deleteGame(game.id);
                  }
                }
              },
              itemBuilder: (context) => [
                if (game.status == GameStatus.draft)
                  PopupMenuItem(value: 'start', child: Text(strings.startGame)),
                PopupMenuItem(value: 'delete', child: Text(strings.deleteGame)),
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
    if (value == null || value <= 0) throw const FormatException();
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
      if (mounted) {
        if (error is FormatException) {
          final strings = AppLocalizations.of(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(strings.positiveIntegerRequired)),
          );
        } else {
          showError(context, error);
        }
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final games = ref.watch(gamesProvider).valueOrNull ?? const <Game>[];
    Game? existing;
    if (widget.gameId != null) {
      for (final game in games) {
        if (game.id == widget.gameId) existing = game;
      }
      if (existing == null && ref.watch(gamesProvider).isLoading) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      if (existing == null) {
        return Scaffold(
          body: EmptyState(
            icon: Icons.search_off,
            message: strings.gameNotFound,
          ),
        );
      }
      _load(existing);
    }
    final eventId = widget.eventId ?? existing!.eventId;
    final eventBundle = ref.watch(eventBundleProvider(eventId));
    return Scaffold(
      appBar: AppBar(
        title: Text(existing == null ? strings.newGame : strings.editGame),
      ),
      body: eventBundle.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => ErrorState(error),
        data: (event) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(strings.eventTeamLabel(event.event.name, event.team.name)),
            const SizedBox(height: 16),
            TextField(
              controller: _opponent,
              decoration: InputDecoration(labelText: strings.opponentName),
            ),
            const SizedBox(height: 16),
            SegmentedButton<PossessionMode>(
              segments: [
                ButtonSegment(
                  value: PossessionMode.offense,
                  label: Text(strings.openingOffense),
                ),
                ButtonSegment(
                  value: PossessionMode.defense,
                  label: Text(strings.openingDefense),
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
                  child: _NumberField(
                    controller: _softCap,
                    label: strings.softCapMinutes,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _NumberField(
                    controller: _totalCap,
                    label: strings.totalCapMinutes,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _NumberField(controller: _target, label: strings.targetScore),
            if (event.team.type == TeamType.mixed) ...[
              const SizedBox(height: 16),
              DropdownButtonFormField<GenderRatio?>(
                initialValue: _firstRatio,
                decoration: InputDecoration(labelText: strings.firstPointRatio),
                items: [
                  DropdownMenuItem(
                    value: null,
                    child: Text(strings.inferFromFirstLineup),
                  ),
                  DropdownMenuItem(
                    value: GenderRatio.fourMale,
                    child: Text(strings.ratioFourMale),
                  ),
                  DropdownMenuItem(
                    value: GenderRatio.fourFemale,
                    child: Text(strings.ratioFourFemale),
                  ),
                ],
                onChanged: (value) => setState(() => _firstRatio = value),
              ),
            ],
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _saving ? null : () => _save(eventId),
              icon: const Icon(Icons.save_outlined),
              label: Text(strings.saveDraft),
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
    final strings = AppLocalizations.of(context);
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: strings.optionalField(label)),
    );
  }
}

class _EventSummary extends StatelessWidget {
  const _EventSummary({required this.bundle});

  final EventBundle bundle;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
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
            if (_dateRange(strings, event.startDate, event.endDate)
                case final dates?)
              Text(dates),
            if (event.location != null)
              Text(strings.locationValue(event.location!)),
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
  final strings = AppLocalizations.of(context);
  final teams = ref.read(teamsProvider).valueOrNull ?? const <Team>[];
  final available = teams
      .where((team) => !team.archived || team.id == event?.teamId)
      .toList();
  if (available.isEmpty) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(strings.createTeamFirst)));
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
        title: Text(event == null ? strings.newEvent : strings.editEvent),
        content: SizedBox(
          width: 520,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: name,
                  decoration: InputDecoration(labelText: strings.eventName),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: teamId,
                  decoration: InputDecoration(labelText: strings.team),
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
                              ? strings.startDateOptional
                              : DateFormat.yMd(strings.localeName)
                                    .format(start!),
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
                              ? strings.endDateOptional
                              : DateFormat.yMd(strings.localeName).format(end!),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: location,
                  decoration: InputDecoration(
                    labelText: strings.locationOptional,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: notes,
                  maxLines: 3,
                  decoration: InputDecoration(labelText: strings.notesOptional),
                ),
              ],
            ),
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
  final strings = AppLocalizations.of(context);
  final selected = bundle.roster.map((player) => player.id).toSet();
  final saved = await showDialog<bool>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setDialogState) => AlertDialog(
        title: Text(strings.manageEventRoster),
        content: SizedBox(
          width: 480,
          height: 520,
          child: ListView(
            children: [
              for (final player in bundle.teamPlayers)
                CheckboxListTile(
                  value: selected.contains(player.id),
                  title: Text(_playerName(player)),
                  subtitle: player.archived
                      ? Text(strings.archivedOnTeam)
                      : null,
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
            child: Text(strings.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(strings.save),
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
        title: strings.removeFromEventRoster,
        message: strings.removeFromEventRosterMessage,
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
  final strings = AppLocalizations.of(context);
  final name = TextEditingController(text: line?.name);
  final selected = (line?.memberPlayerIds ?? const <String>[]).toSet();
  final saved = await showDialog<bool>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setDialogState) => AlertDialog(
        title: Text(
          line == null ? strings.addQuickLine : strings.editQuickLine,
        ),
        content: SizedBox(
          width: 480,
          height: 560,
          child: Column(
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(labelText: strings.lineName),
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
            child: Text(strings.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(strings.save),
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

String? _dateRange(AppLocalizations strings, DateTime? start, DateTime? end) {
  if (start == null && end == null) return null;
  final format = DateFormat.yMd(strings.localeName);
  if (start == null) return strings.dateUntil(format.format(end!));
  if (end == null) return strings.dateFrom(format.format(start));
  return strings.dateRange(format.format(start), format.format(end));
}
