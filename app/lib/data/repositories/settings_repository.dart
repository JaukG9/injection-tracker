import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show ThemeMode;

import '../local/database/app_database.dart';

/// Reads and writes the single app-settings row (id = 'app').
class SettingsRepository {
  SettingsRepository(this._db);

  final AppDatabase _db;

  Stream<AppMetaRow> watch() {
    return (_db.select(_db.appMetas)..where((t) => t.id.equals('app')))
        .watchSingle();
  }

  Future<AppMetaRow> get() {
    return (_db.select(_db.appMetas)..where((t) => t.id.equals('app')))
        .getSingle();
  }

  Future<void> setActiveProfile(String? profileId) {
    return (_db.update(_db.appMetas)..where((t) => t.id.equals('app')))
        .write(AppMetasCompanion(activeProfileId: Value(profileId)));
  }

  Future<void> setOnboardingComplete(bool complete) {
    return (_db.update(_db.appMetas)..where((t) => t.id.equals('app')))
        .write(AppMetasCompanion(onboardingComplete: Value(complete)));
  }

  Future<void> setThemeMode(ThemeMode mode) {
    return (_db.update(_db.appMetas)..where((t) => t.id.equals('app')))
        .write(AppMetasCompanion(themeMode: Value(mode.name)));
  }

  Future<void> setAppLockEnabled(bool enabled) {
    return (_db.update(_db.appMetas)..where((t) => t.id.equals('app')))
        .write(AppMetasCompanion(appLockEnabled: Value(enabled)));
  }

  Future<void> setLastBackupAt(DateTime when) {
    return (_db.update(_db.appMetas)..where((t) => t.id.equals('app')))
        .write(AppMetasCompanion(lastBackupAt: Value(when)));
  }
}
