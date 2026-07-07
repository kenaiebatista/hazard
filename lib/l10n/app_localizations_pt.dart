// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get loginWelcome => 'Bem-vindo!';

  @override
  String get loginRegisterTitle => 'Cadastre-se';

  @override
  String get loginFieldName => 'Nome';

  @override
  String get loginFieldEmail => 'Email';

  @override
  String get loginFieldPassword => 'Senha';

  @override
  String get loginFieldConfirmPassword => 'Confirmar Senha';

  @override
  String get loginButtonSignIn => 'Entrar';

  @override
  String get loginButtonRegister => 'Cadastrar';

  @override
  String get loginLinkHaveAccount => 'Já tenho uma conta';

  @override
  String get loginLinkRegister => 'Cadastre-se';

  @override
  String get loginErrorInvalidCredentials => 'Email ou senha incorretos.';

  @override
  String get loginErrorEmailAlreadyRegistered =>
      'Este email já está cadastrado.';

  @override
  String get loginValidatorNameRequired => 'Informe o nome';

  @override
  String get loginValidatorEmailRequired => 'Informe o email';

  @override
  String get loginValidatorEmailInvalid => 'Email inválido';

  @override
  String get loginValidatorPasswordRequired => 'Informe a senha';

  @override
  String get loginValidatorPasswordMinLength => 'Mínimo 6 caracteres';

  @override
  String get loginValidatorConfirmPasswordRequired => 'Confirme a senha';

  @override
  String get loginValidatorPasswordMismatch => 'Senhas não coincidem';

  @override
  String get navList => 'Lista';

  @override
  String get navManagement => 'Gestão';

  @override
  String get navStock => 'Estoque';

  @override
  String get navProduct => 'Produto';

  @override
  String get navCategory => 'Categoria';

  @override
  String get warehouseTitle => 'Armazém';

  @override
  String get warehouseEmpty => 'Nenhum armazém cadastrado.';

  @override
  String warehouseCapacity(int value) {
    return 'Capacidade: $value';
  }

  @override
  String get warehouseManageTitle => 'Gerenciar Armazém';

  @override
  String get sidebarModuleWarehouse => 'Armazém';

  @override
  String get sidebarModuleCategory => 'Categoria';

  @override
  String get categoryTitle => 'Categoria';

  @override
  String get categoryEmpty => 'Nenhuma categoria cadastrada.';

  @override
  String get productTitle => 'Produto';

  @override
  String get productEmpty => 'Nenhum produto cadastrado.';

  @override
  String get stockTitle => 'Estoque';

  @override
  String get stockEmpty => 'Nenhum produto cadastrado.';

  @override
  String stockSku(String value) {
    return 'SKU: $value';
  }

  @override
  String stockWarehouse(String value) {
    return 'Galpão: $value';
  }

  @override
  String get stockWarehouseUnknown => 'Não alocado';

  @override
  String stockAmount(int value) {
    return 'Qtd: $value';
  }
}
