import 'package:flutter/material.dart';

class IconSquareWidget extends StatelessWidget {
  const IconSquareWidget({super.key, required this.icon, this.size = 56});

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        size: size * 0.55,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
