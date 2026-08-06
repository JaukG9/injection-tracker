import 'package:uuid/uuid.dart';

/// Generates unique identifiers for new records.
class IdGenerator {
  const IdGenerator();

  static const _uuid = Uuid();

  String next() => _uuid.v4();
}
