# Repository Guidelines

## Project Structure & Module Organization
- Source: `Aura/`
  - `App/` (entry: `AuraApp.swift`), `Core/` (e.g., `MenuBarView.swift`)
  - `Features/Highlight/` (highlight window/manager)
  - `Features/Settings/` (settings view/window)
  - `Models/` (e.g., `AppState.swift`, `HighlightSettings.swift`)
  - `Services/` (`MouseEventMonitor.swift`, `SettingsManager.swift`)
  - `Resources/` (assets, icon tools)
- Tests: `AuraTests/` (`*Tests.swift`)
- Build scripts: `scripts/` (`build.sh`, `create-dmg.sh`, `release.sh`)
- CI/CD: `.github/workflows/` (build/test/release)
- Project config: `project.yml` (XcodeGen), generated Xcode project: `Aura.xcodeproj/`

## Build, Test, and Development Commands
- Generate Xcode project: `xcodegen generate` (requires `brew install xcodegen`).
- Open in Xcode: `open Aura.xcodeproj` (scheme `Aura`).
- Build (CLI): `xcodebuild build -project Aura.xcodeproj -scheme Aura -destination 'platform=macOS'`.
- Test (CLI): `xcodebuild test -project Aura.xcodeproj -scheme Aura -destination 'platform=macOS'`.
- Scripted build: `./scripts/build.sh` (Release archive, unsigned).
- Create DMG: `./scripts/create-dmg.sh` (outputs `build/Aura-<version>.dmg`).

## Coding Style & Naming Conventions
- Language: Swift 5.9, macOS 13+, SwiftUI + AppKit.
- Indentation: 4 spaces; keep lines focused and readable.
- Names: `PascalCase` types, `lowerCamelCase` vars/functions, enum cases `lowerCamelCase`.
- Structure: one primary type per file, use `// MARK:` sections, prefer `final` where applicable, avoid force unwraps.
- Lint/format: no enforced tool in repo; use SwiftFormat/SwiftLint locally if desired. Keep bilingual comments consistent with existing code.

## Testing Guidelines
- Framework: XCTest; tests live in `AuraTests/` and end with `Tests`.
- Style: Arrange–Act–Assert; focus on Services/ViewModels and core logic. Target ≥80% coverage for core logic.
- Run: via Xcode test action or CLI (see above). CI runs `build-test` on PRs.

## Commit & Pull Request Guidelines
- Commits: imperative, concise subject (e.g., "Add HighlightWindow fade animations"); include scope when helpful.
- PRs: small, focused, with description, linked issues, and screenshots for UI changes. Note any permission/signing caveats.
- Requirements: branch from `develop` (or as configured), pass CI, run local build/tests, and update docs (`docs/`, `README.md`) when behavior changes.

## Security & Configuration Tips
- Accessibility permission is required at runtime for global mouse events.
- Code signing is disabled in local scripts/CI; use `scripts/sign-and-notarize.sh` for distribution. Do not commit secrets.
- Project is generated from `project.yml`; edit it instead of hand-editing the `.xcodeproj`.

