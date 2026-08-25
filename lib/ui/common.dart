import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models.dart';
import '../providers.dart';

String teamTypeLabel(TeamType value) => switch (value) {
  TeamType.mixed => '混合组',
  TeamType.single => '单一性别组',
};

String genderLabel(PlayerGender value) => switch (value) {
  PlayerGender.male => '男',
  PlayerGender.female => '女',
};

String positionLabel(PlayerPosition value) => switch (value) {
  PlayerPosition.cutter => '接盘手',
  PlayerPosition.handler => '持盘手',
  PlayerPosition.any => '不限',
};

String modeLabel(PossessionMode value) => switch (value) {
  PossessionMode.offense => '进攻',
  PossessionMode.defense => '防守',
};

String ratioLabel(GenderRatio value) => switch (value) {
  GenderRatio.fourMale => '4男 / 3女',
  GenderRatio.fourFemale => '3男 / 4女',
};

String gameStatusLabel(GameStatus value) => switch (value) {
  GameStatus.draft => '未开始',
  GameStatus.inProgress => '记录中',
  GameStatus.completed => '已结束',
};

String playerLabel(GamePlayerSnapshot? player, {String fallback = '未知球员'}) {
  if (player == null) return fallback;
  final number = player.number;
  return number == null ? player.name : '#$number ${player.name}';
}

String participantLabel(GameBundle bundle, String? participantId) {
  if (participantId == null) return '—';
  final participant = bundle.participant(participantId);
  if (participant == null || participant.unknown) return '未知球员';
  return playerLabel(bundle.participantSnapshot(participantId));
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
    return EmptyState(icon: Icons.error_outline, message: '加载失败：$error');
  }
}

class StatsTable extends StatelessWidget {
  const StatsTable({required this.stats, required this.nameForId, super.key});

  final Map<String, PlayerStats> stats;
  final String Function(String id) nameForId;

  @override
  Widget build(BuildContext context) {
    if (stats.isEmpty) {
      return const EmptyState(
        icon: Icons.table_chart_outlined,
        message: '还没有可统计的数据。',
      );
    }
    final entries = stats.entries.toList()
      ..sort((a, b) => nameForId(a.key).compareTo(nameForId(b.key)));
    return Scrollbar(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('球员')),
            DataColumn(numeric: true, label: Text('上场分')),
            DataColumn(numeric: true, label: Text('得分')),
            DataColumn(numeric: true, label: Text('助攻')),
            DataColumn(numeric: true, label: Text('D')),
            DataColumn(numeric: true, label: Text('失误')),
            DataColumn(numeric: true, label: Text('触盘')),
            DataColumn(numeric: true, label: Text('接盘')),
            DataColumn(numeric: true, label: Text('传盘')),
            DataColumn(numeric: true, label: Text('接盘失误')),
            DataColumn(numeric: true, label: Text('传盘失误')),
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
  String confirmLabel = '确认',
  bool destructive = false,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('取消'),
            ),
            FilledButton(
              style: destructive
                  ? FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                    )
                  : null,
              onPressed: () => Navigator.pop(context, true),
              child: Text(confirmLabel),
            ),
          ],
        ),
      ) ??
      false;
}

void showError(BuildContext context, Object error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(error.toString().replaceFirst('Bad state: ', ''))),
  );
}

Future<void> runExport(
  BuildContext context,
  WidgetRef ref,
  ExportScope scope,
) async {
  try {
    final delivered = await ref
        .read(exportServiceProvider)
        .buildAndDeliver(scope);
    if (context.mounted && delivered) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('导出文件已生成。')));
    }
  } catch (error) {
    if (context.mounted) showError(context, error);
  }
}

class ExportAllButton extends ConsumerWidget {
  const ExportAllButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      tooltip: '导出全部数据',
      onPressed: () => runExport(context, ref, const ExportScope.all()),
      icon: const Icon(Icons.ios_share),
    );
  }
}
