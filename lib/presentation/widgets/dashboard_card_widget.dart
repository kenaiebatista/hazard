import 'package:flutter/material.dart';
import 'package:hazard/core/utils/responsive.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 12 : 20),
        child: Row(
          children: [

            Icon(
              icon,
              size: isMobile ? 26 : 40,
              color: Colors.blue,
            ),

            SizedBox(width: isMobile ? 10 : 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [

                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: isMobile ? 12 : 16,
                      color: Colors.grey,
                    ),
                  ),

                  SizedBox(height: isMobile ? 4 : 8),

                  Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: isMobile ? 18 : 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}