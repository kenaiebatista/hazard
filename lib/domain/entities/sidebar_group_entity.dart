import 'package:hazard/domain/entities/sidebar_item_entity.dart';
import 'package:flutter/material.dart';

class SidebarGroup {
  final String textCode;
  final String title;
  final IconData icon;
  final List<SidebarItem> items;

  const SidebarGroup({
    required this.textCode,
    required this.title,
    required this.icon,
    required this.items,
  });
}