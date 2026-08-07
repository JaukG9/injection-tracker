# SiteCycle: Injection Tracker

A private, offline app for anyone on a scheduled injectable medication. It helps
you remember which site to use next, keep an honest log of your doses, track
growth over time, and hand your care team a clean summary at appointments.
Nothing leaves the device unless you choose to export or share it.

The app started life as an HTML prototype and was rebuilt in Flutter. It runs on
iPhone and Android.

## What it does

- **Site rotation helper.** A body map colors each site red, amber, or green
  based on how recently it was used, and suggests the site that has rested the
  longest. The thresholds scale with how many sites you have in rotation, so
  there is always at least one green site to reach for.
- **Injection log.** Record the site, date, dose, and a note. Browse the full
  history, color coded by body region.
- **Dose tracking.** Keep a timeline of dose changes, from starting therapy
  through any titration steps.
- **Calendar and adherence.** See the month at a glance with taken and missed
  days, your current streak, and an adherence percentage.
- **Growth tracker.** Log height and weight, watch the trend on a chart, and see
  BMI and growth rate.
- **Medication presets.** Pick from a catalog grouped by category (growth
  hormone, diabetes, and more) that fills in the usual unit and injection areas
  for you, with a reminder to follow your prescriber.
- **Reminders.** Local notifications for scheduled doses.
- **Privacy and security.** All data is stored locally. The app can be locked
  behind your device passcode or biometrics, and you can export or back up your
  data yourself.
- **Reports.** Generate a PDF summary to share or print for an appointment.

## Repository layout

```
.
├── app/            The Flutter application
├── images/         Store assets
│   ├── ios/        App Store screenshots and previews (iPhone 17)
│   └── android/    Google Play screenshots
├── index.html      Marketing landing page
├── privacy.html    Privacy policy
└── README.md       This file
```

The store assets each have their own README describing sizes and contents. See
[images/ios/README.md](images/ios/README.md) and
[images/android/README.md](images/android/README.md).

## The app

Built with Flutter and Dart. A quick tour of the main pieces:

- **State:** Riverpod
- **Local database:** Drift on SQLite
- **Navigation:** go_router
- **Charts:** fl_chart
- **Reminders:** flutter_local_notifications
- **Security:** local_auth and flutter_secure_storage
- **Reports and sharing:** pdf, printing, and share_plus

The code under `app/lib` is organized in layers:

```
app/lib
├── app/        Routing, theme, and providers that wire everything together
├── core/       Constants, small utilities, and shared widgets
├── data/       The Drift database, repositories, and services
├── domain/     Models and pure logic (rotation, adherence, dose and growth math)
└── features/   One folder per screen area (dashboard, calendar, growth, ...)
```

The `domain` layer is kept free of database and UI code so the rules can be unit
tested on their own. The site rotation and adherence logic both have test suites
under `app/test`.

## Running it

From the `app` folder:

```bash
flutter pub get
flutter run
```

To build a release for a store:

```bash
flutter build ipa      # iOS
flutter build appbundle  # Android
```

Run the tests with:

```bash
flutter test
```

## Privacy

This app is a memory aid, not medical advice. Always follow the injection,
rotation, and growth guidance your care team gives you. Your data stays on your
device unless you export or share it yourself. The full policy is in
[privacy.html](privacy.html).
