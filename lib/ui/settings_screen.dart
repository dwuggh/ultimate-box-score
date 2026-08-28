import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models.dart';
import '../l10n/app_localizations.dart';
import '../providers.dart';
import 'common.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  onChanged: (value) async {
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
              ],
            ),
          ),
    );
  }
}
