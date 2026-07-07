import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hazard/core/theme/app_colors_theme.dart';
import 'package:hazard/domain/entities/sidebar_group_entity.dart';
import 'package:hazard/domain/entities/sidebar_item_entity.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/providers/sidebar_provider.dart';
import 'package:provider/provider.dart';

String _groupTitle(AppLocalizations l10n, String textCode) {
  switch (textCode) {
    case 'modulo1':
      return l10n.sidebarModuleWarehouse;
    case 'modulo2':
      return l10n.sidebarModuleCategory;
    default:
      return textCode;
  }
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
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SideBarProvider(),
      child: Consumer<SideBarProvider>(
        builder: (_, state, _) {
          return MouseRegion(
            onEnter: (_) => setState(() => state.expanded = true),
            onExit: (_) => setState(() => state.expanded = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: state.expanded ? 220 : 60,
              margin: EdgeInsets.all(8),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: AppColors.sidebar,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final module in state.modules)
                    SidebarGroupWidget(module: module),
                  const Spacer(),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: state.toggleSidebar,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Icon(
                          state.expanded
                              ? Icons.chevron_left
                              : Icons.chevron_right,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
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
    final isExpanded = state.modulesExpanded[widget.module.textCode] ?? false;
    final sidebarCollapsed = !state.expanded;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: sidebarCollapsed ? 4 : 8,
        vertical: 4,
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.sidebarGroup,
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
                        Icon(widget.module.icon, color: Colors.white),
                        if (state.expanded) ...[
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _groupTitle(
                                AppLocalizations.of(context),
                                widget.module.textCode,
                              ),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          AnimatedRotation(
                            turns: isExpanded ? 0.25 : 0.0,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            child: const Icon(
                              Icons.chevron_right,
                              color: Colors.white,
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
            color: isActive ? AppColors.sidebarItemActive : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: isActive
                ? Border.all(
                    color: AppColors.sidebarAccent.withValues(alpha: 0.4),
                    width: 1,
                  )
                : null,
          ),
          child: Row(
            spacing: 8,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.item.icon,
                color: isActive ? AppColors.sidebarAccent : Colors.white,
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
                      color: isActive ? AppColors.sidebarAccent : Colors.white,
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
