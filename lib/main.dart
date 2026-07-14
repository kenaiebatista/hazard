import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hazard/core/routes/router.dart';
import 'package:hazard/data/repositories/category_repository_impl.dart';
import 'package:hazard/data/repositories/movement_repository_impl.dart';
import 'package:hazard/data/repositories/product_repository_impl.dart';
import 'package:hazard/data/repositories/user_repository_impl.dart';
import 'package:hazard/data/repositories/warehouse_repository_impl.dart';
import 'package:hazard/domain/usecases/create_category_usecase.dart';
import 'package:hazard/domain/usecases/create_movement_usecase.dart';
import 'package:hazard/domain/usecases/create_product_usecase.dart';
import 'package:hazard/domain/usecases/create_warehouse_usecase.dart';
import 'package:hazard/domain/usecases/get_all_category_usecase.dart';
import 'package:hazard/domain/usecases/get_all_movements_usecase.dart';
import 'package:hazard/domain/usecases/get_all_product_usecase.dart';
import 'package:hazard/domain/usecases/get_all_warehouse_usecase.dart';
import 'package:hazard/domain/usecases/login_usecase.dart';
import 'package:hazard/domain/usecases/register_user_usecase.dart';
import 'package:hazard/domain/usecases/remove_category_usecase.dart';
import 'package:hazard/domain/usecases/remove_movement_usecase.dart';
import 'package:hazard/domain/usecases/remove_product_usecase.dart';
import 'package:hazard/domain/usecases/remove_warehouse_usecase.dart';
import 'package:hazard/domain/usecases/return_movement_usecase.dart';
import 'package:hazard/domain/usecases/update_movement_usecase.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/providers/auth_provider.dart';
import 'package:hazard/presentation/providers/category_provider.dart';
import 'package:hazard/presentation/providers/dashboard_provider.dart';
import 'package:hazard/presentation/providers/movement_provider.dart';
import 'package:hazard/presentation/providers/product_provider.dart';
import 'package:hazard/presentation/providers/settings_provider.dart';
import 'package:hazard/presentation/providers/warehouse_provider.dart';
import 'package:provider/provider.dart';
import 'core/theme/theme.dart';

void main() {
  final userRepository = UserRepositoryImpl();
  final authProvider = AuthProvider(
    login: LoginUsecase(userRepository),
    registerUser: RegisterUserUsecase(userRepository),
  );
  final router = createAppRouter(authProvider);

  final warehouseRepository = WarehouseRepositoryImpl();
  final warehouseProvider = WarehouseProvider(
    createWarehouse: CreateWarehouseUsecase(warehouseRepository),
    getAllWarehouses: GetAllWarehouses(warehouseRepository),
    removeWarehouse: RemoveWarehouse(warehouseRepository),
  );

  final categoryRepository = CategoryRepositoryImpl();
  final categoryProvider = CategoryProvider(
    createCategory: CreateCategoryUsecase(categoryRepository),
    getAllCategories: GetAllCategories(categoryRepository),
    removeCategory: RemoveCategory(categoryRepository),
  );

  final productRepository = ProductRepositoryImpl();
  final productProvider = ProductProvider(
    createProduct: CreateProductUsecase(productRepository),
    getAllProducts: GetAllProducts(productRepository),
    removeProduct: RemoveProduct(productRepository),
  );

  final movementRepository = MovementRepositoryImpl();
  final movementProvider = MovementProvider(
    createMovement: CreateMovementUseCase(
      movementRepository: movementRepository,
      productRepository: productRepository,
      warehouseRepository: warehouseRepository,
    ),
    getAllMovements: GetAllMovements(movementRepository),
    updateMovement: UpdateMovementUseCase(
      movementRepository: movementRepository,
      productRepository: productRepository,
      warehouseRepository: warehouseRepository,
    ),
    removeMovement: RemoveMovementUseCase(
      movementRepository: movementRepository,
      productRepository: productRepository,
    ),
    returnMovement: ReturnMovementUseCase(
      movementRepository: movementRepository,
      productRepository: productRepository,
    ),
  );

  final dashboardProvider = DashboardProvider(
    getAllProducts: GetAllProducts(productRepository),
    getAllCategories: GetAllCategories(categoryRepository),
    getAllWarehouses: GetAllWarehouses(warehouseRepository),
    getAllMovements: GetAllMovements(movementRepository),
  );

  final settingsProvider = SettingsProvider();

  runApp(Hazard(
    router: router,
    authProvider: authProvider,
    warehouseProvider: warehouseProvider,
    categoryProvider: categoryProvider,
    productProvider: productProvider,
    movementProvider: movementProvider,
    dashboardProvider: dashboardProvider,
    settingsProvider: settingsProvider,
  ));
}

class Hazard extends StatelessWidget {
  final GoRouter router;
  final AuthProvider authProvider;
  final WarehouseProvider warehouseProvider;
  final CategoryProvider categoryProvider;
  final ProductProvider productProvider;
  final MovementProvider movementProvider;
  final DashboardProvider dashboardProvider;
  final SettingsProvider settingsProvider;

  const Hazard({
    super.key,
    required this.router,
    required this.authProvider,
    required this.warehouseProvider,
    required this.categoryProvider,
    required this.productProvider,
    required this.movementProvider,
    required this.dashboardProvider,
    required this.settingsProvider,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider.value(value: warehouseProvider),
        ChangeNotifierProvider.value(value: categoryProvider),
        ChangeNotifierProvider.value(value: productProvider),
        ChangeNotifierProvider.value(value: movementProvider),
        ChangeNotifierProvider.value(value: dashboardProvider),
        ChangeNotifierProvider.value(value: settingsProvider),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return MaterialApp.router(
            title: 'StockFlow',
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            theme: AppTheme.theme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settings.themeMode,
            locale: settings.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}
