# OptiCalc Pro

Professional optometry/optics platform (Flutter + Firebase), documented in `Nova pasta OptiCalcPro/`. The repository currently holds **product specifications** (README, formulas, AI rules); the Flutter app and Firebase project are not checked in yet.

## Cursor Cloud specific instructions

### Repository state

- **Docs only today:** `Nova pasta OptiCalcPro/README.md.txt`, `FORMULAS_OPTICAS.md.txt`, `AGENTS.md.txt`.
- When `pubspec.yaml` exists at the repo root (or in an app subdirectory), run `flutter pub get` from that directory before `flutter run` / `flutter test`.

### Toolchain (pre-installed on the VM image)

| Tool | Location / notes |
|------|------------------|
| Flutter stable | `/opt/flutter` — add `/opt/flutter/bin` to `PATH` |
| Dart | Bundled with Flutter |
| Firebase CLI | `~/.local/bin/firebase` — user npm prefix; keep `PATH` including `$HOME/.local/bin` |
| Web / Linux targets | Use `flutter run -d chrome` or `flutter run -d linux` |

`flutter doctor` may warn about missing **Android SDK**; that is expected unless you install Android Studio. Web and Linux desktop are sufficient for most agent work here.

### Lint / test / run (once the app exists)

From the Flutter project root (when present):

| Task | Command |
|------|---------|
| Analyze | `flutter analyze` |
| Unit/widget tests | `flutter test` |
| Web dev server | `flutter run -d web-server --web-hostname=127.0.0.1 --web-port=8080` |
| Linux desktop | `flutter run -d linux` |

### Firebase (planned backend)

- Configure with `flutterfire configure` after a Firebase project exists.
- Local E2E: `firebase emulators:start` (Auth, Firestore, Storage as needed). No `firebase.json` in this repo yet.

### Long-running dev servers

Use **tmux** (not one-shot background shells) for `flutter run` and Firebase emulators, e.g. session name `optic-calc-web`.

### Environment demo (no app in repo)

Until the real app lands, agents can validate the stack with a throwaway project under `/tmp` (see cloud-agent setup notes) implementing formulas from `FORMULAS_OPTICAS.md.txt` (e.g. spherical equivalent: `EE = ESF + (CIL / 2)`).

### Gotchas

- If `npm install -g` fails with `EACCES`, use `export NPM_CONFIG_PREFIX="$HOME/.local"` and install CLIs there (Firebase CLI is already installed that way).
- Flutter’s git remote may show a non-standard upstream warning in `flutter doctor`; safe to ignore on this VM.
- `nvm` can conflict with `NPM_CONFIG_PREFIX`; if shells warn, `unset NPM_CONFIG_PREFIX` in that session or rely on `$HOME/.local/bin` on `PATH` without setting the prefix in shared profiles.
