import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../app/providers.dart';
import '../../../app/theme/clinical_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/status_widgets.dart';
import '../../../data/local/database/app_database.dart';
import '../../../domain/models/enums.dart';
import '../../../domain/services/adherence_service.dart';
import '../../injection/presentation/log_injection_screen.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late DateTime _month; // first day of the visible month

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _month = DateTime(now.year, now.month);
  }

  void _shift(int months) {
    setState(() => _month = DateTime(_month.year, _month.month + months));
  }

  /// Local date-only (matches how the calendar cells are built). Drift returns
  /// DateTimes in local time, so day-matching must be done in local time too.
  static DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

  ScheduleSpec? _specFor(MedicationRow? med) {
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
      weekdays: (cfg['weekdays'] as List?)?.map((e) => e as int).toSet() ??
          const {},
      startedOn: med.startedAt ?? DateTime(2000),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final injections = ref.watch(injectionsProvider).value ?? const [];
    final med = ref.watch(activeMedicationProvider).value;
    final spec = _specFor(med);
    const adherence = AdherenceService();

    // Injections grouped by local date-only.
    final byDay = <DateTime, List<InjectionRow>>{};
    for (final inj in injections) {
      final d = _day(inj.injectedAt);
      (byDay[d] ??= []).add(inj);
    }

    final today = _day(DateTime.now());
    final monthStart = DateTime(_month.year, _month.month);
    final daysInMonth = DateTime(_month.year, _month.month + 1, 0).day;
    // Monday-first offset for the 1st of the month.
    final leadingBlanks = (monthStart.weekday - 1) % 7;

    // Month adherence, only counting days up to today (future scheduled days
    // aren't "missed" yet).
    final monthEnd = DateTime(_month.year, _month.month, daysInMonth);
    final rangeEnd = monthEnd.isAfter(today) ? today : monthEnd;
    final stats = (spec == null || rangeEnd.isBefore(monthStart))
        ? null
        : adherence.stats(
            spec: spec,
            injectionDates: injections
                .where((i) => !i.skipped)
                .map((i) => i.injectedAt),
            from: monthStart,
            to: rangeEnd,
          );

    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () => _shift(-1),
                    ),
                    Expanded(
                      child: Text(
                        DateFormat('MMMM yyyy').format(_month),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () => _shift(1),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    for (final d in const ['M', 'T', 'W', 'T', 'F', 'S', 'S'])
                      Expanded(
                        child: Text(
                          d,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.labelSmall
                              ?.copyWith(color: theme.colorScheme.outline),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                GridView.count(
                  crossAxisCount: 7,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    for (var i = 0; i < leadingBlanks; i++)
                      const SizedBox.shrink(),
                    for (var day = 1; day <= daysInMonth; day++)
                      _DayCell(
                        date: DateTime(_month.year, _month.month, day),
                        today: today,
                        injections:
                            byDay[DateTime(_month.year, _month.month, day)] ??
                                const [],
                        scheduled: spec != null &&
                            adherence.isScheduledOn(
                                spec, DateTime(_month.year, _month.month, day)),
                        onTap: _openDay,
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _Legend(),
          if (stats != null) ...[
            const SizedBox(height: 16),
            AppCard(
              title: 'This month',
              leading: const Icon(Icons.insights_outlined),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _Stat(label: 'Taken', value: '${stats.taken}'),
                  _Stat(label: 'Missed', value: '${stats.missed}'),
                  _Stat(label: 'Adherence', value: '${stats.percent}%'),
                  _Stat(label: 'Streak', value: '${stats.currentStreak}'),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _openDay(DateTime date) async {
    final injections = ref.read(injectionsProvider).value ?? const [];
    final sites = ref.read(sitesProvider).value ?? const [];
    final sitesById = {for (final s in sites) s.id: s};
    final dayItems = injections
        .where((i) => _day(i.injectedAt) == _day(date))
        .toList();

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat('EEEE, MMM d, yyyy').format(date),
                  style: Theme.of(ctx)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              if (dayItems.isEmpty)
                const EmptyState(message: 'Nothing logged this day.')
              else
                ...dayItems.map((i) {
                  final site = sitesById[i.siteId];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      i.skipped ? Icons.event_busy : Icons.vaccines_outlined,
                      color: i.skipped
                          ? Theme.of(ctx).colorScheme.error
                          : Theme.of(ctx).colorScheme.primary,
                    ),
                    title: Text(site?.name ?? 'Unknown site'),
                    subtitle: Text(i.skipped
                        ? 'Skipped'
                        : DateFormat('h:mm a').format(i.injectedAt)),
                  );
                }),
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => LogInjectionScreen(initialDate: date),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Log for this day'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.date,
    required this.today,
    required this.injections,
    required this.scheduled,
    required this.onTap,
  });

  final DateTime date;
  final DateTime today;
  final List<InjectionRow> injections;
  final bool scheduled;
  final ValueChanged<DateTime> onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final clinical = context.clinical;
    final hasInjection = injections.any((i) => !i.skipped);
    final isToday = date == today;
    final isPast = date.isBefore(today);
    final missed = scheduled && isPast && !hasInjection;

    Color? bg;
    Color fg = theme.colorScheme.onSurface;
    if (hasInjection) {
      bg = clinical.good;
      fg = Colors.white;
    } else if (missed) {
      bg = clinical.veryRecent.withValues(alpha: 0.18);
      fg = clinical.veryRecent;
    }

    final status = hasInjection
        ? 'injected'
        : missed
            ? 'missed'
            : 'no injection';
    return Semantics(
      button: true,
      label: '${DateFormat('EEEE MMMM d').format(date)}, $status'
          '${isToday ? ', today' : ''}',
      excludeSemantics: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => onTap(date),
        child: Container(
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: bg,
            shape: BoxShape.circle,
            border: isToday
                ? Border.all(color: theme.colorScheme.primary, width: 2)
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            '${date.day}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: fg,
              fontWeight: (hasInjection || isToday)
                  ? FontWeight.w700
                  : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.clinical;
    final theme = Theme.of(context);
    Widget dot(Color color, String label, {bool ring = false}) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: ring ? null : color,
                shape: BoxShape.circle,
                border: ring ? Border.all(color: color, width: 2) : null,
              ),
            ),
            const SizedBox(width: 6),
            Text(label, style: theme.textTheme.bodySmall),
          ],
        );
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        dot(c.good, 'Injected'),
        dot(c.veryRecent.withValues(alpha: 0.6), 'Missed'),
        dot(theme.colorScheme.primary, 'Today', ring: true),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(value,
            style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w700)),
        Text(label,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.outline)),
      ],
    );
  }
}
