import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/providers/settings_provider.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final l10n = AppLocalizations.of(context);

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.settingsTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                l10n.settingsLanguage,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              RadioGroup<Locale>(
                groupValue: settings.locale,
                onChanged: (locale) {
                  if (locale != null) settings.setLocale(locale);
                },
                child: Column(
                  children: [
                    RadioListTile<Locale>(
                      contentPadding: EdgeInsets.zero,
                      title: Text(l10n.settingsLanguagePortuguese),
                      value: const Locale('pt'),
                    ),
                    RadioListTile<Locale>(
                      contentPadding: EdgeInsets.zero,
                      title: Text(l10n.settingsLanguageEnglish),
                      value: const Locale('en'),
                    ),
                    RadioListTile<Locale>(
                      contentPadding: EdgeInsets.zero,
                      title: Text(l10n.settingsLanguageSpanish),
                      value: const Locale('es'),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.settingsDarkTheme,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Switch(
                    value: settings.isDarkMode,
                    onChanged: settings.setDarkMode,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
