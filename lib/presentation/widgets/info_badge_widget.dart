import 'package:flutter/material.dart';

class InfoBadgeWidget extends StatelessWidget {
  const InfoBadgeWidget({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).primaryColor),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}
