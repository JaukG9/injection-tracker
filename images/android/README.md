# Store screenshots (Android)

Publication-ready phone screenshots captured from a release build of the app
running on an Android emulator, using a realistic sample profile ("Emma").

**Format:** PNG, **1080 × 2160** (2:1 aspect ratio, within the Google Play limit
of "max dimension no more than 2× the min dimension"; min 320px, max 3840px).
The status bar and gesture pill were trimmed from the raw 1080 × 2340 captures.

| File | Screen | What it shows |
|---|---|---|
| `01-dashboard.png` | Home / Dashboard | Personalized greeting, suggested rotation site, current dose (mg + mg/kg), and the color-coded body map. The hero shot. |
| `02-rotation-overview.png` | Site Rotation Overview | All ten sites with recency ("last used yesterday … 10 days ago") and red/amber/green status. |
| `03-log-injection.png` | Log Injection | Medication + route banner, recency legend, tappable front/back body maps, selected site, date/time and dose. |
| `04-growth-chart.png` | Growth Tracker | Height/weight logging form and a growth chart (`fl_chart`). |
| `05-calendar.png` | Calendar | Month view of injected days, today marker, and a "This month" adherence summary (100% / streak). |
| `06-history.png` | Injection History | Dated log with color-coded site pills, dose, and notes. |
| `07-settings.png` | Settings | Profile, medication, theme (light/dark/system), and units. |
| `08-medications.png` | Medication catalog | The preset picker across categories (growth hormone, diabetes, …) with the "follow your prescriber" safety note. |

## Notes for the listing
- Google Play requires **2–8** phone screenshots; this set of 8 is the maximum.
- If a target store or device tier wants a different ratio (e.g. strict 9:16),
  re-crop from the source or re-capture; `app/tool/crop_screenshots.dart`
  crops raw captures to 1080 × 2160.
- These are captured in **light theme**. Consider adding a couple of dark-theme
  shots (Settings → Appearance → Dark) if you want to show it off.
