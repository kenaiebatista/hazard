import 'package:go_router/go_router.dart';
import 'package:hazard/presentation/screens/login/login_screen.dart';
import 'package:hazard/presentation/screens/stock/stock_screen.dart';
import 'package:hazard/presentation/screens/product/product_screen.dart';
import 'package:hazard/presentation/screens/warehouse/warehouse_screen.dart';
import 'package:hazard/presentation/screens/category/category_screen.dart';

bool loggedUser = false;

final appRouter = GoRouter(
  initialLocation: '/stock',

  redirect: (context, state) {
    final goingForLogin = state.matchedLocation == '/login';

    if (!loggedUser && !goingForLogin) {
      return '/login';
    }

    if (loggedUser && goingForLogin) {
      return '/stock';

    }
    return null;
  },

  routes: [
    GoRoute(path: '/stock', builder: (_, __) => const StockScreen()),
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/product', builder: (_, __) => const ProductScreen()),
    GoRoute(path: '/warehouse', builder: (_, __) => const WarehouseScreen()),
    GoRoute(path: '/category', builder: (_, __) => const CategoryScreen()),
  ],
);
