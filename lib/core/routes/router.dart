import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hazard/presentation/providers/auth_provider.dart';
import 'package:hazard/presentation/screens/login/login_screen.dart';
import 'package:hazard/presentation/screens/stock/stock_screen.dart';
import 'package:hazard/presentation/screens/product/product_screen.dart';
import 'package:hazard/presentation/screens/warehouse/warehouse_management_screen.dart';
import 'package:hazard/presentation/screens/warehouse/warehouse_screen.dart';
import 'package:hazard/presentation/screens/category/category_screen.dart';
import 'package:hazard/presentation/widgets/app_sidebar.dart';

GoRouter createAppRouter(AuthProvider authProvider) {
  return GoRouter(
    initialLocation: '/stock',
    refreshListenable: authProvider,
    routes: [
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SideBar(),
                      Expanded(child: child),
                    ],
                  ),
                ),
              ],
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
