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
  String get sidebarModuleStock => 'Estoque';

  @override
  String get sidebarModuleProduct => 'Produtos';

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
    return 'Quantidade: $value';
  }

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguagePortuguese => 'Português';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageSpanish => 'Español';

  @override
  String get settingsDarkTheme => 'Tema escuro';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Excluir';

  @override
  String get commonSave => 'Salvar';

  @override
  String get commonUpdate => 'Atualizar';

  @override
  String get commonNameLabel => 'Nome';

  @override
  String get commonDescriptionLabel => 'Descrição';

  @override
  String get commonValidatorNameRequired => 'Informe o nome';

  @override
  String get commonValidatorDescriptionRequired => 'Informe a descrição';

  @override
  String get commonSubcategoryLabel => 'Subcategoria';

  @override
  String commonListOf(String value) {
    return 'Lista de $value';
  }

  @override
  String get commonUnexpectedError =>
      'Ocorreu um erro inesperado. Tente novamente.';

  @override
  String get categoryRegisterEditTitle => 'Editar Categoria';

  @override
  String get categoryRegisterNewTitle => 'Nova Categoria';

  @override
  String categorySaveErrorPrefix(String error) {
    return 'Erro ao salvar categoria: $error';
  }

  @override
  String get categoryNoSubcategoryAdded => 'Nenhuma subcategoria adicionada';

  @override
  String get categoryDeleteTitle => 'Excluir categorias';

  @override
  String categoryDeleteContent(int count) {
    return 'Deseja excluir $count categoria(s) selecionada(s)?';
  }

  @override
  String categorySubcategoriesCount(int count) {
    return '$count subcategorias';
  }

  @override
  String get categoryNoSubcategoryRegistered =>
      'Nenhuma subcategoria cadastrada';

  @override
  String get productRegisterEditTitle => 'Editar Produto';

  @override
  String get productRegisterNewTitle => 'Novo Produto';

  @override
  String productSaveErrorPrefix(String error) {
    return 'Erro ao salvar produto: $error';
  }

  @override
  String get productSkuLabel => 'SKU';

  @override
  String get productValidatorSkuRequired => 'Informe o sku';

  @override
  String get productCategoryLabel => 'Categoria';

  @override
  String get productValidatorCategoryRequired => 'Selecione uma categoria';

  @override
  String get productValidatorSubcategoryRequired =>
      'Selecione uma subcategoria';

  @override
  String get productValidatorWarehouseRequired => 'Selecione um armazém';

  @override
  String get productImageUrlLabel => 'URL da Foto';

  @override
  String get productValidatorImageUrlInvalid => 'Informe uma URL válida';

  @override
  String get productDeleteTitle => 'Excluir produtos';

  @override
  String productDeleteContent(int count) {
    return 'Deseja excluir $count produto(s) selecionado(s)?';
  }

  @override
  String productSubtitle(String sku, String description) {
    return 'SKU: $sku • $description';
  }

  @override
  String productQuantityShort(int amount) {
    return 'Qtd: $amount';
  }

  @override
  String get warehouseDeleteTitle => 'Excluir armazéns';

  @override
  String warehouseDeleteContent(int count) {
    return 'Deseja excluir $count armazém(ns) selecionado(s)?';
  }

  @override
  String get warehouseEditTitle => 'Editar Armazém';

  @override
  String get warehouseNewTitle => 'Novo Armazém';

  @override
  String get warehouseCepLabel => 'CEP';

  @override
  String get warehouseCepDigitsError => 'CEP deve ter 8 dígitos';

  @override
  String get warehouseCepNotFound => 'CEP não encontrado';

  @override
  String get warehouseCepSearchError => 'Erro ao buscar CEP';

  @override
  String warehouseSaveErrorPrefix(String error) {
    return 'Erro ao salvar depósito: $error';
  }

  @override
  String get warehouseValidatorCepInvalid => 'Informe um CEP válido';

  @override
  String get warehouseStreetLabel => 'Rua';

  @override
  String get warehouseValidatorStreetRequired => 'Informe a rua';

  @override
  String get warehouseNumberLabel => 'Número';

  @override
  String get warehouseComplementLabel => 'Complemento';

  @override
  String get warehouseNeighborhoodLabel => 'Bairro';

  @override
  String get warehouseValidatorNeighborhoodRequired => 'Informe o bairro';

  @override
  String get warehouseCityLabel => 'Cidade';

  @override
  String get warehouseValidatorCityRequired => 'Informe a cidade';

  @override
  String get warehouseStateLabel => 'UF';

  @override
  String get warehouseCapacityLabel => 'Capacidade';

  @override
  String get warehouseValidatorCapacityRequired =>
      'Informe uma capacidade válida';

  @override
  String get warehouseCancelEdit => 'Cancelar edição';

  @override
  String get warehouseDetailsTitle => 'Detalhes do Galpão';

  @override
  String get warehouseProductsSectionTitle => 'Produtos no Galpão';

  @override
  String get warehouseRecentMovementsTitle => 'Movimentações do Galpão';

  @override
  String get warehouseNoProductsRegistered => 'Nenhum produto neste galpão.';

  @override
  String get warehouseNoMovementsRegistered =>
      'Nenhuma movimentação neste galpão.';

  @override
  String get dashboardTotalStock => 'Estoque Geral';

  @override
  String get dashboardEntries7Days => 'Entrada (7 dias)';

  @override
  String get dashboardExits7Days => 'Saída (7 dias)';

  @override
  String get dashboardReturns => 'Devoluções';

  @override
  String get dashboardNoCategory => 'Sem categoria';

  @override
  String get dashboardRecentMovementsTitle => 'Últimas Movimentações';

  @override
  String get logoutTitle => 'Sair';

  @override
  String get logoutConfirmContent => 'Deseja realmente sair da sua conta?';

  @override
  String get movementDialogTitle => 'Movimentações de Estoque';

  @override
  String get movementAddTitle => 'Adicionar Movimentação';

  @override
  String get movementEditTitle => 'Editar Movimentação';

  @override
  String get movementRemoveTitle => 'Remover Movimentação';

  @override
  String get movementReturnTitle => 'Devolver Movimentação';

  @override
  String get movementActionAdd => 'Adicionar';

  @override
  String get movementActionEdit => 'Editar';

  @override
  String get movementActionRemove => 'Remover';

  @override
  String get movementActionReturn => 'Devolver';

  @override
  String get movementTypeEntry => 'Entrada';

  @override
  String get movementTypeExit => 'Saída';

  @override
  String get movementDetailsTitle => 'Detalhes da Movimentação';

  @override
  String get movementTypeLabel => 'Tipo';

  @override
  String get movementNoDescription => 'Sem descrição';

  @override
  String get movementValidatorProductRequired => 'Selecione um produto';

  @override
  String get movementDateLabel => 'Data';

  @override
  String get movementQuantityLabel => 'Quantidade';

  @override
  String get movementValidatorQuantityRequired =>
      'Informe uma quantidade válida';

  @override
  String movementSaveErrorPrefix(String error) {
    return 'Erro ao salvar movimentação: $error';
  }

  @override
  String get movementDeleteTitle => 'Remover movimentação';

  @override
  String movementDeleteContent(String name) {
    return 'Deseja remover a movimentação de \"$name\"?';
  }

  @override
  String movementDeleteErrorPrefix(String error) {
    return 'Erro ao remover movimentação: $error';
  }

  @override
  String get movementReturnConfirmTitle => 'Devolver movimentação';

  @override
  String movementReturnConfirmContent(int quantity, String name) {
    return 'Deseja devolver $quantity unidade(s) de \"$name\" ao estoque?';
  }

  @override
  String movementReturnErrorPrefix(String error) {
    return 'Erro ao devolver movimentação: $error';
  }

  @override
  String get movementReturnEmptyList =>
      'Nenhuma movimentação de saída disponível para devolução.';

  @override
  String get movementEmptyList => 'Nenhuma movimentação registrada.';

  @override
  String get movementQtyInlineLabel => 'Qtd';

  @override
  String get movementReturnedTag => 'Devolvida';

  @override
  String get chartNoProductsRegistered => 'Sem produtos cadastrados';

  @override
  String get chartCategoryTitle => 'Estoque por Categoria';

  @override
  String get chartMovementTitle => 'Entradas x Saídas';

  @override
  String get chartMovementEntriesLegend => 'Entradas';

  @override
  String get chartMovementExitsLegend => 'Saídas';

  @override
  String get chartWarehouseTitle => 'Produtos por Galpão';

  @override
  String get weekdayMon => 'Seg';

  @override
  String get weekdayTue => 'Ter';

  @override
  String get weekdayWed => 'Qua';

  @override
  String get weekdayThu => 'Qui';

  @override
  String get weekdayFri => 'Sex';

  @override
  String get weekdaySat => 'Sab';

  @override
  String get weekdaySun => 'Dom';

  @override
  String get errorProductNotFound => 'Produto não encontrado.';

  @override
  String errorInsufficientStock(String product, int available, int requested) {
    return 'Estoque insuficiente para \"$product\": disponível $available, solicitado $requested.';
  }

  @override
  String get errorEmailAlreadyRegistered => 'Este email já está cadastrado.';

  @override
  String get errorMovementAlreadyReturnedRemove =>
      'Não é possível remover uma movimentação já devolvida.';

  @override
  String get errorOnlyExitCanBeReturned =>
      'Apenas movimentações de saída podem ser devolvidas.';

  @override
  String get errorMovementAlreadyReturned =>
      'Esta movimentação já foi devolvida.';

  @override
  String get errorMovementAlreadyReturnedEdit =>
      'Não é possível editar uma movimentação já devolvida.';

  @override
  String get errorCepLookupFailed => 'Não foi possível buscar o CEP informado.';

  @override
  String errorWarehouseCapacityExceeded(
    String warehouse,
    int capacity,
    int total,
  ) {
    return 'A capacidade do galpão \"$warehouse\" seria excedida: capacidade $capacity, total após a movimentação $total.';
  }
}
