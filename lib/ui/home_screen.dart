import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/models.dart';
import '../l10n/app_localizations.dart';
import '../providers.dart';
import 'common.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.groups_outlined),
            selectedIcon: const Icon(Icons.groups),
            label: strings.teams,
          ),
          NavigationDestination(
            icon: const Icon(Icons.event_note_outlined),
            selectedIcon: const Icon(Icons.event_note),
            label: strings.games,
          ),
          NavigationDestination(
            icon: const Icon(Icons.query_stats_outlined),
            selectedIcon: const Icon(Icons.query_stats),
            label: strings.stats,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: strings.settings,
          ),
        ],
      ),
    );
  }
}

class TeamHomeScreen extends ConsumerWidget {
  const TeamHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.teams),
        actions: const [ExportAllButton()],
      ),
      body: const TeamList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showTeamEditor(context, ref),
        icon: const Icon(Icons.add),
        label: Text(strings.addTeam),
      ),
    );
  }
}

class TeamList extends ConsumerWidget {
  const TeamList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    return ref
        .watch(teamsProvider)
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => ErrorState(error),
          data: (teams) {
            if (teams.isEmpty) {
              return EmptyState(
                icon: Icons.groups_outlined,
                message: strings.noTeams,
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
              itemCount: teams.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final team = teams[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        team.type == TeamType.mixed
                            ? Icons.diversity_1
                            : Icons.group,
                      ),
                    ),
                    title: Text(team.name),
                    subtitle: Text(
                      '${strings.teamTypeLabel(team.type)}'
                      '${team.archived ? ' · ${strings.archived}' : ''}',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.go('/team/${team.id}'),
                  ),
                );
              },
            );
          },
        );
  }
}

Future<void> showTeamEditor(
  BuildContext context,
  WidgetRef ref, {
  Team? team,
}) async {
  final strings = AppLocalizations.of(context);
  final nameController = TextEditingController(text: team?.name);
  var type = team?.type ?? TeamType.mixed;
  final saved = await showDialog<bool>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setDialogState) => AlertDialog(
        title: Text(team == null ? strings.addTeam : strings.editTeam),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              autofocus: true,
              decoration: InputDecoration(labelText: strings.teamName),
            ),
            const SizedBox(height: 16),
            SegmentedButton<TeamType>(
              segments: [
                ButtonSegment(
                  value: TeamType.mixed,
                  label: Text(strings.teamTypeMixed),
                ),
                ButtonSegment(
                  value: TeamType.single,
                  label: Text(strings.teamTypeSingle),
                ),
              ],
              selected: {type},
              onSelectionChanged: (value) {
                setDialogState(() => type = value.single);
              },
            ),
          ],
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
          .read(teamRepositoryProvider)
          .saveTeam(id: team?.id, name: nameController.text, type: type);
    }
  } catch (error) {
    if (context.mounted) showError(context, error);
  } finally {
    nameController.dispose();
  }
}
