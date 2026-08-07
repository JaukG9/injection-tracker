# Android store assets

These are the Google Play screenshots for the phone. They were captured from a
release build running on an Android emulator, using a sample profile ("Emma") so
the screens show real looking data instead of an empty first launch.

## Sizes

- PNG, 1080 by 2160 pixels (a 2 to 1 ratio).
- This stays inside Google Play's rule that the longest side is no more than
  twice the shortest, with a 320 pixel minimum and a 3840 pixel maximum.
- The status bar and the gesture pill were trimmed off the raw 1080 by 2340
  captures.

## Screenshots

| File | Screen | What it shows |
|---|---|---|
| `01-dashboard.png` | Home | The greeting, the suggested next site, the current dose in mg and mg/kg, and the color coded body map. This is the main shot. |
| `02-rotation-overview.png` | Site rotation | All the sites with how long ago each was used and a red, amber, or green status. |
| `03-log-injection.png` | Log injection | The medication and route banner, the color key, tappable front and back body maps, the selected site, and the date and dose fields. |
| `04-growth-chart.png` | Growth tracker | The height and weight entry form and a growth chart. |
| `05-calendar.png` | Calendar | A month of logged days, a marker for today, and a summary for the month. |
| `06-history.png` | Injection history | A dated log with site pills, dose, and notes. |
| `07-settings.png` | Settings | Profile, medication, theme, and units. |
| `08-medications.png` | Medication catalog | The preset picker across categories, with a reminder to follow your prescriber. |

## A few notes for the listing

- Google Play wants between 2 and 8 phone screenshots, so this set of 8 is the
  most you can use.
- If a store or device tier wants a different ratio, such as a strict 9 to 16,
  re-crop from the source or capture again. `app/tool/crop_screenshots.dart`
  crops raw captures to 1080 by 2160.
- These are all in the light theme. The iOS folder has a dark mode shot if you
  want to see how that looks, and you can capture the same on Android from
  Settings then Appearance then Dark.
