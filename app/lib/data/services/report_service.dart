// PDF layout code is verbose; const-chasing the widget tree adds noise.
// ignore_for_file: prefer_const_constructors
import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../core/constants/app_constants.dart';
import '../../domain/models/enums.dart';
import '../../domain/services/adherence_service.dart';
import '../../domain/services/growth_math.dart';
import '../../domain/services/site_rotation_service.dart';
import '../../domain/services/unit_converter.dart';
import '../local/database/app_database.dart';

/// Builds a clinician-friendly PDF summary for a profile over a date range.
class ReportService {
  const ReportService();

  Future<Uint8List> buildDoctorReport({
    required ProfileRow profile,
    required MedicationRow? medication,
    required DoseChangeRow? currentDose,
    required List<DoseChangeRow> doseChanges,
    required List<InjectionSiteRow> sites,
    required List<InjectionRow> injections,
    required List<GrowthEntryRow> growth,
    required DateTime from,
    required DateTime to,
    required UnitSystem units,
    ScheduleSpec? schedule,
  }) async {
    final doc = pw.Document();
    final df = DateFormat('MMM d, yyyy');
    const blue = PdfColor.fromInt(0xFF2C5F8A);
    const muted = PdfColor.fromInt(0xFF6B7A89);

    // --- computed sections ---
    final inRange = injections
        .where((i) =>
            !i.injectedAt.isBefore(from) &&
            !i.injectedAt.isAfter(to.add(const Duration(days: 1))))
        .toList()
      ..sort((a, b) => b.injectedAt.compareTo(a.injectedAt));

    AdherenceStats? adherence;
    if (schedule != null) {
      adherence = const AdherenceService().stats(
        spec: schedule,
        injectionDates:
            injections.where((i) => !i.skipped).map((i) => i.injectedAt),
        from: from,
        to: to,
        // Today is still in progress, so it isn't counted as missed.
        now: DateTime.now(),
      );
    }

    final rotationSites = sites
        .map((s) => RotationSite(
            key: s.siteKey,
            name: s.name,
            region: BodyRegion.fromName(s.region)))
        .toList();
    final uses = injections
        .where((i) => !i.skipped)
        .map((i) => SiteUse(
            siteKey: sites
                .firstWhere((s) => s.id == i.siteId,
                    orElse: () => sites.first)
                .siteKey,
            date: i.injectedAt))
        .toList();
    final recencies =
        const SiteRotationService().recencies(rotationSites, uses);

    final growthSorted = [...growth]
      ..sort((a, b) => a.measuredAt.compareTo(b.measuredAt));
    final samples = growthSorted
        .map((g) => GrowthSample(
            date: g.measuredAt, heightCm: g.heightCm, weightKg: g.weightKg))
        .toList();
    final velocities = GrowthMath.velocitySeries(samples);

    pw.Widget sectionTitle(String t) => pw.Padding(
          padding: const pw.EdgeInsets.only(top: 16, bottom: 6),
          child: pw.Text(t,
              style: pw.TextStyle(
                  fontSize: 13,
                  fontWeight: pw.FontWeight.bold,
                  color: blue)),
        );

    final age = profile.dateOfBirth == null
        ? null
        : ((to.difference(profile.dateOfBirth!).inDays) / 365.25)
            .toStringAsFixed(1);

    doc.addPage(
      pw.MultiPage(
        pageTheme: const pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.all(32),
        ),
        header: (ctx) => ctx.pageNumber == 1
            ? pw.SizedBox()
            : pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 8),
                child: pw.Text("${profile.name}'s SiteCycle report",
                    style: pw.TextStyle(fontSize: 9, color: muted)),
              ),
        footer: (ctx) => pw.Padding(
          padding: const pw.EdgeInsets.only(top: 8),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(AppConstants.supportDisclaimer,
                  style: pw.TextStyle(fontSize: 7, color: muted),
                  maxLines: 2),
              pw.Text('Page ${ctx.pageNumber}/${ctx.pagesCount}',
                  style: pw.TextStyle(fontSize: 8, color: muted)),
            ],
          ),
        ),
        build: (ctx) => [
          // Title.
          pw.Text('Injection & Growth Report',
              style: pw.TextStyle(
                  fontSize: 20, fontWeight: pw.FontWeight.bold, color: blue)),
          pw.SizedBox(height: 2),
          pw.Text('${df.format(from)} to ${df.format(to)}',
              style: pw.TextStyle(color: muted, fontSize: 11)),
          pw.Divider(color: const PdfColor.fromInt(0xFFDCE3EA)),

          // Patient block.
          pw.Wrap(
            spacing: 24,
            runSpacing: 4,
            children: [
              _kv('Name', profile.name),
              if (profile.dateOfBirth != null)
                _kv('Date of birth',
                    '${df.format(profile.dateOfBirth!)}${age == null ? '' : '  (age $age)'}'),
              if (profile.healthcareProvider != null &&
                  profile.healthcareProvider!.isNotEmpty)
                _kv('Provider', profile.healthcareProvider!),
              if (medication != null) _kv('Medication', medication.name),
              if (currentDose != null)
                _kv('Current dose',
                    '${_fmt(currentDose.value)} ${DoseUnit.fromName(currentDose.unit).label}'),
            ],
          ),

          // Adherence.
          if (adherence != null) ...[
            sectionTitle('Adherence'),
            pw.Row(
              children: [
                _stat('Expected', '${adherence.expected}'),
                _stat('Taken', '${adherence.taken}'),
                _stat('Missed', '${adherence.missed}'),
                _stat('Adherence', '${adherence.percent}%'),
                _stat('Current streak', '${adherence.currentStreak}'),
              ],
            ),
          ],

          // Site rotation.
          sectionTitle('Injection site rotation'),
          pw.TableHelper.fromTextArray(
            headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold, fontSize: 9, color: blue),
            cellStyle: const pw.TextStyle(fontSize: 9),
            headerDecoration:
                const pw.BoxDecoration(color: PdfColor.fromInt(0xFFF0F4F8)),
            cellAlignment: pw.Alignment.centerLeft,
            data: [
              ['Site', 'Times used', 'Last used'],
              ...recencies.map((r) => [
                    r.site.name,
                    '${r.timesUsed}',
                    r.lastUsed == null
                        ? 'Never'
                        : '${df.format(r.lastUsed!)} (${r.daysSince}d ago)',
                  ]),
            ],
          ),

          // Growth.
          sectionTitle('Growth'),
          if (growthSorted.isEmpty)
            pw.Text('No measurements recorded.',
                style: pw.TextStyle(fontSize: 9, color: muted))
          else
            pw.TableHelper.fromTextArray(
              headerStyle: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold, fontSize: 9, color: blue),
              cellStyle: const pw.TextStyle(fontSize: 9),
              headerDecoration:
                  const pw.BoxDecoration(color: PdfColor.fromInt(0xFFF0F4F8)),
              data: [
                ['Date', 'Height', 'Weight', 'BMI', 'Velocity'],
                for (var i = growthSorted.length - 1; i >= 0; i--)
                  [
                    df.format(growthSorted[i].measuredAt),
                    growthSorted[i].heightCm == null
                        ? '-'
                        : UnitConverter.formatHeight(
                            growthSorted[i].heightCm!, units),
                    growthSorted[i].weightKg == null
                        ? '-'
                        : UnitConverter.formatWeight(
                            growthSorted[i].weightKg!, units),
                    GrowthMath.bmi(
                                heightCm: growthSorted[i].heightCm,
                                weightKg: growthSorted[i].weightKg)
                            ?.toStringAsFixed(1) ??
                        '-',
                    velocities[i]?.formatted(units) ?? '-',
                  ],
              ],
            ),

          // Dose timeline.
          sectionTitle('Dose history'),
          if (doseChanges.isEmpty)
            pw.Text('No dose changes recorded.',
                style: pw.TextStyle(fontSize: 9, color: muted))
          else
            pw.TableHelper.fromTextArray(
              headerStyle: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold, fontSize: 9, color: blue),
              cellStyle: const pw.TextStyle(fontSize: 9),
              headerDecoration:
                  const pw.BoxDecoration(color: PdfColor.fromInt(0xFFF0F4F8)),
              data: [
                ['Effective from', 'Dose', 'Reason'],
                ...doseChanges.map((d) => [
                      df.format(d.effectiveFrom),
                      '${_fmt(d.value)} ${DoseUnit.fromName(d.unit).label}',
                      d.reason ?? '',
                    ]),
              ],
            ),

          // Recent injections.
          sectionTitle('Injections in range (${inRange.length})'),
          if (inRange.isEmpty)
            pw.Text('None in this range.',
                style: pw.TextStyle(fontSize: 9, color: muted))
          else
            pw.TableHelper.fromTextArray(
              headerStyle: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold, fontSize: 9, color: blue),
              cellStyle: const pw.TextStyle(fontSize: 9),
              headerDecoration:
                  const pw.BoxDecoration(color: PdfColor.fromInt(0xFFF0F4F8)),
              data: [
                ['Date', 'Site', 'Dose', 'Notes'],
                ...inRange.map((i) {
                  final site = sites.firstWhere((s) => s.id == i.siteId,
                      orElse: () => sites.first);
                  return [
                    DateFormat('MMM d, yyyy').format(i.injectedAt),
                    i.skipped ? '${site.name} (skipped)' : site.name,
                    i.doseValue == null
                        ? '-'
                        : '${_fmt(i.doseValue!)} ${DoseUnit.fromName(i.doseUnit).label}',
                    i.notes ?? '',
                  ];
                }),
              ],
            ),
        ],
      ),
    );

    return doc.save();
  }

  pw.Widget _kv(String k, String v) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(k,
              style: pw.TextStyle(
                  fontSize: 8, color: const PdfColor.fromInt(0xFF6B7A89))),
          pw.Text(v, style: const pw.TextStyle(fontSize: 11)),
        ],
      );

  pw.Widget _stat(String label, String value) => pw.Expanded(
        child: pw.Column(
          children: [
            pw.Text(value,
                style: pw.TextStyle(
                    fontSize: 16, fontWeight: pw.FontWeight.bold)),
            pw.Text(label,
                style: pw.TextStyle(
                    fontSize: 8, color: const PdfColor.fromInt(0xFF6B7A89))),
          ],
        ),
      );

  String _fmt(double v) =>
      v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString();
}
