import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:hazard/core/utils/responsive.dart';
import 'package:hazard/presentation/providers/auth_provider.dart';
import 'package:hazard/presentation/screens/login/login_screen.dart';
import 'package:hazard/presentation/screens/stock/stock_screen.dart';
import 'package:hazard/presentation/screens/product/product_screen.dart';
import 'package:hazard/presentation/screens/warehouse/warehouse_management_screen.dart';
import 'package:hazard/presentation/screens/warehouse/warehouse_screen.dart';
import 'package:hazard/presentation/screens/category/category_screen.dart';
import 'package:hazard/presentation/widgets/app_sidebar.dart';

GoRouter createAppRouter(AuthProvider authProvider) {
  final shellScaffoldKey = GlobalKey<ScaffoldState>();

  return GoRouter(
    initialLocation: '/stock',
    refreshListenable: authProvider,
    routes: [
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
      ShellRoute(
        builder: (context, state, child) {
          final isMobile = context.isMobile;

          return Provider<GlobalKey<ScaffoldState>>.value(
            value: shellScaffoldKey,
            child: Scaffold(
              key: shellScaffoldKey,
              drawer: isMobile ? SideBar() : null,
              body: isMobile
                  ? child
                  : Row(
                      children: [
                        SideBar(),
                        Expanded(child: child),
                      ],
                    ),
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/stock',
            builder: (_, _) {
              return const StockScreen();
            },
          ),
          GoRoute(
            path: '/product',
            builder: (_, _) {
              return const ProductScreen();
            },
          ),
          GoRoute(
            path: '/category',
            builder: (_, _) {
              return const CategoryScreen();
            },
          ),
          GoRoute(
            path: '/warehouse',
            builder: (_, _) => const WarehouseScreen(),
          ),
          GoRoute(
            path: '/warehouse/management',
            builder: (_, _) {
              return WarehouseManagementScreen();
            },
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final goingForLogin = state.matchedLocation == '/login';

      if (!authProvider.isAuthenticated && !goingForLogin) {
        return '/login';
      }

      if (authProvider.isAuthenticated && goingForLogin) {
        return '/stock';
      }

      return null;
    },
  );
}
