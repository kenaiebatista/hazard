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
  /// **'Quantidade: {value}'**
  String stockAmount(int value);

  /// No description provided for @settingsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get settingsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In pt, this message translates to:
  /// **'Idioma'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguagePortuguese.
  ///
  /// In pt, this message translates to:
  /// **'Português'**
  String get settingsLanguagePortuguese;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In pt, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsLanguageSpanish.
  ///
  /// In pt, this message translates to:
  /// **'Español'**
  String get settingsLanguageSpanish;

  /// No description provided for @settingsDarkTheme.
  ///
  /// In pt, this message translates to:
  /// **'Tema escuro'**
  String get settingsDarkTheme;

  /// No description provided for @commonCancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In pt, this message translates to:
  /// **'Excluir'**
  String get commonDelete;

  /// No description provided for @commonSave.
  ///
  /// In pt, this message translates to:
  /// **'Salvar'**
  String get commonSave;

  /// No description provided for @commonUpdate.
  ///
  /// In pt, this message translates to:
  /// **'Atualizar'**
  String get commonUpdate;

  /// No description provided for @commonNameLabel.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get commonNameLabel;

  /// No description provided for @commonDescriptionLabel.
  ///
  /// In pt, this message translates to:
  /// **'Descrição'**
  String get commonDescriptionLabel;

  /// No description provided for @commonValidatorNameRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe o nome'**
  String get commonValidatorNameRequired;

  /// No description provided for @commonValidatorDescriptionRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe a descrição'**
  String get commonValidatorDescriptionRequired;

  /// No description provided for @commonSubcategoryLabel.
  ///
  /// In pt, this message translates to:
  /// **'Subcategoria'**
  String get commonSubcategoryLabel;

  /// No description provided for @commonListOf.
  ///
  /// In pt, this message translates to:
  /// **'Lista de {value}'**
  String commonListOf(String value);

  /// No description provided for @commonUnexpectedError.
  ///
  /// In pt, this message translates to:
  /// **'Ocorreu um erro inesperado. Tente novamente.'**
  String get commonUnexpectedError;

  /// No description provided for @categoryRegisterEditTitle.
  ///
  /// In pt, this message translates to:
  /// **'Editar Categoria'**
  String get categoryRegisterEditTitle;

  /// No description provided for @categoryRegisterNewTitle.
  ///
  /// In pt, this message translates to:
  /// **'Nova Categoria'**
  String get categoryRegisterNewTitle;

  /// No description provided for @categorySaveErrorPrefix.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao salvar categoria: {error}'**
  String categorySaveErrorPrefix(String error);

  /// No description provided for @categoryNoSubcategoryAdded.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma subcategoria adicionada'**
  String get categoryNoSubcategoryAdded;

  /// No description provided for @categoryDeleteTitle.
  ///
  /// In pt, this message translates to:
  /// **'Excluir categorias'**
  String get categoryDeleteTitle;

  /// No description provided for @categoryDeleteContent.
  ///
  /// In pt, this message translates to:
  /// **'Deseja excluir {count} categoria(s) selecionada(s)?'**
  String categoryDeleteContent(int count);

  /// No description provided for @categorySubcategoriesCount.
  ///
  /// In pt, this message translates to:
  /// **'{count} subcategorias'**
  String categorySubcategoriesCount(int count);

  /// No description provided for @categoryNoSubcategoryRegistered.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma subcategoria cadastrada'**
  String get categoryNoSubcategoryRegistered;

  /// No description provided for @productRegisterEditTitle.
  ///
  /// In pt, this message translates to:
  /// **'Editar Produto'**
  String get productRegisterEditTitle;

  /// No description provided for @productRegisterNewTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novo Produto'**
  String get productRegisterNewTitle;

  /// No description provided for @productSaveErrorPrefix.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao salvar produto: {error}'**
  String productSaveErrorPrefix(String error);

  /// No description provided for @productSkuLabel.
  ///
  /// In pt, this message translates to:
  /// **'SKU'**
  String get productSkuLabel;

  /// No description provided for @productValidatorSkuRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe o sku'**
  String get productValidatorSkuRequired;

  /// No description provided for @productCategoryLabel.
  ///
  /// In pt, this message translates to:
  /// **'Categoria'**
  String get productCategoryLabel;

  /// No description provided for @productValidatorCategoryRequired.
  ///
  /// In pt, this message translates to:
  /// **'Selecione uma categoria'**
  String get productValidatorCategoryRequired;

  /// No description provided for @productValidatorSubcategoryRequired.
  ///
  /// In pt, this message translates to:
  /// **'Selecione uma subcategoria'**
  String get productValidatorSubcategoryRequired;

  /// No description provided for @productValidatorWarehouseRequired.
  ///
  /// In pt, this message translates to:
  /// **'Selecione um armazém'**
  String get productValidatorWarehouseRequired;

  /// No description provided for @productImageUrlLabel.
  ///
  /// In pt, this message translates to:
  /// **'URL da Foto'**
  String get productImageUrlLabel;

  /// No description provided for @productValidatorImageUrlInvalid.
  ///
  /// In pt, this message translates to:
  /// **'Informe uma URL válida'**
  String get productValidatorImageUrlInvalid;

  /// No description provided for @productDeleteTitle.
  ///
  /// In pt, this message translates to:
  /// **'Excluir produtos'**
  String get productDeleteTitle;

  /// No description provided for @productDeleteContent.
  ///
  /// In pt, this message translates to:
  /// **'Deseja excluir {count} produto(s) selecionado(s)?'**
  String productDeleteContent(int count);

  /// No description provided for @productSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'SKU: {sku} • {description}'**
  String productSubtitle(String sku, String description);

  /// No description provided for @productQuantityShort.
  ///
  /// In pt, this message translates to:
  /// **'Qtd: {amount}'**
  String productQuantityShort(int amount);

  /// No description provided for @warehouseDeleteTitle.
  ///
  /// In pt, this message translates to:
  /// **'Excluir armazéns'**
  String get warehouseDeleteTitle;

  /// No description provided for @warehouseDeleteContent.
  ///
  /// In pt, this message translates to:
  /// **'Deseja excluir {count} armazém(ns) selecionado(s)?'**
  String warehouseDeleteContent(int count);

  /// No description provided for @warehouseEditTitle.
  ///
  /// In pt, this message translates to:
  /// **'Editar Armazém'**
  String get warehouseEditTitle;

  /// No description provided for @warehouseNewTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novo Armazém'**
  String get warehouseNewTitle;

  /// No description provided for @warehouseCepLabel.
  ///
  /// In pt, this message translates to:
  /// **'CEP'**
  String get warehouseCepLabel;

  /// No description provided for @warehouseCepDigitsError.
  ///
  /// In pt, this message translates to:
  /// **'CEP deve ter 8 dígitos'**
  String get warehouseCepDigitsError;

  /// No description provided for @warehouseCepNotFound.
  ///
  /// In pt, this message translates to:
  /// **'CEP não encontrado'**
  String get warehouseCepNotFound;

  /// No description provided for @warehouseCepSearchError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao buscar CEP'**
  String get warehouseCepSearchError;

  /// No description provided for @warehouseSaveErrorPrefix.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao salvar depósito: {error}'**
  String warehouseSaveErrorPrefix(String error);

  /// No description provided for @warehouseValidatorCepInvalid.
  ///
  /// In pt, this message translates to:
  /// **'Informe um CEP válido'**
  String get warehouseValidatorCepInvalid;

  /// No description provided for @warehouseStreetLabel.
  ///
  /// In pt, this message translates to:
  /// **'Rua'**
  String get warehouseStreetLabel;

  /// No description provided for @warehouseValidatorStreetRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe a rua'**
  String get warehouseValidatorStreetRequired;

  /// No description provided for @warehouseNumberLabel.
  ///
  /// In pt, this message translates to:
  /// **'Número'**
  String get warehouseNumberLabel;

  /// No description provided for @warehouseComplementLabel.
  ///
  /// In pt, this message translates to:
  /// **'Complemento'**
  String get warehouseComplementLabel;

  /// No description provided for @warehouseNeighborhoodLabel.
  ///
  /// In pt, this message translates to:
  /// **'Bairro'**
  String get warehouseNeighborhoodLabel;

  /// No description provided for @warehouseValidatorNeighborhoodRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe o bairro'**
  String get warehouseValidatorNeighborhoodRequired;

  /// No description provided for @warehouseCityLabel.
  ///
  /// In pt, this message translates to:
  /// **'Cidade'**
  String get warehouseCityLabel;

  /// No description provided for @warehouseValidatorCityRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe a cidade'**
  String get warehouseValidatorCityRequired;

  /// No description provided for @warehouseStateLabel.
  ///
  /// In pt, this message translates to:
  /// **'UF'**
  String get warehouseStateLabel;

  /// No description provided for @warehouseCapacityLabel.
  ///
  /// In pt, this message translates to:
  /// **'Capacidade'**
  String get warehouseCapacityLabel;

  /// No description provided for @warehouseValidatorCapacityRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe uma capacidade válida'**
  String get warehouseValidatorCapacityRequired;

  /// No description provided for @warehouseCancelEdit.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar edição'**
  String get warehouseCancelEdit;

  /// No description provided for @dashboardTotalStock.
  ///
  /// In pt, this message translates to:
  /// **'Estoque Geral'**
  String get dashboardTotalStock;

  /// No description provided for @dashboardEntries7Days.
  ///
  /// In pt, this message translates to:
  /// **'Entrada (7 dias)'**
  String get dashboardEntries7Days;

  /// No description provided for @dashboardExits7Days.
  ///
  /// In pt, this message translates to:
  /// **'Saída (7 dias)'**
  String get dashboardExits7Days;

  /// No description provided for @dashboardReturns.
  ///
  /// In pt, this message translates to:
  /// **'Devoluções'**
  String get dashboardReturns;

  /// No description provided for @dashboardNoCategory.
  ///
  /// In pt, this message translates to:
  /// **'Sem categoria'**
  String get dashboardNoCategory;

  /// No description provided for @dashboardRecentMovementsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Últimas Movimentações'**
  String get dashboardRecentMovementsTitle;

  /// No description provided for @logoutTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sair'**
  String get logoutTitle;

  /// No description provided for @logoutConfirmContent.
  ///
  /// In pt, this message translates to:
  /// **'Deseja realmente sair da sua conta?'**
  String get logoutConfirmContent;

  /// No description provided for @movementDialogTitle.
  ///
  /// In pt, this message translates to:
  /// **'Movimentações de Estoque'**
  String get movementDialogTitle;

  /// No description provided for @movementAddTitle.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar Movimentação'**
  String get movementAddTitle;

  /// No description provided for @movementEditTitle.
  ///
  /// In pt, this message translates to:
  /// **'Editar Movimentação'**
  String get movementEditTitle;

  /// No description provided for @movementRemoveTitle.
  ///
  /// In pt, this message translates to:
  /// **'Remover Movimentação'**
  String get movementRemoveTitle;

  /// No description provided for @movementReturnTitle.
  ///
  /// In pt, this message translates to:
  /// **'Devolver Movimentação'**
  String get movementReturnTitle;

  /// No description provided for @movementActionAdd.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar'**
  String get movementActionAdd;

  /// No description provided for @movementActionEdit.
  ///
  /// In pt, this message translates to:
  /// **'Editar'**
  String get movementActionEdit;

  /// No description provided for @movementActionRemove.
  ///
  /// In pt, this message translates to:
  /// **'Remover'**
  String get movementActionRemove;

  /// No description provided for @movementActionReturn.
  ///
  /// In pt, this message translates to:
  /// **'Devolver'**
  String get movementActionReturn;

  /// No description provided for @movementTypeEntry.
  ///
  /// In pt, this message translates to:
  /// **'Entrada'**
  String get movementTypeEntry;

  /// No description provided for @movementTypeExit.
  ///
  /// In pt, this message translates to:
  /// **'Saída'**
  String get movementTypeExit;

  /// No description provided for @movementDetailsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Detalhes da Movimentação'**
  String get movementDetailsTitle;

  /// No description provided for @movementTypeLabel.
  ///
  /// In pt, this message translates to:
  /// **'Tipo'**
  String get movementTypeLabel;

  /// No description provided for @movementNoDescription.
  ///
  /// In pt, this message translates to:
  /// **'Sem descrição'**
  String get movementNoDescription;

  /// No description provided for @movementValidatorProductRequired.
  ///
  /// In pt, this message translates to:
  /// **'Selecione um produto'**
  String get movementValidatorProductRequired;

  /// No description provided for @movementDateLabel.
  ///
  /// In pt, this message translates to:
  /// **'Data'**
  String get movementDateLabel;

  /// No description provided for @movementQuantityLabel.
  ///
  /// In pt, this message translates to:
  /// **'Quantidade'**
  String get movementQuantityLabel;

  /// No description provided for @movementValidatorQuantityRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe uma quantidade válida'**
  String get movementValidatorQuantityRequired;

  /// No description provided for @movementSaveErrorPrefix.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao salvar movimentação: {error}'**
  String movementSaveErrorPrefix(String error);

  /// No description provided for @movementDeleteTitle.
  ///
  /// In pt, this message translates to:
  /// **'Remover movimentação'**
  String get movementDeleteTitle;

  /// No description provided for @movementDeleteContent.
  ///
  /// In pt, this message translates to:
  /// **'Deseja remover a movimentação de \"{name}\"?'**
  String movementDeleteContent(String name);

  /// No description provided for @movementDeleteErrorPrefix.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao remover movimentação: {error}'**
  String movementDeleteErrorPrefix(String error);

  /// No description provided for @movementReturnConfirmTitle.
  ///
  /// In pt, this message translates to:
  /// **'Devolver movimentação'**
  String get movementReturnConfirmTitle;

  /// No description provided for @movementReturnConfirmContent.
  ///
  /// In pt, this message translates to:
  /// **'Deseja devolver {quantity} unidade(s) de \"{name}\" ao estoque?'**
  String movementReturnConfirmContent(int quantity, String name);

  /// No description provided for @movementReturnErrorPrefix.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao devolver movimentação: {error}'**
  String movementReturnErrorPrefix(String error);

  /// No description provided for @movementReturnEmptyList.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma movimentação de saída disponível para devolução.'**
  String get movementReturnEmptyList;

  /// No description provided for @movementEmptyList.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma movimentação registrada.'**
  String get movementEmptyList;

  /// No description provided for @movementQtyInlineLabel.
  ///
  /// In pt, this message translates to:
  /// **'Qtd'**
  String get movementQtyInlineLabel;

  /// No description provided for @movementReturnedTag.
  ///
  /// In pt, this message translates to:
  /// **'Devolvida'**
  String get movementReturnedTag;

  /// No description provided for @chartNoProductsRegistered.
  ///
  /// In pt, this message translates to:
  /// **'Sem produtos cadastrados'**
  String get chartNoProductsRegistered;

  /// No description provided for @chartCategoryTitle.
  ///
  /// In pt, this message translates to:
  /// **'Estoque por Categoria'**
  String get chartCategoryTitle;

  /// No description provided for @chartMovementTitle.
  ///
  /// In pt, this message translates to:
  /// **'Entradas x Saídas'**
  String get chartMovementTitle;

  /// No description provided for @chartMovementEntriesLegend.
  ///
  /// In pt, this message translates to:
  /// **'Entradas'**
  String get chartMovementEntriesLegend;

  /// No description provided for @chartMovementExitsLegend.
  ///
  /// In pt, this message translates to:
  /// **'Saídas'**
  String get chartMovementExitsLegend;

  /// No description provided for @chartWarehouseTitle.
  ///
  /// In pt, this message translates to:
  /// **'Produtos por Galpão'**
  String get chartWarehouseTitle;

  /// No description provided for @weekdayMon.
  ///
  /// In pt, this message translates to:
  /// **'Seg'**
  String get weekdayMon;

  /// No description provided for @weekdayTue.
  ///
  /// In pt, this message translates to:
  /// **'Ter'**
  String get weekdayTue;

  /// No description provided for @weekdayWed.
  ///
  /// In pt, this message translates to:
  /// **'Qua'**
  String get weekdayWed;

  /// No description provided for @weekdayThu.
  ///
  /// In pt, this message translates to:
  /// **'Qui'**
  String get weekdayThu;

  /// No description provided for @weekdayFri.
  ///
  /// In pt, this message translates to:
  /// **'Sex'**
  String get weekdayFri;

  /// No description provided for @weekdaySat.
  ///
  /// In pt, this message translates to:
  /// **'Sab'**
  String get weekdaySat;

  /// No description provided for @weekdaySun.
  ///
  /// In pt, this message translates to:
  /// **'Dom'**
  String get weekdaySun;

  /// No description provided for @errorProductNotFound.
  ///
  /// In pt, this message translates to:
  /// **'Produto não encontrado.'**
  String get errorProductNotFound;

  /// No description provided for @errorInsufficientStock.
  ///
  /// In pt, this message translates to:
  /// **'Estoque insuficiente para \"{product}\": disponível {available}, solicitado {requested}.'**
  String errorInsufficientStock(String product, int available, int requested);

  /// No description provided for @errorEmailAlreadyRegistered.
  ///
  /// In pt, this message translates to:
  /// **'Este email já está cadastrado.'**
  String get errorEmailAlreadyRegistered;

  /// No description provided for @errorMovementAlreadyReturnedRemove.
  ///
  /// In pt, this message translates to:
  /// **'Não é possível remover uma movimentação já devolvida.'**
  String get errorMovementAlreadyReturnedRemove;

  /// No description provided for @errorOnlyExitCanBeReturned.
  ///
  /// In pt, this message translates to:
  /// **'Apenas movimentações de saída podem ser devolvidas.'**
  String get errorOnlyExitCanBeReturned;

  /// No description provided for @errorMovementAlreadyReturned.
  ///
  /// In pt, this message translates to:
  /// **'Esta movimentação já foi devolvida.'**
  String get errorMovementAlreadyReturned;

  /// No description provided for @errorMovementAlreadyReturnedEdit.
  ///
  /// In pt, this message translates to:
  /// **'Não é possível editar uma movimentação já devolvida.'**
  String get errorMovementAlreadyReturnedEdit;

  /// No description provided for @errorCepLookupFailed.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível buscar o CEP informado.'**
  String get errorCepLookupFailed;

  /// No description provided for @errorWarehouseCapacityExceeded.
  ///
  /// In pt, this message translates to:
  /// **'A capacidade do galpão \"{warehouse}\" seria excedida: capacidade {capacity}, total após a movimentação {total}.'**
  String errorWarehouseCapacityExceeded(
    String warehouse,
    int capacity,
    int total,
  );
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
