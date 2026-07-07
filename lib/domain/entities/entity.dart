import 'package:uuid/uuid.dart';

const _uuid = Uuid();

abstract class Entity {
  final String id;

  Entity({String? id}) : id = id ?? _uuid.v4();
}
