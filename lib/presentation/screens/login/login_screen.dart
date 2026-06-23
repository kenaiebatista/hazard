import 'package:flutter/material.dart';
import 'package:hazard/presentation/widgets/cardForm.dart';
import 'package:hazard/presentation/widgets/leftPanel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Expanded(child: LeftPanel()),
            Expanded(child: Center(child: IntrinsicHeight(child: CardForm()))),
          ],
        ),
      ),
    );
  }
}
