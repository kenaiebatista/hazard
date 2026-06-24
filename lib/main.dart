import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hazard/core/routes/router.dart';
import 'package:hazard/presentation/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'core/theme/theme.dart';

void main() {
  final authProvider = AuthProvider();
  final router = createAppRouter(authProvider);
  runApp(Hazard(router: router, authProvider: authProvider));
}

class Hazard extends StatelessWidget {
  final GoRouter router;
  final AuthProvider authProvider;

  const Hazard({super.key, required this.router, required this.authProvider});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
      ],
      child: MaterialApp.router(
        title: 'Login',
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: AppTheme.theme,
      ),
    );
  }
}
