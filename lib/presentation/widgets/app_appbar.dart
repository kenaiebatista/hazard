import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/widgets/app_icon.dart';
import 'package:hazard/presentation/widgets/settings_dialog.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  String _resolveTitle(BuildContext context, String location) {
    final l10n = AppLocalizations.of(context);
    return {
          '/warehouse': l10n.navList,
          '/warehouse/management': l10n.navManagement,
          '/stock': l10n.navStock,
          '/product': l10n.navProduct,
          '/category': l10n.navCategory,
        }[location] ??
        '';
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final title = _resolveTitle(context, location);

    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      title: Row(
        spacing: 8,
        children: [
          MainIcon(),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          Spacer(),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints.tightFor(
                  width: 40,
                  height: 40,
                ),
                style: IconButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => const SettingsDialog(),
                ),
                icon: const Icon(Icons.settings, size: 26),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
