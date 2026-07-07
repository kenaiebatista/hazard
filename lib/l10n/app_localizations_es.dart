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
    return 'Cant: $value';
  }
}
