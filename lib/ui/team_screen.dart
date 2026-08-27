import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models.dart';
import '../l10n/app_localizations.dart';
import '../providers.dart';
import 'common.dart';
import 'home_screen.dart';

class TeamScreen extends ConsumerWidget {
  const TeamScreen({required this.teamId, super.key});

  final String teamId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teams = ref.watch(teamsProvider);
    return teams.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) => Scaffold(body: ErrorState(error)),
      data: (items) {
        final strings = AppLocalizations.of(context);
        Team? team;
        for (final item in items) {
          if (item.id == teamId) team = item;
        }
        if (team == null) {
          return Scaffold(
            body: EmptyState(
              icon: Icons.search_off,
              message: strings.teamNotFound,
            ),
          );
        }
        return _TeamContent(team: team);
      },
    );
  }
}

class _TeamContent extends ConsumerWidget {
  const _TeamContent({required this.team});

  final Team team;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(team.name),
          actions: [
            IconButton(
              tooltip: strings.exportTeamData,
              onPressed: () =>
                  runExport(context, ref, ExportScope.team(team.id)),
              icon: const Icon(Icons.ios_share),
            ),
            IconButton(
              tooltip: strings.editTeam,
              onPressed: team.archived
                  ? null
                  : () => showTeamEditor(context, ref, team: team),
              icon: const Icon(Icons.edit_outlined),
            ),
            IconButton(
              tooltip: team.archived
                  ? strings.restoreTeam
                  : strings.archiveTeam,
              onPressed: () async {
                try {
                  await ref
                      .read(teamRepositoryProvider)
                      .setTeamArchived(team.id, !team.archived);
                } catch (error) {
                  if (context.mounted) showError(context, error);
                }
              },
              icon: Icon(
                team.archived
                    ? Icons.unarchive_outlined
                    : Icons.archive_outlined,
              ),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                icon: const Icon(Icons.groups_outlined),
                text: strings.roster,
              ),
              Tab(icon: const Icon(Icons.query_stats), text: strings.teamStats),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _RosterTab(team: team),
            _TeamStatsTab(teamId: team.id),
          ],
        ),
      ),
    );
  }
}

class _RosterTab extends ConsumerWidget {
  const _RosterTab({required this.team});

  final Team team;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    return ref
        .watch(playersProvider(team.id))
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => ErrorState(error),
          data: (players) => Stack(
            children: [
              if (players.isEmpty)
                EmptyState(
                  icon: Icons.person_add_alt,
                  message: strings.rosterEmpty,
                )
              else
                ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                  itemCount: players.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final player = players[index];
                    return ListTile(
                      enabled: !player.archived,
                      leading: CircleAvatar(
                        child: Text(
                          player.number ?? player.name.characters.first,
                        ),
                      ),
                      title: Text(player.name),
                      subtitle: Text(
                        '${strings.genderLabel(player.gender)} · '
                        '${strings.positionLabel(player.position)}'
                        '${player.archived ? ' · ${strings.archived}' : ''}',
                      ),
                      onTap: player.archived
                          ? null
                          : () => showPlayerEditor(
                              context,
                              ref,
                              teamId: team.id,
                              player: player,
                            ),
                      trailing: IconButton(
                        tooltip: player.archived
                            ? strings.restorePlayer
                            : strings.archivePlayer,
                        onPressed: () async {
                          await ref
                              .read(teamRepositoryProvider)
                              .setPlayerArchived(player.id, !player.archived);
                        },
                        icon: Icon(
                          player.archived
                              ? Icons.unarchive_outlined
                              : Icons.archive_outlined,
                        ),
                      ),
                    );
                  },
                ),
              Positioned(
                right: 16,
                bottom: 16,
                child: FloatingActionButton.extended(
                  onPressed: team.archived
                      ? null
                      : () => showPlayerEditor(context, ref, teamId: team.id),
                  icon: const Icon(Icons.person_add_alt),
                  label: Text(strings.addPlayer),
                ),
              ),
            ],
          ),
        );
  }
}

class _TeamStatsTab extends ConsumerWidget {
  const _TeamStatsTab({required this.teamId});

  final String teamId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    final players = ref.watch(playersProvider(teamId));
    final stats = ref.watch(teamStatsProvider(teamId));
    return players.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => ErrorState(error),
      data: (items) => stats.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => ErrorState(error),
        data: (values) {
          final names = {for (final player in items) player.id: player.name};
          return Padding(
            padding: const EdgeInsets.all(16),
            child: StatsTable(
              stats: values,
              nameForId: (id) => id == 'unknown'
                  ? strings.unknownPlayer
                  : names[id] ?? strings.archivedPlayer,
            ),
          );
        },
      ),
    );
  }
}

Future<void> showPlayerEditor(
  BuildContext context,
  WidgetRef ref, {
  required String teamId,
  Player? player,
}) async {
  final strings = AppLocalizations.of(context);
  final nameController = TextEditingController(text: player?.name);
  final numberController = TextEditingController(text: player?.number);
  var gender = player?.gender ?? PlayerGender.male;
  var position = player?.position ?? PlayerPosition.any;
  final saved = await showDialog<bool>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setDialogState) => AlertDialog(
        title: Text(player == null ? strings.addPlayer : strings.editPlayer),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                autofocus: true,
                decoration: InputDecoration(labelText: strings.playerName),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: numberController,
                decoration: InputDecoration(
                  labelText: strings.playerNumberOptional,
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<PlayerGender>(
                initialValue: gender,
                decoration: InputDecoration(labelText: strings.gender),
                items: [
                  for (final value in PlayerGender.values)
                    DropdownMenuItem(
                      value: value,
                      child: Text(strings.genderLabel(value)),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) setDialogState(() => gender = value);
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<PlayerPosition>(
                initialValue: position,
                decoration: InputDecoration(labelText: strings.position),
                items: [
                  for (final value in PlayerPosition.values)
                    DropdownMenuItem(
                      value: value,
                      child: Text(strings.positionLabel(value)),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) setDialogState(() => position = value);
                },
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
  if (saved != true || !context.mounted) {
    nameController.dispose();
    numberController.dispose();
    return;
  }
  try {
    await ref
        .read(teamRepositoryProvider)
        .savePlayer(
          id: player?.id,
          teamId: teamId,
          name: nameController.text,
          number: numberController.text,
          gender: gender,
          position: position,
        );
  } catch (error) {
    if (context.mounted) showError(context, error);
  } finally {
    nameController.dispose();
    numberController.dispose();
  }
}
