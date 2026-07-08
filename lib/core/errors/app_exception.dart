import 'package:hazard/l10n/app_localizations.dart';

enum AppErrorKey {
  productNotFound,
  insufficientStock,
  emailAlreadyRegistered,
  movementAlreadyReturnedForRemoval,
  onlyExitMovementsCanBeReturned,
  movementAlreadyReturned,
  movementAlreadyReturnedForEdit,
  cepLookupFailed,
  warehouseCapacityExceeded,
}

class AppException implements Exception {
  final AppErrorKey key;
  final List<Object> args;

  const AppException(this.key, [this.args = const []]);

  @override
  String toString() => key.name;
}

String describeError(Object error, AppLocalizations l10n) {
  if (error is AppException) {
    switch (error.key) {
      case AppErrorKey.productNotFound:
        return l10n.errorProductNotFound;
      case AppErrorKey.insufficientStock:
        return l10n.errorInsufficientStock(
          error.args[0] as String,
          error.args[1] as int,
          error.args[2] as int,
        );
      case AppErrorKey.emailAlreadyRegistered:
        return l10n.errorEmailAlreadyRegistered;
      case AppErrorKey.movementAlreadyReturnedForRemoval:
        return l10n.errorMovementAlreadyReturnedRemove;
      case AppErrorKey.onlyExitMovementsCanBeReturned:
        return l10n.errorOnlyExitCanBeReturned;
      case AppErrorKey.movementAlreadyReturned:
        return l10n.errorMovementAlreadyReturned;
      case AppErrorKey.movementAlreadyReturnedForEdit:
        return l10n.errorMovementAlreadyReturnedEdit;
      case AppErrorKey.cepLookupFailed:
        return l10n.errorCepLookupFailed;
      case AppErrorKey.warehouseCapacityExceeded:
        return l10n.errorWarehouseCapacityExceeded(
          error.args[0] as String,
          error.args[1] as int,
          error.args[2] as int,
        );
    }
  }
  return l10n.commonUnexpectedError;
}
