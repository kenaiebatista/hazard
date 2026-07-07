import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hazard/domain/entities/sidebar_group_entity.dart';
import 'package:hazard/domain/entities/sidebar_item_entity.dart';

class SideBarProvider extends ChangeNotifier {
  SideBarProvider() {
    _init();
  }

  final modules = <SidebarGroup>[];
  var expanded = false;

  final modulesExpanded = <String, bool>{};

  var selectedModule = '';

  void toggleSidebar() {
    expanded = !expanded;
    notifyListeners();
  }

  void changeExpandedModule(String key) {
    modulesExpanded[key] = !(modulesExpanded[key] ?? false);
    notifyListeners();
  }

  void _init() async {
    final json = {
      'modulo1': ['warehouse', 'warehouse_manage'],
      'modulo2': ['stock', 'product', 'category'],
    };

    for (final key in json.keys) {
      SidebarGroup? module;

      switch (key) {
        case 'modulo1':
          module = SidebarGroup(
            textCode: key,
            title: 'Armazém',
            icon: Icons.pie_chart_outline,
            items: [],
          );

          for (final item in json[key] ?? []) {
            String? itemName;
            String? itemRoute;
            IconData? itemIcon;

            switch (item) {
              case 'warehouse':
                itemName = 'Armazém';
                itemRoute = '/warehouse';
                itemIcon = Icons.warehouse;
                break;
              case 'warehouse_manage':
                itemName = 'Gestão';
                itemRoute = '/warehouse/management';
                itemIcon = Icons.manage_accounts_rounded;
                break;
            }

            if (itemRoute == null) {
              continue;
            }

            module.items.add(
              SidebarItem(
                textCode: item,
                title: itemName!,
                route: itemRoute,
                icon: itemIcon!,
              ),
            );
          }
          break;
        case 'modulo2':
          module = SidebarGroup(
            textCode: key,
            title: 'Categoria',
            icon: Icons.category_outlined,
            items: [],
          );

          for (final item in json[key] ?? []) {
            String? itemName;
            String? itemRoute;
            IconData? itemIcon;

            switch (item) {
              case 'stock':
                itemName = 'Estoque';
                itemRoute = '/stock';
                itemIcon = Icons.warehouse;
                break;
              case 'product':
                itemName = 'Produto';
                itemRoute = '/product';
                itemIcon = Icons.manage_accounts_rounded;
                break;
              case 'category':
                itemName = 'Categoria';
                itemRoute = '/category';
                itemIcon = Icons.manage_accounts_rounded;
                break;
            }

            if (itemRoute == null) {
              continue;
            }

            module.items.add(
              SidebarItem(
                textCode: item,
                title: itemName!,
                route: itemRoute,
                icon: itemIcon!,
              ),
            );
          }
          break;
      }

      if (module == null) {
        continue;
      }

      modules.add(module);
    }
  }
}