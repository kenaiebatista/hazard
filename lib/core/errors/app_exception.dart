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
