# Ultimate Box Score

Offline ultimate frisbee box score recording for Android and Linux desktop in
English and Simplified Chinese, selected from the device locale.

## Features

- Persistent Team, Games, and Stats navigation on Android and Linux.
- Event rosters and reusable, unrestricted-size line presets.
- Team and roster management with historical game snapshots and archiving.
- Durable single-team recording with stable player order in the live UI.
- ABBA mixed-ratio prompts, halftime, continuous cap timers, and target score.
- Actor-to-target action history, audit-preserving undo, crash-safe resume,
  abandoned-point recovery, and reopening.
- Per-game statistics and completed-game career totals.
- Full, team, event, and game ZIP exports with lossless JSON and relational CSV.

The application uses Riverpod, Drift/SQLite, GoRouter, and Material 3. Scores and
statistics are derived by replaying the persisted action log rather than stored
as editable counters.

## Development

Requirements: Flutter 3.47 or later with an Android toolchain and/or the Flutter
Linux desktop prerequisites (GTK 3, CMake, Ninja, and a C++ toolchain).

```sh
flutter pub get
dart run build_runner build
flutter gen-l10n
flutter analyze
flutter test
flutter run
```

Build an Android debug APK with:

```sh
flutter build apk --debug
```

Build the Linux desktop bundle with:

```sh
flutter build linux
```

The relocatable Linux bundle is written under `build/linux/x64/release/bundle/`.

## Download CI builds

The `Build artifacts` GitHub Actions workflow builds Android, Linux, and Windows
release bundles after validation succeeds. Open a completed workflow run in the
repository's **Actions** tab and download one of these artifacts:

- `ultimate-box-score-android`
- `ultimate-box-score-linux-x64`
- `ultimate-box-score-windows-x64`

Artifacts are retained for 30 days. The workflow also supports manual runs from
the **Run workflow** button.

The original product brief remains in [design.md](design.md). Clarified product
rules, architecture, and stat semantics are documented separately in
[IMPLEMENTATION_DESIGN.md](IMPLEMENTATION_DESIGN.md).
