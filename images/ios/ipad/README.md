# iPad store assets

These are the App Store screenshots for the iPad. They were captured from the
same app running on the iPad Pro 13-inch (M5) simulator (iOS 26), loaded with
the same "Ayaan" sample profile used for the iPhone set: about seven weeks of
daily growth hormone injections rotating across six sites, a dose that steps
up from 0.4 mg to 0.6 mg partway through, and six months of height and weight
entries.

The iPad layout is different from the iPhone one. Navigation moves to a
sidebar, the rotation grid becomes three columns instead of two, and most
screens fit everything on one page without scrolling. Because of that, a
couple of these shots (the dashboard and the rotation overview, for example)
show the same screen, since the rotation grid is already fully visible on the
dashboard and there is nothing further to scroll to.

## Sizes

- PNG, 2064 by 2752 pixels (iPad Pro 13-inch at 2x).
- This is one of the four sizes Apple accepts for iPad screenshots
  (2064x2752, 2752x2064, 2048x2732, or 2732x2048).

## Screenshots

| File | Screen | What it shows |
|---|---|---|
| `01-dashboard.png` | Home | The greeting, the suggested next site, the current dose, and the full site rotation grid, all visible at once on the larger screen. |
| `02-rotation-overview.png` | Site rotation | The same dashboard view, since the rotation grid does not need scrolling to see on iPad. |
| `03-log-injection.png` | Log injection | The medication and route banner, the color key, tappable front and back body maps, and the date and dose fields. |
| `04-history.png` | Injection history | A dated log with site pills, dose, and the occasional note. |
| `05-calendar.png` | Calendar | The current month with a 100 percent adherence and a running streak. |
| `06-growth.png` | Growth tracker | The height and weight entry form and both charts, height and weight, in one view. |
| `07-growth-history.png` | Growth history | The full dated history with BMI and a growth rate in inches per year. |
| `08-settings.png` | Settings | Profile, medication, theme, units, doctor report, security, and reminders, all on one page. |
| `09-medications.png` | Medication catalog | The preset picker grouped by category, showing more categories at once than fits on an iPhone screen. |
| `10-dashboard-dark.png` | Home (dark) | The same dashboard as `01`, in dark mode. |

## A few notes for the listing

- App Store Connect takes up to 10 screenshots per device size, so this set of
  10 is the most you can use.
- These are captured in light theme except for the last shot. If you want more
  dark mode coverage, switch the simulator to dark (Settings, then Appearance,
  then Dark on the app itself, or `xcrun simctl ui <device> appearance dark`)
  and recapture.
- If you need one of the other three accepted iPad sizes instead (2752x2064,
  2048x2732, or 2732x2048), boot a simulator whose native resolution matches,
  such as an iPad Pro 12.9-inch for 2048x2732, and recapture the same screens.
