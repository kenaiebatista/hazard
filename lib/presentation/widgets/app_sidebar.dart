import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hazard/core/theme/app_colors_theme.dart';
import 'package:hazard/core/utils/responsive.dart';
import 'package:hazard/domain/entities/sidebar_group_entity.dart';
import 'package:hazard/domain/entities/sidebar_item_entity.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/providers/auth_provider.dart';
import 'package:hazard/presentation/providers/sidebar_provider.dart';
import 'package:provider/provider.dart';

String _groupTitle(AppLocalizations l10n, String textCode) {
  switch (textCode) {
    case 'modulo1':
      return l10n.sidebarModuleWarehouse;
    case 'modulo2':
      return l10n.sidebarModuleStock;
    case 'modulo3':
      return l10n.sidebarModuleProduct;
    default:
      return textCode;
  }
}

// The sidebar always has a dark background, in both the light and dark app
// themes, so its accent must stay legible against dark navy even when
// Theme.primaryColor itself is a dark color (as it is in the light theme).
Color _sidebarAccentColor(BuildContext context) {
  final theme = Theme.of(context);
  return theme.brightness == Brightness.dark
      ? theme.primaryColor
      : AppColors.sidebarAccentLight;
}

String _itemTitle(AppLocalizations l10n, String textCode) {
  switch (textCode) {
    case 'warehouse':
      return l10n.navList;
    case 'warehouse_manage':
      return l10n.navManagement;
    case 'stock':
      return l10n.navStock;
    case 'product':
      return l10n.navProduct;
    case 'category':
      return l10n.navCategory;
    default:
      return textCode;
  }
}

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  Future<void> _handleLogout(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.logoutTitle),
        content: Text(l10n.logoutConfirmContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              l10n.logoutTitle,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<AuthProvider>().logout();
      context.go('/login');
    }
  }

  Widget _logoutButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _handleLogout(context),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(Icons.transit_enterexit, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sidebarColor = isDark
        ? Theme.of(context).cardColor
        : AppColors.sidebar;
    final isMobile = context.isMobile;

    return ChangeNotifierProvider(
      create: (context) => SideBarProvider(),
      child: Consumer<SideBarProvider>(
        builder: (_, state, _) {
          if (isMobile) {
            state.expanded = true;
            return Drawer(
              backgroundColor: sidebarColor,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final module in state.modules)
                      SidebarGroupWidget(module: module),
                    const Spacer(),
                    _logoutButton(context),
                  ],
                ),
              ),
            );
          }

          return MouseRegion(
            onEnter: (_) => setState(() => state.expanded = true),
            onExit: (_) {
              if (!state.pinned) setState(() => state.expanded = false);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: state.expanded ? 220 : 60,
              margin: EdgeInsets.all(8),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: sidebarColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: state.expanded
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(6),
                            onTap: () => state.togglePinned(),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Icon(
                                state.pinned
                                    ? Icons.push_pin
                                    : Icons.push_pin_outlined,
                                size: 18,
                                color: state.pinned
                                    ? _sidebarAccentColor(context)
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.white.withValues(alpha: 0.12),
                  ),
                  const SizedBox(height: 4),
                  for (final module in state.modules)
                    SidebarGroupWidget(module: module),
                  const Spacer(),
                  _logoutButton(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SidebarGroupWidget extends StatefulWidget {
  const SidebarGroupWidget({super.key, required this.module});

  final SidebarGroup module;

  @override
  State<SidebarGroupWidget> createState() => _SidebarGroupWidgetState();
}

class _SidebarGroupWidgetState extends State<SidebarGroupWidget> {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<SideBarProvider>(context);
    final currentLocation = GoRouterState.of(context).matchedLocation;
    final isGroupActive = widget.module.items.any(
      (item) => item.route == currentLocation,
    );
    final isExpanded =
        state.modulesExpanded[widget.module.textCode] ?? isGroupActive;
    final sidebarCollapsed = !state.expanded;
    final accentColor = _sidebarAccentColor(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final groupColor = isDark
        ? Theme.of(context).cardColor
        : AppColors.sidebarGroup;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: sidebarCollapsed ? 4 : 8,
        vertical: 4,
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: groupColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.06),
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: sidebarCollapsed ? 0 : 4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                child: InkWell(
                  onTap: () =>
                      state.changeExpandedModule(widget.module.textCode),
                  splashColor: Colors.white.withValues(alpha: 0.15),
                  highlightColor: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: sidebarCollapsed ? 0 : 6,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: sidebarCollapsed
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                      children: [
                        Icon(
                          widget.module.icon,
                          color: isGroupActive ? accentColor : Colors.white,
                        ),
                        if (state.expanded) ...[
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _groupTitle(
                                AppLocalizations.of(context),
                                widget.module.textCode,
                              ),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: isGroupActive
                                    ? accentColor
                                    : Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          AnimatedRotation(
                            turns: isExpanded ? 0.25 : 0.0,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            child: Icon(
                              Icons.chevron_right,
                              color: isGroupActive ? accentColor : Colors.white,
                              size: 16,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              ClipRect(
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: isExpanded
                        ? [
                            if (!sidebarCollapsed) ...[
                              Divider(
                                height: 1,
                                thickness: 1,
                                color: Colors.white.withValues(alpha: 0.12),
                              ),
                              const SizedBox(height: 4),
                            ],
                            for (final item in widget.module.items)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: SidebarItemWidget(item: item),
                              ),
                          ]
                        : [],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SidebarItemWidget extends StatefulWidget {
  const SidebarItemWidget({super.key, required this.item});

  final SidebarItem item;

  @override
  State<SidebarItemWidget> createState() => _SidebarItemWidgetState();
}

class _SidebarItemWidgetState extends State<SidebarItemWidget> {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<SideBarProvider>(context, listen: false);
    final currentLocation = GoRouterState.of(context).matchedLocation;
    final isActive = currentLocation == widget.item.route;
    final accentColor = _sidebarAccentColor(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectionColor = isDark
        ? Colors.white.withValues(alpha: 0.14)
        : accentColor.withValues(alpha: 0.2);
    final selectionBorderColor = isDark
        ? Colors.white.withValues(alpha: 0.24)
        : accentColor.withValues(alpha: 0.4);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          context.go(widget.item.route);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: state.expanded ? 6 : 2,
          ),
          decoration: BoxDecoration(
            color: isActive ? selectionColor : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: isActive
                ? Border.all(color: selectionBorderColor, width: 1)
                : null,
          ),
          child: Row(
            spacing: 8,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.item.icon,
                color: isActive ? accentColor : Colors.white,
              ),
              if (state.expanded)
                Flexible(
                  child: Text(
                    _itemTitle(
                      AppLocalizations.of(context),
                      widget.item.textCode,
                    ),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isActive ? accentColor : Colors.white,
                      fontWeight: isActive
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// class _SideBarState extends State<SideBar> {
//   @override
//   Widget build(BuildContext context) {
//   return Container(
//       color: AppColors.sidebar,
//       width: 280,
//       child: NavigationView(
//         pane: NavigationPane(
//           displayMode: PaneDisplayMode.expanded,
//           selected: 0,
//           items: SidebarMenu.groups.map((group) {
//             return PaneItemExpander(
//               icon: Icon(group.icon),
//               title: Text(group.title),
//               body: const SizedBox(),
//
//               items: group.items.map((item) {
//                 return PaneItem(
//                   icon: Icon(item.icon),
//                   title: Text(item.title),
//                   body: const SizedBox(),
//
//                   onTap: () {
//                     context.go(item.route);
//                   },
//                 );
//               }).toList(),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
