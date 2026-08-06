import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injection_tracker/data/local/database/app_database.dart';
import 'package:injection_tracker/data/repositories/medication_repository.dart';
import 'package:injection_tracker/data/repositories/profile_repository.dart';
import 'package:injection_tracker/domain/models/enums.dart';

void main() {
  late AppDatabase db;
  late ProfileRepository profiles;
  late MedicationRepository meds;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    profiles = ProfileRepository(db);
    meds = MedicationRepository(db);
  });
  tearDown(() => db.close());

  test('changeDose records history and updates the medication default',
      () async {
    final profileId = await profiles.createFromDraft(
      ProfileDraft(name: 'Kid', medicationName: 'GH', doseValue: 0.4),
    );
    final med =
        (await db.select(db.medications).getSingle());
    expect(med.defaultDoseValue, 0.4);

    await meds.changeDose(
      profileId: profileId,
      medicationId: med.id,
      value: 0.6,
      unit: DoseUnit.mg,
      reason: 'Increase',
    );

    // Current dose reflects the change.
    final current = await meds.currentDose(profileId);
    expect(current!.value, 0.6);

    // Medication default is updated too.
    final updatedMed = await db.select(db.medications).getSingle();
    expect(updatedMed.defaultDoseValue, 0.6);

    // History has both the seeded initial dose and the change.
    final history = await meds.watchDoseChanges(profileId).first;
    expect(history, hasLength(2));
    expect(history.first.value, 0.6); // newest first
  });

  test('setReminderTime stores and clears the time', () async {
    await profiles.createFromDraft(
      ProfileDraft(name: 'Kid', medicationName: 'GH'),
    );
    final med = await db.select(db.medications).getSingle();

    await meds.setReminderTime(med.id, '20:30');
    expect((await db.select(db.medications).getSingle()).reminderTime, '20:30');

    await meds.setReminderTime(med.id, null);
    expect((await db.select(db.medications).getSingle()).reminderTime, isNull);
  });
}
