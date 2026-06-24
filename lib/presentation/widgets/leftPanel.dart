import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hazard/presentation/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

class LeftPanel extends StatelessWidget {
  const LeftPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateChange>(context);
    return AnimatedContainer(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            if (state.change) ...const [
              Color(-15658620),
              Colors.lightBlueAccent,
            ] else ...const [
              Colors.lightBlueAccent,
              Color(-15658620),
            ],
          ],
        ),
      ),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
      width: 500,
    );
  }
}
