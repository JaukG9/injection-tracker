import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/database/app_database.dart';
import '../data/repositories/growth_repository.dart';
import '../data/repositories/injection_repository.dart';
import '../data/repositories/medication_repository.dart';
import '../data/repositories/profile_repository.dart';
import '../data/repositories/settings_repository.dart';
import '../data/repositories/site_repository.dart';
import '../data/services/auth_service.dart';
import '../data/services/backup_service.dart';
import '../data/services/image_service.dart';
import '../data/services/notification_service.dart';
import '../data/services/report_service.dart';
import '../domain/models/enums.dart';
import '../domain/services/site_rotation_service.dart';

/// The single database instance. Overridden in tests with an in-memory db.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

// --- Repositories ---

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(databaseProvider)),
);
final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepository(ref.watch(databaseProvider)),
);
final siteRepositoryProvider = Provider<SiteRepository>(
  (ref) => SiteRepository(ref.watch(databaseProvider)),
);
final injectionRepositoryProvider = Provider<InjectionRepository>(
  (ref) => InjectionRepository(ref.watch(databaseProvider)),
);
final growthRepositoryProvider = Provider<GrowthRepository>(
  (ref) => GrowthRepository(ref.watch(databaseProvider)),
);
final medicationRepositoryProvider = Provider<MedicationRepository>(
  (ref) => MedicationRepository(ref.watch(databaseProvider)),
);

final rotationServiceProvider = Provider<SiteRotationService>(
  (ref) => const SiteRotationService(),
);
final backupServiceProvider = Provider<BackupService>(
  (ref) => BackupService(
    ref.watch(databaseProvider),
    ref.watch(profileRepositoryProvider),
  ),
);
final notificationServiceProvider = Provider<NotificationService>(
  (ref) => NotificationService(),
);
final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final imageServiceProvider = Provider<ImageService>((ref) => ImageService());
final reportServiceProvider = Provider<ReportService>(
  (ref) => const ReportService(),
);

/// Whether the app lock is enabled (persisted in settings).
final appLockEnabledProvider = Provider<bool>((ref) {
  return ref.watch(appMetaProvider).value?.appLockEnabled ?? false;
});

/// Whether the user has authenticated this session. Resets on cold start.
class AuthenticatedNotifier extends Notifier<bool> {
  @override
  bool build() => false;
  void unlock() => state = true;
  void lock() => state = false;
}

final authenticatedProvider =
    NotifierProvider<AuthenticatedNotifier, bool>(AuthenticatedNotifier.new);

// --- App settings ---

final appMetaProvider = StreamProvider<AppMetaRow>(
  (ref) => ref.watch(settingsRepositoryProvider).watch(),
);

final themeModeProvider = Provider<ThemeMode>((ref) {
  final meta = ref.watch(appMetaProvider).value;
  return ThemeMode.values.firstWhere(
    (m) => m.name == meta?.themeMode,
    orElse: () => ThemeMode.system,
  );
});

final onboardingCompleteProvider = Provider<bool>((ref) {
  return ref.watch(appMetaProvider).value?.onboardingComplete ?? false;
});

// --- Profiles ---

final profilesProvider = StreamProvider<List<ProfileRow>>(
  (ref) => ref.watch(profileRepositoryProvider).watchAll(),
);

/// The active profile id, taken from app settings.
final activeProfileIdProvider = Provider<String?>((ref) {
  return ref.watch(appMetaProvider).value?.activeProfileId;
});

/// The active profile row, resolved from the profile list.
final activeProfileProvider = Provider<ProfileRow?>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return null;
  final profiles = ref.watch(profilesProvider).value ?? const [];
  for (final p in profiles) {
    if (p.id == id) return p;
  }
  return null;
});

final activeUnitSystemProvider = Provider<UnitSystem>((ref) {
  final p = ref.watch(activeProfileProvider);
  return UnitSystem.fromName(p?.unitSystem);
});

// --- Profile-scoped data (keyed by the active profile) ---

final sitesProvider = StreamProvider<List<InjectionSiteRow>>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return const Stream.empty();
  return ref.watch(siteRepositoryProvider).watchForProfile(id);
});

final injectionsProvider = StreamProvider<List<InjectionRow>>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return const Stream.empty();
  return ref.watch(injectionRepositoryProvider).watchForProfile(id);
});

final growthEntriesProvider = StreamProvider<List<GrowthEntryRow>>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return const Stream.empty();
  return ref.watch(growthRepositoryProvider).watchForProfile(id);
});

final activeMedicationProvider = StreamProvider<MedicationRow?>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return const Stream.empty();
  return ref.watch(medicationRepositoryProvider).watchActive(id);
});

final doseChangesProvider = StreamProvider<List<DoseChangeRow>>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return const Stream.empty();
  return ref.watch(medicationRepositoryProvider).watchDoseChanges(id);
});

// --- Derived rotation state ---

/// Recency + status for every site of the active profile.
final siteRecenciesProvider = Provider<List<SiteRecency>>((ref) {
  final sites = ref.watch(sitesProvider).value ?? const [];
  final injections = ref.watch(injectionsProvider).value ?? const [];
  final service = ref.watch(rotationServiceProvider);

  final rotationSites = sites
      .map((s) => RotationSite(
            key: s.siteKey,
            name: s.name,
            region: BodyRegion.fromName(s.region),
          ))
      .toList();
  final uses = injections
      .where((i) => !i.skipped)
      .map((i) => SiteUse(siteKey: _siteKeyFor(sites, i.siteId), date: i.injectedAt))
      .where((u) => u.siteKey.isNotEmpty)
      .toList();

  return service.recencies(rotationSites, uses);
});

/// The suggested next site (by key), or null.
final suggestedSiteProvider = Provider<String?>((ref) {
  final sites = ref.watch(sitesProvider).value ?? const [];
  final injections = ref.watch(injectionsProvider).value ?? const [];
  final service = ref.watch(rotationServiceProvider);

  final rotationSites = sites
      .where((s) => s.isEnabled)
      .map((s) => RotationSite(
            key: s.siteKey,
            name: s.name,
            region: BodyRegion.fromName(s.region),
          ))
      .toList();
  final uses = injections
      .where((i) => !i.skipped)
      .map((i) => SiteUse(siteKey: _siteKeyFor(sites, i.siteId), date: i.injectedAt))
      .where((u) => u.siteKey.isNotEmpty)
      .toList();

  return service.suggest(rotationSites, uses)?.key;
});

String _siteKeyFor(List<InjectionSiteRow> sites, String siteId) {
  for (final s in sites) {
    if (s.id == siteId) return s.siteKey;
  }
  return '';
}
