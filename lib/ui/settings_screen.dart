import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/import_service.dart';
import '../domain/models.dart';
import '../l10n/app_localizations.dart';
import '../providers.dart';
import 'common.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  var _busy = false;

  Future<void> _importBackup() async {
    setState(() => _busy = true);
    try {
      final candidate = await ref.read(importServiceProvider).chooseBackup();
      if (candidate == null || !mounted) return;
      final confirmed = await _confirmImport(candidate.preview);
      if (!confirmed || !mounted) return;
      await ref.read(importServiceProvider).restore(candidate.bytes);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).backupImported)),
        );
      }
    } catch (error) {
      if (mounted) showError(context, error);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<bool> _confirmImport(BackupPreview preview) async {
    final strings = AppLocalizations.of(context);
    final date = preview.exportedAt.toLocal().toString();
    final summary = strings.importBackupSummary(
      date,
      preview.teamCount,
      preview.playerCount,
      preview.eventCount,
      preview.gameCount,
      preview.actionCount,
    );
    return confirmDialog(
      context,
      title: strings.importBackupTitle,
      message: '$summary\n\n${strings.importBackupWarning}',
      confirmLabel: strings.restoreBackup,
      destructive: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(strings.settings)),
      body: ref
          .watch(appLanguagePreferenceProvider)
          .when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => ErrorState(error),
            data: (language) => ListView(
              padding: const EdgeInsets.all(16),
              children: [
                DropdownButtonFormField<AppLanguagePreference>(
                  initialValue: language,
                  decoration: InputDecoration(labelText: strings.language),
                  items: [
                    DropdownMenuItem(
                      value: AppLanguagePreference.system,
                      child: Text(strings.followSystem),
                    ),
                    DropdownMenuItem(
                      value: AppLanguagePreference.english,
                      child: Text(strings.languageEnglish),
                    ),
                    DropdownMenuItem(
                      value: AppLanguagePreference.simplifiedChinese,
                      child: Text(strings.languageSimplifiedChinese),
                    ),
                  ],
                  onChanged: _busy
                      ? null
                      : (value) async {
                          if (value == null || value == language) return;
                          try {
                            await ref
                                .read(settingsRepositoryProvider)
                                .setLanguagePreference(value);
                          } catch (error) {
                            if (context.mounted) showError(context, error);
                          }
                        },
                ),
                const SizedBox(height: 24),
                Text(
                  strings.dataManagement,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.backup_outlined),
                        title: Text(strings.exportBackup),
                        subtitle: Text(strings.exportBackupDescription),
                        enabled: !_busy,
                        onTap: _busy
                            ? null
                            : () => runExport(
                                context,
                                ref,
                                const ExportScope.all(),
                              ),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.restore_page_outlined),
                        title: Text(strings.importBackup),
                        subtitle: Text(strings.importBackupDescription),
                        enabled: !_busy,
                        onTap: _busy ? null : _importBackup,
                      ),
                    ],
                  ),
                ),
                if (_busy) ...[
                  const SizedBox(height: 12),
                  const LinearProgressIndicator(),
                ],
              ],
            ),
          ),
    );
  }
}
