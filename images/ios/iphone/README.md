# iPhone store assets

These are the App Store screenshots and app previews for the iPhone. Everything
here was captured from the app running on the iPhone 17 simulator (iOS 26), so
the sizes match what App Store Connect expects for that device.

To make the screens look like real use rather than a blank first launch, the
app was loaded with a sample profile ("Ayaan"): about seven weeks of daily
growth hormone injections rotating across six sites, a dose that steps up from
0.4 mg to 0.6 mg partway through, and six months of height and weight entries.

## Sizes

- Screenshots: PNG, 1206 by 2622 pixels (iPhone 17 at 3x, the 6.3 inch class).
- App previews: H.264 .mp4, 1206 by 2622, portrait, 22 to 27 seconds each.

## Screenshots

| File | Screen | What it shows |
|---|---|---|
| `01-dashboard.png` | Home | The greeting, the suggested next site (green, "good to use"), the current dose in mg and mg/kg, and the color coded body map. This is the main shot. |
| `02-rotation-overview.png` | Site rotation | All six sites with how long ago each was used and a red, amber, or green status. There is always at least one green site to reach for. |
| `03-log-injection.png` | Log injection | The medication and route banner, the color key, tappable front and back body maps, the selected site, and the date and dose fields. |
| `04-history.png` | Injection history | A dated log with site pills, dose, and the occasional note. |
| `05-calendar.png` | Calendar | A month of logged days with a 100 percent adherence and 31 day streak summary. |
| `06-growth.png` | Growth tracker | The height and weight entry form and a chart that climbs over time. |
| `07-growth-history.png` | Growth history | Dated measurements with BMI and a growth rate in inches per year. |
| `08-settings.png` | Settings | Profile, medication, theme, and units in one place. |
| `09-medications.png` | Medication catalog | The preset picker grouped by category, with brand examples and a reminder to follow your prescriber. |
| `10-dashboard-dark.png` | Home (dark) | The same dashboard as `01`, in dark mode, so the listing can show both looks side by side. |

## App previews

| File | Length | What happens |
|---|---|---|
| `preview-1-home.mp4` | 22s | A look around the dashboard, scrolling down through the color coded rotation map and back. |
| `preview-2-log.mp4` | 25s | Logging an injection, opening the log screen and tapping between sites on the body map. |
| `preview-3-tracking.mp4` | 27s | Following the progress screens, from the calendar to history to the growth chart. |

## A few notes for the listing

- App Store Connect takes up to 10 screenshots and 3 previews per device size.
  This set has exactly 10, with the dark dashboard standing in for a second
  home shot so the listing can show both looks.
- The previews were captured as plain screen recordings and then sped up a
  little so each one fits under the 30 second limit. If a device tier rejects
  the exact dimensions, re-record or re-encode to the size it asks for.
- The rotation colors follow a simple rule: a site turns green again after it
  has rested a few days, and the number of days scales with how many sites are
  in rotation, so there is always a good spot to suggest. Green tops out at 4
  days of rest.
