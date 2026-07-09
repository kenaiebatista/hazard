import 'package:flutter/material.dart';
import 'package:hazard/domain/entities/movement_entity.dart';
import 'package:hazard/domain/enums/movement_type.dart';
import 'package:hazard/presentation/widgets/product_thumbnail.dart';

class MovementLeadingIndicator extends StatelessWidget {
  final MovementEntity movement;

  const MovementLeadingIndicator({super.key, required this.movement});

  @override
  Widget build(BuildContext context) {
    final isEntry = movement.type == MovementType.entry;

    return SizedBox(
      width: 56,
      height: 56,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ProductThumbnail(imageUrl: movement.product.imageUrl, size: 56),
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isEntry ? Colors.green : Colors.red,
                border: Border.all(
                  color: Theme.of(context).cardColor,
                  width: 1.5,
                ),
              ),
              child: Icon(
                isEntry ? Icons.arrow_downward : Icons.arrow_upward,
                size: 12,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
