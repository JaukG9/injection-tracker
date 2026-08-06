import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injection_tracker/data/local/database/app_database.dart';

void main() {
  test('in-memory database opens and seeds app meta', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    final meta = await db.select(db.appMetas).getSingle();
    expect(meta.id, 'app');
    expect(meta.onboardingComplete, isFalse);
  });
}
