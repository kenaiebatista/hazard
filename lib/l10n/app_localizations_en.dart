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
    return 'Capacity: $value';
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
    return 'Quantity: $value';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguagePortuguese => 'Português';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageSpanish => 'Español';

  @override
  String get settingsDarkTheme => 'Dark theme';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonSave => 'Save';

  @override
  String get commonUpdate => 'Update';

  @override
  String get commonNameLabel => 'Name';

  @override
  String get commonDescriptionLabel => 'Description';

  @override
  String get commonValidatorNameRequired => 'Enter the name';

  @override
  String get commonValidatorDescriptionRequired => 'Enter the description';

  @override
  String get commonSubcategoryLabel => 'Subcategory';

  @override
  String commonListOf(String value) {
    return '$value list';
  }

  @override
  String get commonUnexpectedError =>
      'An unexpected error occurred. Please try again.';

  @override
  String get categoryRegisterEditTitle => 'Edit Category';

  @override
  String get categoryRegisterNewTitle => 'New Category';

  @override
  String categorySaveErrorPrefix(String error) {
    return 'Error saving category: $error';
  }

  @override
  String get categoryNoSubcategoryAdded => 'No subcategory added';

  @override
  String get categoryDeleteTitle => 'Delete categories';

  @override
  String categoryDeleteContent(int count) {
    return 'Do you want to delete $count selected category/categories?';
  }

  @override
  String categorySubcategoriesCount(int count) {
    return '$count subcategories';
  }

  @override
  String get categoryNoSubcategoryRegistered => 'No subcategories registered';

  @override
  String get productRegisterEditTitle => 'Edit Product';

  @override
  String get productRegisterNewTitle => 'New Product';

  @override
  String productSaveErrorPrefix(String error) {
    return 'Error saving product: $error';
  }

  @override
  String get productSkuLabel => 'SKU';

  @override
  String get productValidatorSkuRequired => 'Enter the SKU';

  @override
  String get productCategoryLabel => 'Category';

  @override
  String get productValidatorCategoryRequired => 'Select a category';

  @override
  String get productValidatorSubcategoryRequired => 'Select a subcategory';

  @override
  String get productValidatorWarehouseRequired => 'Select a warehouse';

  @override
  String get productImageUrlLabel => 'Photo URL';

  @override
  String get productValidatorImageUrlInvalid => 'Enter a valid URL';

  @override
  String get productDeleteTitle => 'Delete products';

  @override
  String productDeleteContent(int count) {
    return 'Do you want to delete $count selected product(s)?';
  }

  @override
  String productSubtitle(String sku, String description) {
    return 'SKU: $sku • $description';
  }

  @override
  String productQuantityShort(int amount) {
    return 'Qty: $amount';
  }

  @override
  String get warehouseDeleteTitle => 'Delete warehouses';

  @override
  String warehouseDeleteContent(int count) {
    return 'Do you want to delete $count selected warehouse(s)?';
  }

  @override
  String get warehouseEditTitle => 'Edit Warehouse';

  @override
  String get warehouseNewTitle => 'New Warehouse';

  @override
  String get warehouseCepLabel => 'ZIP code';

  @override
  String get warehouseCepDigitsError => 'ZIP code must have 8 digits';

  @override
  String get warehouseCepNotFound => 'ZIP code not found';

  @override
  String get warehouseCepSearchError => 'Error looking up ZIP code';

  @override
  String warehouseSaveErrorPrefix(String error) {
    return 'Error saving warehouse: $error';
  }

  @override
  String get warehouseValidatorCepInvalid => 'Enter a valid ZIP code';

  @override
  String get warehouseStreetLabel => 'Street';

  @override
  String get warehouseValidatorStreetRequired => 'Enter the street';

  @override
  String get warehouseNumberLabel => 'Number';

  @override
  String get warehouseComplementLabel => 'Complement';

  @override
  String get warehouseNeighborhoodLabel => 'Neighborhood';

  @override
  String get warehouseValidatorNeighborhoodRequired => 'Enter the neighborhood';

  @override
  String get warehouseCityLabel => 'City';

  @override
  String get warehouseValidatorCityRequired => 'Enter the city';

  @override
  String get warehouseStateLabel => 'State';

  @override
  String get warehouseCapacityLabel => 'Capacity';

  @override
  String get warehouseValidatorCapacityRequired => 'Enter a valid capacity';

  @override
  String get warehouseCancelEdit => 'Cancel editing';

  @override
  String get warehouseDetailsTitle => 'Warehouse Details';

  @override
  String get warehouseProductsSectionTitle => 'Products in the Warehouse';

  @override
  String get warehouseRecentMovementsTitle => 'Warehouse Movements';

  @override
  String get warehouseNoProductsRegistered => 'No products in this warehouse.';

  @override
  String get warehouseNoMovementsRegistered =>
      'No movements in this warehouse.';

  @override
  String get dashboardTotalStock => 'Total Stock';

  @override
  String get dashboardEntries7Days => 'Entries (7 days)';

  @override
  String get dashboardExits7Days => 'Exits (7 days)';

  @override
  String get dashboardReturns => 'Returns';

  @override
  String get dashboardNoCategory => 'No category';

  @override
  String get dashboardRecentMovementsTitle => 'Recent Movements';

  @override
  String get logoutTitle => 'Log out';

  @override
  String get logoutConfirmContent =>
      'Do you really want to log out of your account?';

  @override
  String get movementDialogTitle => 'Stock Movements';

  @override
  String get movementAddTitle => 'Add Movement';

  @override
  String get movementEditTitle => 'Edit Movement';

  @override
  String get movementRemoveTitle => 'Remove Movement';

  @override
  String get movementReturnTitle => 'Return Movement';

  @override
  String get movementActionAdd => 'Add';

  @override
  String get movementActionEdit => 'Edit';

  @override
  String get movementActionRemove => 'Remove';

  @override
  String get movementActionReturn => 'Return';

  @override
  String get movementTypeEntry => 'Entry';

  @override
  String get movementTypeExit => 'Exit';

  @override
  String get movementDetailsTitle => 'Movement Details';

  @override
  String get movementTypeLabel => 'Type';

  @override
  String get movementNoDescription => 'No description';

  @override
  String get movementValidatorProductRequired => 'Select a product';

  @override
  String get movementDateLabel => 'Date';

  @override
  String get movementQuantityLabel => 'Quantity';

  @override
  String get movementValidatorQuantityRequired => 'Enter a valid quantity';

  @override
  String movementSaveErrorPrefix(String error) {
    return 'Error saving movement: $error';
  }

  @override
  String get movementDeleteTitle => 'Remove movement';

  @override
  String movementDeleteContent(String name) {
    return 'Do you want to remove the movement for \"$name\"?';
  }

  @override
  String movementDeleteErrorPrefix(String error) {
    return 'Error removing movement: $error';
  }

  @override
  String get movementReturnConfirmTitle => 'Return movement';

  @override
  String movementReturnConfirmContent(int quantity, String name) {
    return 'Do you want to return $quantity unit(s) of \"$name\" to stock?';
  }

  @override
  String movementReturnErrorPrefix(String error) {
    return 'Error returning movement: $error';
  }

  @override
  String get movementReturnEmptyList =>
      'No exit movements available for return.';

  @override
  String get movementEmptyList => 'No movements registered.';

  @override
  String get movementQtyInlineLabel => 'Qty';

  @override
  String get movementReturnedTag => 'Returned';

  @override
  String get chartNoProductsRegistered => 'No products registered';

  @override
  String get chartCategoryTitle => 'Stock by Category';

  @override
  String get chartMovementTitle => 'Entries x Exits';

  @override
  String get chartMovementEntriesLegend => 'Entries';

  @override
  String get chartMovementExitsLegend => 'Exits';

  @override
  String get chartWarehouseTitle => 'Products by Warehouse';

  @override
  String get weekdayMon => 'Mon';

  @override
  String get weekdayTue => 'Tue';

  @override
  String get weekdayWed => 'Wed';

  @override
  String get weekdayThu => 'Thu';

  @override
  String get weekdayFri => 'Fri';

  @override
  String get weekdaySat => 'Sat';

  @override
  String get weekdaySun => 'Sun';

  @override
  String get errorProductNotFound => 'Product not found.';

  @override
  String errorInsufficientStock(String product, int available, int requested) {
    return 'Insufficient stock for \"$product\": available $available, requested $requested.';
  }

  @override
  String get errorEmailAlreadyRegistered => 'This email is already registered.';

  @override
  String get errorMovementAlreadyReturnedRemove =>
      'A returned movement cannot be removed.';

  @override
  String get errorOnlyExitCanBeReturned =>
      'Only exit movements can be returned.';

  @override
  String get errorMovementAlreadyReturned =>
      'This movement has already been returned.';

  @override
  String get errorMovementAlreadyReturnedEdit =>
      'A returned movement cannot be edited.';

  @override
  String get errorCepLookupFailed => 'Could not look up the given ZIP code.';

  @override
  String errorWarehouseCapacityExceeded(
    String warehouse,
    int capacity,
    int total,
  ) {
    return 'The capacity of warehouse \"$warehouse\" would be exceeded: capacity $capacity, total after the movement $total.';
  }
}
