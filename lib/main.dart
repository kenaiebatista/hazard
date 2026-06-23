import 'package:flutter/material.dart';
import 'package:hazard/core/routes/router.dart';
import 'core/theme/theme.dart';

void main() {
  runApp(Hazard());
}

class Hazard extends StatelessWidget {
  const Hazard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Login',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme.theme,
    );
  }
}
