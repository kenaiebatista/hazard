// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginWelcome => 'Welcome!';

  @override
  String get loginRegisterTitle => 'Register';

  @override
  String get loginFieldName => 'Name';

  @override
  String get loginFieldEmail => 'Email';

  @override
  String get loginFieldPassword => 'Password';

  @override
  String get loginFieldConfirmPassword => 'Confirm Password';

  @override
  String get loginButtonSignIn => 'Sign In';

  @override
  String get loginButtonRegister => 'Register';

  @override
  String get loginLinkHaveAccount => 'I already have an account';

  @override
  String get loginLinkRegister => 'Sign up';

  @override
  String get loginErrorInvalidCredentials => 'Incorrect email or password.';

  @override
  String get loginErrorEmailAlreadyRegistered =>
      'This email is already registered.';

  @override
  String get loginValidatorNameRequired => 'Enter your name';

  @override
  String get loginValidatorEmailRequired => 'Enter your email';

  @override
  String get loginValidatorEmailInvalid => 'Invalid email';

  @override
  String get loginValidatorPasswordRequired => 'Enter your password';

  @override
  String get loginValidatorPasswordMinLength => 'Minimum 6 characters';

  @override
  String get loginValidatorConfirmPasswordRequired => 'Confirm your password';

  @override
  String get loginValidatorPasswordMismatch => 'Passwords do not match';

  @override
  String get navList => 'List';

  @override
  String get navManagement => 'Management';

  @override
  String get navStock => 'Stock';

  @override
  String get navProduct => 'Product';

  @override
  String get navCategory => 'Category';

  @override
  String get warehouseTitle => 'Warehouse';

  @override
  String get warehouseEmpty => 'No warehouses registered.';

  @override
  String warehouseCapacity(int value) {
    return 'Cap: $value';
  }

  @override
  String get warehouseManageTitle => 'Manage Warehouse';

  @override
  String get sidebarModuleWarehouse => 'Warehouse';

  @override
  String get sidebarModuleCategory => 'Category';

  @override
  String get categoryTitle => 'Category';

  @override
  String get categoryEmpty => 'No categories registered.';

  @override
  String get productTitle => 'Product';

  @override
  String get productEmpty => 'No products registered.';

  @override
  String get stockTitle => 'Stock';

  @override
  String get stockEmpty => 'No products registered.';

  @override
  String stockSku(String value) {
    return 'SKU: $value';
  }

  @override
  String stockWarehouse(String value) {
    return 'Warehouse: $value';
  }

  @override
  String get stockWarehouseUnknown => 'Not allocated';

  @override
  String stockAmount(int value) {
    return 'Qty: $value';
  }
}
