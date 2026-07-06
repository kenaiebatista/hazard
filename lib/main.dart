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
import 'package:hazard/domain/usecases/update_movement_usecase.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/providers/auth_provider.dart';
import 'package:hazard/presentation/providers/category_provider.dart';
import 'package:hazard/presentation/providers/movement_provider.dart';
import 'package:hazard/presentation/providers/product_provider.dart';
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
    ),
    getAllMovements: GetAllMovements(movementRepository),
    updateMovement: UpdateMovementUseCase(
      movementRepository: movementRepository,
      productRepository: productRepository,
    ),
    removeMovement: RemoveMovementUseCase(
      movementRepository: movementRepository,
      productRepository: productRepository,
    ),
  );

  runApp(Hazard(
    router: router,
    authProvider: authProvider,
    warehouseProvider: warehouseProvider,
    categoryProvider: categoryProvider,
    productProvider: productProvider,
    movementProvider: movementProvider,
  ));
}

class Hazard extends StatelessWidget {
  final GoRouter router;
  final AuthProvider authProvider;
  final WarehouseProvider warehouseProvider;
  final CategoryProvider categoryProvider;
  final ProductProvider productProvider;
  final MovementProvider movementProvider;

  const Hazard({
    super.key,
    required this.router,
    required this.authProvider,
    required this.warehouseProvider,
    required this.categoryProvider,
    required this.productProvider,
    required this.movementProvider,
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
      ],
      child: MaterialApp.router(
        title: 'Hazard',
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: AppTheme.theme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
