# Ultimate Box Score

Offline ultimate frisbee box score recording for iPhone, Android, Linux, and
Windows in English and Simplified Chinese, with a system-default or explicit
language preference.

## Features

- Persistent Team, Games, Stats, and Settings navigation across supported platforms.
- A persistent Settings page with an immediate, saved language preference.
- Event rosters and reusable, unrestricted-size line presets.
- Team and roster management with historical game snapshots and archiving.
- Durable single-team recording with stable player order in the live UI.
- ABBA mixed-ratio prompts, halftime, continuous cap timers, and target score.
- Actor-to-target action history, destructive undo, crash-safe resume,
  abandoned-point recovery, and reopening.
- Per-game statistics and completed-game career totals.
- Full, team, event, and game ZIP exports with lossless JSON and relational CSV.

The application uses Riverpod, Drift/SQLite, GoRouter, and Material 3. Scores and
statistics are derived by replaying the persisted action log rather than stored
as editable counters.

## Development

Requirements: Flutter 3.47 or later and a toolchain for your target platform.
iPhone builds require macOS with Xcode and CocoaPods.

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

Build an unsigned iPhone app with:

```sh
flutter build ios --release --no-codesign
```

Running on a physical iPhone or distributing through TestFlight/App Store
requires an Apple Developer signing team and provisioning profile.

Build the Linux desktop bundle with:

```sh
flutter build linux
```

The relocatable Linux bundle is written under `build/linux/x64/release/bundle/`.

## Releases

Download versioned builds from [GitHub Releases](https://github.com/dwuggh/ultimate-box-score/releases).
Each release contains an Android APK, an unsigned iOS app ZIP, a Linux x64
tarball, a Windows x64 ZIP, and `SHA256SUMS`. All four builds are produced by
GitHub Actions after generated-source checks, analysis, and tests succeed.

The Android APK currently uses debug signing, so later CI builds may require
uninstalling an earlier build before installation. Export your data first.
The iOS app requires Apple signing and provisioning before installation.

To publish a release:

1. Set `version: <version>+<build-number>` in `pubspec.yaml` and add release notes
   in `.github/release-notes/<version>.md`.
2. Push a `release/<version>` branch or a `v<version>` tag pointing to that commit.
   Alternatively, manually run **Build artifacts** with **publish_release** enabled.
3. Actions builds all platforms, checksums the downloads, and publishes the
   release from that exact commit. A release branch or manual run also creates
   the `v<version>` tag. Existing published releases are never overwritten.

Release branch/tag versions must match `pubspec.yaml`. Ordinary branch pushes,
pull requests, and manual runs without **publish_release** only produce CI
artifacts. A failed release upload remains a draft and can be retried on the
same commit.

## Download CI builds

The `Build artifacts` GitHub Actions workflow builds Android, iOS, Linux, and
Windows release bundles after validation succeeds. Open a completed workflow
run in the repository's **Actions** tab and download one of these artifacts:

- `ultimate-box-score-android`
- `ultimate-box-score-ios-unsigned`
- `ultimate-box-score-linux-x64`
- `ultimate-box-score-windows-x64`

Artifacts are retained for 30 days. The workflow also supports manual runs from
the **Run workflow** button. The iOS artifact is an unsigned `Runner.app` ZIP
intended for CI verification; it must be signed before installation or
distribution.

The original product brief remains in [design.md](design.md). Clarified product
rules, architecture, and stat semantics are documented separately in
[IMPLEMENTATION_DESIGN.md](IMPLEMENTATION_DESIGN.md).
