import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';

import '../../../app/providers.dart';
import '../../../core/widgets/app_card.dart';
import '../../../data/local/database/app_database.dart';
import '../../../domain/models/enums.dart';
import '../../../domain/services/adherence_service.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  late DateTimeRange _range;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _range = DateTimeRange(
      start: now.subtract(const Duration(days: 90)),
      end: now,
    );
  }

  ScheduleSpec? _spec(MedicationRow? med) {
    if (med == null) return null;
    Map<String, dynamic> cfg;
    try {
      cfg = jsonDecode(med.scheduleConfig) as Map<String, dynamic>;
    } catch (_) {
      cfg = const {};
    }
    return ScheduleSpec(
      type: ScheduleType.fromName(med.scheduleType),
      everyNDays: (cfg['n'] as num?)?.toInt() ?? 1,
      weekdays:
          (cfg['weekdays'] as List?)?.map((e) => e as int).toSet() ?? const {},
      startedOn: med.startedAt ?? DateTime(2000),
    );
  }

  Future<Uint8List?> _build() async {
    final profile = ref.read(activeProfileProvider);
    final profileId = ref.read(activeProfileIdProvider);
    if (profile == null || profileId == null) return null;
    final med = ref.read(activeMedicationProvider).value;
    final currentDose =
        await ref.read(medicationRepositoryProvider).currentDose(profileId);
    return ref.read(reportServiceProvider).buildDoctorReport(
          profile: profile,
          medication: med,
          currentDose: currentDose,
          doseChanges: ref.read(doseChangesProvider).value ?? const [],
          sites: ref.read(sitesProvider).value ?? const [],
          injections: ref.read(injectionsProvider).value ?? const [],
          growth: ref.read(growthEntriesProvider).value ?? const [],
          from: _range.start,
          to: _range.end,
          units: ref.read(activeUnitSystemProvider),
          schedule: _spec(med),
        );
  }

  Future<void> _preview() async {
    setState(() => _busy = true);
    try {
      final name = ref.read(activeProfileProvider)?.name ?? 'report';
      await Printing.layoutPdf(
        onLayout: (_) async => (await _build())!,
        name: '$name-injection-report',
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _share() async {
    setState(() => _busy = true);
    try {
      final name = ref.read(activeProfileProvider)?.name ?? 'report';
      final slug = name.toLowerCase().replaceAll(RegExp('[^a-z0-9]+'), '_');
      final bytes = (await _build())!;
      await Printing.sharePdf(bytes: bytes, filename: '${slug}_report.pdf');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final df = DateFormat('MMM d, yyyy');
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Report')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            title: 'Report period',
            leading: const Icon(Icons.date_range_outlined),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${df.format(_range.start)}  to  ${df.format(_range.end)}',
                    style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    for (final days in const [30, 90, 180, 365])
                      ActionChip(
                        label: Text('$days d'),
                        onPressed: () {
                          final now = DateTime.now();
                          setState(() => _range = DateTimeRange(
                              start: now.subtract(Duration(days: days)),
                              end: now));
                        },
                      ),
                    ActionChip(
                      label: const Text('Custom'),
                      onPressed: () async {
                        final picked = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                          initialDateRange: _range,
                        );
                        if (picked != null) setState(() => _range = picked);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            title: "What's included",
            leading: const Icon(Icons.description_outlined),
            child: Text(
              'Patient details, adherence summary, site-rotation table, growth '
              'measurements with velocity, dose history, and injections in the '
              'selected period.',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.outline),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: _busy ? null : _preview,
            icon: _busy
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.picture_as_pdf_outlined),
            label: const Text('Preview / Print'),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: _busy ? null : _share,
            icon: const Icon(Icons.ios_share),
            label: const Text('Share PDF'),
          ),
        ],
      ),
    );
  }
}
