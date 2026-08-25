import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models.dart';
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
        Team? team;
        for (final item in items) {
          if (item.id == teamId) team = item;
        }
        if (team == null) {
          return const Scaffold(
            body: EmptyState(icon: Icons.search_off, message: '队伍不存在。'),
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(team.name),
          actions: [
            IconButton(
              tooltip: '导出队伍数据',
              onPressed: () =>
                  runExport(context, ref, ExportScope.team(team.id)),
              icon: const Icon(Icons.ios_share),
            ),
            IconButton(
              tooltip: '编辑队伍',
              onPressed: team.archived
                  ? null
                  : () => showTeamEditor(context, ref, team: team),
              icon: const Icon(Icons.edit_outlined),
            ),
            IconButton(
              tooltip: team.archived ? '恢复队伍' : '归档队伍',
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
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.groups_outlined), text: '阵容'),
              Tab(icon: Icon(Icons.query_stats), text: '累计统计'),
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
    return ref
        .watch(playersProvider(team.id))
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => ErrorState(error),
          data: (players) => Stack(
            children: [
              if (players.isEmpty)
                const EmptyState(
                  icon: Icons.person_add_alt,
                  message: '阵容为空，请添加球员。',
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
                        '${genderLabel(player.gender)} · '
                        '${positionLabel(player.position)}'
                        '${player.archived ? ' · 已归档' : ''}',
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
                        tooltip: player.archived ? '恢复球员' : '归档球员',
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
                  label: const Text('添加球员'),
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
              nameForId: (id) =>
                  id == 'unknown' ? '未知球员' : names[id] ?? '已归档球员',
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
  final nameController = TextEditingController(text: player?.name);
  final numberController = TextEditingController(text: player?.number);
  var gender = player?.gender ?? PlayerGender.male;
  var position = player?.position ?? PlayerPosition.any;
  final saved = await showDialog<bool>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setDialogState) => AlertDialog(
        title: Text(player == null ? '添加球员' : '编辑球员'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                autofocus: true,
                decoration: const InputDecoration(labelText: '姓名'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: numberController,
                decoration: const InputDecoration(labelText: '号码（可选）'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<PlayerGender>(
                initialValue: gender,
                decoration: const InputDecoration(labelText: '性别'),
                items: [
                  for (final value in PlayerGender.values)
                    DropdownMenuItem(
                      value: value,
                      child: Text(genderLabel(value)),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) setDialogState(() => gender = value);
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<PlayerPosition>(
                initialValue: position,
                decoration: const InputDecoration(labelText: '位置'),
                items: [
                  for (final value in PlayerPosition.values)
                    DropdownMenuItem(
                      value: value,
                      child: Text(positionLabel(value)),
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
