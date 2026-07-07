import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  /// No description provided for @loginWelcome.
  ///
  /// In pt, this message translates to:
  /// **'Bem-vindo!'**
  String get loginWelcome;

  /// No description provided for @loginRegisterTitle.
  ///
  /// In pt, this message translates to:
  /// **'Cadastre-se'**
  String get loginRegisterTitle;

  /// No description provided for @loginFieldName.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get loginFieldName;

  /// No description provided for @loginFieldEmail.
  ///
  /// In pt, this message translates to:
  /// **'Email'**
  String get loginFieldEmail;

  /// No description provided for @loginFieldPassword.
  ///
  /// In pt, this message translates to:
  /// **'Senha'**
  String get loginFieldPassword;

  /// No description provided for @loginFieldConfirmPassword.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar Senha'**
  String get loginFieldConfirmPassword;

  /// No description provided for @loginButtonSignIn.
  ///
  /// In pt, this message translates to:
  /// **'Entrar'**
  String get loginButtonSignIn;

  /// No description provided for @loginButtonRegister.
  ///
  /// In pt, this message translates to:
  /// **'Cadastrar'**
  String get loginButtonRegister;

  /// No description provided for @loginLinkHaveAccount.
  ///
  /// In pt, this message translates to:
  /// **'Já tenho uma conta'**
  String get loginLinkHaveAccount;

  /// No description provided for @loginLinkRegister.
  ///
  /// In pt, this message translates to:
  /// **'Cadastre-se'**
  String get loginLinkRegister;

  /// No description provided for @loginErrorInvalidCredentials.
  ///
  /// In pt, this message translates to:
  /// **'Email ou senha incorretos.'**
  String get loginErrorInvalidCredentials;

  /// No description provided for @loginErrorEmailAlreadyRegistered.
  ///
  /// In pt, this message translates to:
  /// **'Este email já está cadastrado.'**
  String get loginErrorEmailAlreadyRegistered;

  /// No description provided for @loginValidatorNameRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe o nome'**
  String get loginValidatorNameRequired;

  /// No description provided for @loginValidatorEmailRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe o email'**
  String get loginValidatorEmailRequired;

  /// No description provided for @loginValidatorEmailInvalid.
  ///
  /// In pt, this message translates to:
  /// **'Email inválido'**
  String get loginValidatorEmailInvalid;

  /// No description provided for @loginValidatorPasswordRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe a senha'**
  String get loginValidatorPasswordRequired;

  /// No description provided for @loginValidatorPasswordMinLength.
  ///
  /// In pt, this message translates to:
  /// **'Mínimo 6 caracteres'**
  String get loginValidatorPasswordMinLength;

  /// No description provided for @loginValidatorConfirmPasswordRequired.
  ///
  /// In pt, this message translates to:
  /// **'Confirme a senha'**
  String get loginValidatorConfirmPasswordRequired;

  /// No description provided for @loginValidatorPasswordMismatch.
  ///
  /// In pt, this message translates to:
  /// **'Senhas não coincidem'**
  String get loginValidatorPasswordMismatch;

  /// No description provided for @navList.
  ///
  /// In pt, this message translates to:
  /// **'Lista'**
  String get navList;

  /// No description provided for @navManagement.
  ///
  /// In pt, this message translates to:
  /// **'Gestão'**
  String get navManagement;

  /// No description provided for @navStock.
  ///
  /// In pt, this message translates to:
  /// **'Estoque'**
  String get navStock;

  /// No description provided for @navProduct.
  ///
  /// In pt, this message translates to:
  /// **'Produto'**
  String get navProduct;

  /// No description provided for @navCategory.
  ///
  /// In pt, this message translates to:
  /// **'Categoria'**
  String get navCategory;

  /// No description provided for @warehouseTitle.
  ///
  /// In pt, this message translates to:
  /// **'Armazém'**
  String get warehouseTitle;

  /// No description provided for @warehouseEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum armazém cadastrado.'**
  String get warehouseEmpty;

  /// No description provided for @warehouseCapacity.
  ///
  /// In pt, this message translates to:
  /// **'Capacidade: {value}'**
  String warehouseCapacity(int value);

  /// No description provided for @warehouseManageTitle.
  ///
  /// In pt, this message translates to:
  /// **'Gerenciar Armazém'**
  String get warehouseManageTitle;

  /// No description provided for @sidebarModuleWarehouse.
  ///
  /// In pt, this message translates to:
  /// **'Armazém'**
  String get sidebarModuleWarehouse;

  /// No description provided for @sidebarModuleCategory.
  ///
  /// In pt, this message translates to:
  /// **'Categoria'**
  String get sidebarModuleCategory;

  /// No description provided for @categoryTitle.
  ///
  /// In pt, this message translates to:
  /// **'Categoria'**
  String get categoryTitle;

  /// No description provided for @categoryEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma categoria cadastrada.'**
  String get categoryEmpty;

  /// No description provided for @productTitle.
  ///
  /// In pt, this message translates to:
  /// **'Produto'**
  String get productTitle;

  /// No description provided for @productEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum produto cadastrado.'**
  String get productEmpty;

  /// No description provided for @stockTitle.
  ///
  /// In pt, this message translates to:
  /// **'Estoque'**
  String get stockTitle;

  /// No description provided for @stockEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum produto cadastrado.'**
  String get stockEmpty;

  /// No description provided for @stockSku.
  ///
  /// In pt, this message translates to:
  /// **'SKU: {value}'**
  String stockSku(String value);

  /// No description provided for @stockWarehouse.
  ///
  /// In pt, this message translates to:
  /// **'Galpão: {value}'**
  String stockWarehouse(String value);

  /// No description provided for @stockWarehouseUnknown.
  ///
  /// In pt, this message translates to:
  /// **'Não alocado'**
  String get stockWarehouseUnknown;

  /// No description provided for @stockAmount.
  ///
  /// In pt, this message translates to:
  /// **'Qtd: {value}'**
  String stockAmount(int value);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
