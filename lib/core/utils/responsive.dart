import 'package:flutter/material.dart';

extension ResponsiveExtension on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < 700;

  bool get isTablet {
    final width = MediaQuery.of(this).size.width;
    return width >= 700 && width < 1100;
  }

  bool get isDesktop => MediaQuery.of(this).size.width >= 1100;
}