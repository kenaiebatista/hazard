// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get loginWelcome => '¡Bienvenido!';

  @override
  String get loginRegisterTitle => 'Regístrate';

  @override
  String get loginFieldName => 'Nombre';

  @override
  String get loginFieldEmail => 'Correo';

  @override
  String get loginFieldPassword => 'Contraseña';

  @override
  String get loginFieldConfirmPassword => 'Confirmar Contraseña';

  @override
  String get loginButtonSignIn => 'Iniciar sesión';

  @override
  String get loginButtonRegister => 'Registrarse';

  @override
  String get loginLinkHaveAccount => 'Ya tengo una cuenta';

  @override
  String get loginLinkRegister => 'Regístrate';

  @override
  String get loginErrorInvalidCredentials => 'Correo o contraseña incorrectos.';

  @override
  String get loginErrorEmailAlreadyRegistered =>
      'Este correo ya está registrado.';

  @override
  String get loginValidatorNameRequired => 'Ingresa tu nombre';

  @override
  String get loginValidatorEmailRequired => 'Ingresa tu correo';

  @override
  String get loginValidatorEmailInvalid => 'Correo inválido';

  @override
  String get loginValidatorPasswordRequired => 'Ingresa tu contraseña';

  @override
  String get loginValidatorPasswordMinLength => 'Mínimo 6 caracteres';

  @override
  String get loginValidatorConfirmPasswordRequired => 'Confirma tu contraseña';

  @override
  String get loginValidatorPasswordMismatch => 'Las contraseñas no coinciden';

  @override
  String get navList => 'Lista';

  @override
  String get navManagement => 'Gestión';

  @override
  String get navStock => 'Inventario';

  @override
  String get navProduct => 'Producto';

  @override
  String get navCategory => 'Categoría';

  @override
  String get warehouseTitle => 'Almacén';

  @override
  String get warehouseEmpty => 'No hay almacenes registrados.';

  @override
  String warehouseCapacity(int value) {
    return 'Capacidad: $value';
  }

  @override
  String get warehouseManageTitle => 'Gestionar Almacén';

  @override
  String get sidebarModuleWarehouse => 'Almacén';

  @override
  String get sidebarModuleCategory => 'Categoría';

  @override
  String get categoryTitle => 'Categoría';

  @override
  String get categoryEmpty => 'No hay categorías registradas.';

  @override
  String get productTitle => 'Producto';

  @override
  String get productEmpty => 'No hay productos registrados.';

  @override
  String get stockTitle => 'Inventario';

  @override
  String get stockEmpty => 'No hay productos registrados.';

  @override
  String stockSku(String value) {
    return 'SKU: $value';
  }

  @override
  String stockWarehouse(String value) {
    return 'Almacén: $value';
  }

  @override
  String get stockWarehouseUnknown => 'No asignado';

  @override
  String stockAmount(int value) {
    return 'Cantidad: $value';
  }

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguagePortuguese => 'Português';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageSpanish => 'Español';

  @override
  String get settingsDarkTheme => 'Tema oscuro';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonUpdate => 'Actualizar';

  @override
  String get commonNameLabel => 'Nombre';

  @override
  String get commonDescriptionLabel => 'Descripción';

  @override
  String get commonValidatorNameRequired => 'Ingresa el nombre';

  @override
  String get commonValidatorDescriptionRequired => 'Ingresa la descripción';

  @override
  String get commonSubcategoryLabel => 'Subcategoría';

  @override
  String commonListOf(String value) {
    return 'Lista de $value';
  }

  @override
  String get commonUnexpectedError =>
      'Ocurrió un error inesperado. Inténtalo de nuevo.';

  @override
  String get categoryRegisterEditTitle => 'Editar Categoría';

  @override
  String get categoryRegisterNewTitle => 'Nueva Categoría';

  @override
  String categorySaveErrorPrefix(String error) {
    return 'Error al guardar la categoría: $error';
  }

  @override
  String get categoryNoSubcategoryAdded => 'Ninguna subcategoría agregada';

  @override
  String get categoryDeleteTitle => 'Eliminar categorías';

  @override
  String categoryDeleteContent(int count) {
    return '¿Deseas eliminar $count categoría(s) seleccionada(s)?';
  }

  @override
  String categorySubcategoriesCount(int count) {
    return '$count subcategorías';
  }

  @override
  String get categoryNoSubcategoryRegistered =>
      'No hay subcategorías registradas';

  @override
  String get productRegisterEditTitle => 'Editar Producto';

  @override
  String get productRegisterNewTitle => 'Nuevo Producto';

  @override
  String productSaveErrorPrefix(String error) {
    return 'Error al guardar el producto: $error';
  }

  @override
  String get productSkuLabel => 'SKU';

  @override
  String get productValidatorSkuRequired => 'Ingresa el SKU';

  @override
  String get productCategoryLabel => 'Categoría';

  @override
  String get productValidatorCategoryRequired => 'Selecciona una categoría';

  @override
  String get productValidatorSubcategoryRequired =>
      'Selecciona una subcategoría';

  @override
  String get productValidatorWarehouseRequired => 'Selecciona un almacén';

  @override
  String get productImageUrlLabel => 'URL de la Foto';

  @override
  String get productValidatorImageUrlInvalid => 'Ingresa una URL válida';

  @override
  String get productDeleteTitle => 'Eliminar productos';

  @override
  String productDeleteContent(int count) {
    return '¿Deseas eliminar $count producto(s) seleccionado(s)?';
  }

  @override
  String productSubtitle(String sku, String description) {
    return 'SKU: $sku • $description';
  }

  @override
  String productQuantityShort(int amount) {
    return 'Cant: $amount';
  }

  @override
  String get warehouseDeleteTitle => 'Eliminar almacenes';

  @override
  String warehouseDeleteContent(int count) {
    return '¿Deseas eliminar $count almacén(es) seleccionado(s)?';
  }

  @override
  String get warehouseEditTitle => 'Editar Almacén';

  @override
  String get warehouseNewTitle => 'Nuevo Almacén';

  @override
  String get warehouseCepLabel => 'Código Postal';

  @override
  String get warehouseCepDigitsError => 'El código postal debe tener 8 dígitos';

  @override
  String get warehouseCepNotFound => 'Código postal no encontrado';

  @override
  String get warehouseCepSearchError => 'Error al buscar el código postal';

  @override
  String warehouseSaveErrorPrefix(String error) {
    return 'Error al guardar el almacén: $error';
  }

  @override
  String get warehouseValidatorCepInvalid => 'Ingresa un código postal válido';

  @override
  String get warehouseStreetLabel => 'Calle';

  @override
  String get warehouseValidatorStreetRequired => 'Ingresa la calle';

  @override
  String get warehouseNumberLabel => 'Número';

  @override
  String get warehouseComplementLabel => 'Complemento';

  @override
  String get warehouseNeighborhoodLabel => 'Barrio';

  @override
  String get warehouseValidatorNeighborhoodRequired => 'Ingresa el barrio';

  @override
  String get warehouseCityLabel => 'Ciudad';

  @override
  String get warehouseValidatorCityRequired => 'Ingresa la ciudad';

  @override
  String get warehouseStateLabel => 'Provincia';

  @override
  String get warehouseCapacityLabel => 'Capacidad';

  @override
  String get warehouseValidatorCapacityRequired =>
      'Ingresa una capacidad válida';

  @override
  String get warehouseCancelEdit => 'Cancelar edición';

  @override
  String get dashboardTotalStock => 'Inventario Total';

  @override
  String get dashboardEntries7Days => 'Entradas (7 días)';

  @override
  String get dashboardExits7Days => 'Salidas (7 días)';

  @override
  String get dashboardReturns => 'Devoluciones';

  @override
  String get dashboardNoCategory => 'Sin categoría';

  @override
  String get dashboardRecentMovementsTitle => 'Últimos Movimientos';

  @override
  String get logoutTitle => 'Cerrar sesión';

  @override
  String get logoutConfirmContent => '¿Realmente deseas cerrar sesión?';

  @override
  String get movementDialogTitle => 'Movimientos de Inventario';

  @override
  String get movementAddTitle => 'Agregar Movimiento';

  @override
  String get movementEditTitle => 'Editar Movimiento';

  @override
  String get movementRemoveTitle => 'Eliminar Movimiento';

  @override
  String get movementReturnTitle => 'Devolver Movimiento';

  @override
  String get movementActionAdd => 'Agregar';

  @override
  String get movementActionEdit => 'Editar';

  @override
  String get movementActionRemove => 'Eliminar';

  @override
  String get movementActionReturn => 'Devolver';

  @override
  String get movementTypeEntry => 'Entrada';

  @override
  String get movementTypeExit => 'Salida';

  @override
  String get movementDetailsTitle => 'Detalles del Movimiento';

  @override
  String get movementTypeLabel => 'Tipo';

  @override
  String get movementNoDescription => 'Sin descripción';

  @override
  String get movementValidatorProductRequired => 'Selecciona un producto';

  @override
  String get movementDateLabel => 'Fecha';

  @override
  String get movementQuantityLabel => 'Cantidad';

  @override
  String get movementValidatorQuantityRequired => 'Ingresa una cantidad válida';

  @override
  String movementSaveErrorPrefix(String error) {
    return 'Error al guardar el movimiento: $error';
  }

  @override
  String get movementDeleteTitle => 'Eliminar movimiento';

  @override
  String movementDeleteContent(String name) {
    return '¿Deseas eliminar el movimiento de \"$name\"?';
  }

  @override
  String movementDeleteErrorPrefix(String error) {
    return 'Error al eliminar el movimiento: $error';
  }

  @override
  String get movementReturnConfirmTitle => 'Devolver movimiento';

  @override
  String movementReturnConfirmContent(int quantity, String name) {
    return '¿Deseas devolver $quantity unidad(es) de \"$name\" al inventario?';
  }

  @override
  String movementReturnErrorPrefix(String error) {
    return 'Error al devolver el movimiento: $error';
  }

  @override
  String get movementReturnEmptyList =>
      'No hay movimientos de salida disponibles para devolución.';

  @override
  String get movementEmptyList => 'No hay movimientos registrados.';

  @override
  String get movementQtyInlineLabel => 'Cant';

  @override
  String get movementReturnedTag => 'Devuelta';

  @override
  String get chartNoProductsRegistered => 'No hay productos registrados';

  @override
  String get chartCategoryTitle => 'Inventario por Categoría';

  @override
  String get chartMovementTitle => 'Entradas x Salidas';

  @override
  String get chartMovementEntriesLegend => 'Entradas';

  @override
  String get chartMovementExitsLegend => 'Salidas';

  @override
  String get chartWarehouseTitle => 'Productos por Almacén';

  @override
  String get weekdayMon => 'Lun';

  @override
  String get weekdayTue => 'Mar';

  @override
  String get weekdayWed => 'Mié';

  @override
  String get weekdayThu => 'Jue';

  @override
  String get weekdayFri => 'Vie';

  @override
  String get weekdaySat => 'Sáb';

  @override
  String get weekdaySun => 'Dom';

  @override
  String get errorProductNotFound => 'Producto no encontrado.';

  @override
  String errorInsufficientStock(String product, int available, int requested) {
    return 'Inventario insuficiente para \"$product\": disponible $available, solicitado $requested.';
  }

  @override
  String get errorEmailAlreadyRegistered => 'Este correo ya está registrado.';

  @override
  String get errorMovementAlreadyReturnedRemove =>
      'No es posible eliminar un movimiento ya devuelto.';

  @override
  String get errorOnlyExitCanBeReturned =>
      'Solo los movimientos de salida pueden ser devueltos.';

  @override
  String get errorMovementAlreadyReturned =>
      'Este movimiento ya ha sido devuelto.';

  @override
  String get errorMovementAlreadyReturnedEdit =>
      'No es posible editar un movimiento ya devuelto.';

  @override
  String get errorCepLookupFailed =>
      'No fue posible buscar el código postal indicado.';

  @override
  String errorWarehouseCapacityExceeded(
    String warehouse,
    int capacity,
    int total,
  ) {
    return 'Se excedería la capacidad del almacén \"$warehouse\": capacidad $capacity, total después del movimiento $total.';
  }
}
