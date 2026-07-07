import 'package:flutter/material.dart';

class SidebarItem {
  final String textCode;
  final String title;
  final String route;
  final IconData icon;

  const SidebarItem({
    required this.textCode,
    required this.title,
    required this.route,
    required this.icon,
  });
}