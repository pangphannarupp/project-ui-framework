---
name: "security-and-quality-audit"
description: "Perform comprehensive security scanning (SAST, SCA, Secret Detection, IaC), Code Quality, a11y, dead code, and complexity audits"
---

# Security & Code Quality Audit Workflow

This skill guides scanning, analyzing, and resolving issues across 7 core pillars:
1. **SAST (Static Application Security Testing)**
2. **SCA (Software Composition Analysis & License Auditing)**
3. **Secret Detection & Git Hygiene**
4. **IaC Scanning (Infrastructure as Code & CI/CD)**
5. **Linters, Type Safety & Complexity Analysis**
6. **Dead Code, Circular Dependencies & Unused Exports**
7. **Accessibility (a11y) & Automated Testing**

---

## 1. SAST (Static Application Security Testing)

### Checklist & Patterns to Scan
- **XSS & Template Vulnerabilities**:
  - Check for unsafe Vue template usage like `v-html` or direct DOM manipulation (`element.innerHTML`, `element.outerHTML`, `document.write`).
  - Ensure any HTML rendering passes through an approved sanitization step (e.g., `DOMPurify.sanitize()`).
- **Code Injection & Unsafe Execution**:
  - Scan for `eval()`, `new Function()`, `setTimeout(string, ...)`, dynamic imports with unsanitized paths, or unsafe command execution in backend/node scripts (`exec()`, `spawn()` with shell injection vulnerabilities).
- **SQL / Query / Data Storage Injection**:
  - Ensure database queries in scripts or backend components use parameterized queries or parameterized ORM calls.
- **Insecure Communication & Storage**:
  - Scan for insecure protocols (`http://` instead of `https://`).
  - Scan for sensitive auth tokens, passwords, or encryption keys stored in plain `localStorage` or unencrypted device storage.

### Scan Commands
```bash
# Check for v-html and raw innerHTML usage
rg "v-html|innerHTML|outerHTML|document\.write|eval\("

# Check for http:// endpoints (excluding local dev/schemas)
rg "http://(?!localhost|127\.0\.0\.1|schemas\.|www\.w3\.org)"
```

---

## 2. SCA (Software Composition Analysis) & License Checks

### Dependency Vulnerabilities & Licenses
- **Node.js / Vue projects**:
  - Run `npm audit` in the relevant directories (`sample_apps/*`, `web/*`).
  - Ensure `package-lock.json` is in sync with `package.json`.
  - Check licenses of third-party packages to ensure permissive terms (MIT, Apache-2.0, BSD).
- **Flutter / Dart projects**:
  - Run `flutter pub outdated` or `dart pub outdated` in `flutter_ui_framework/` and `flutter_sample/`.
  - Ensure `pubspec.lock` is up-to-date.
- **Android (Gradle) & iOS (CocoaPods/SPM)**:
  - Check `build.gradle.kts` / `build.gradle` and `Podfile.lock` for vulnerable libraries.

---

## 3. Secret Detection & Git Hygiene

### Secret Patterns to Detect
- **Cloud & AI API Keys**: Google Cloud (`AIza*`), OpenAI (`sk-*`), Anthropic (`sk-ant-*`), AWS (`AKIA*`).
- **Private Keys & Certificates**: `-----BEGIN [A-Z ]*PRIVATE KEY-----`, keystores (`*.jks`, `*.keystore`, `*.p12`).
- **Tokens & Credentials**: GitHub PATs (`ghp_*`), JWT Tokens (`ey...`), hardcoded password strings.

### Verification Commands
```bash
rg -i "(password|secret|apikey|api_key|access_token|private_key|auth_token)\s*[:=]\s*[\"'][^\"'\s]{8,}[\"']" --glob "!.agents/**" --glob "!node_modules/**" --glob "!.git/**"
rg "(AIza[0-9A-Za-z-_]{35}|ghp_[0-9a-zA-Z]{36}|AKIA[0-9A-Z]{16}|BEGIN (RSA|EC|DSA|OPENSSH) PRIVATE KEY)"
```

---

## 4. IaC & CI/CD Security Scanning

### Infrastructure & Configuration Audits
- **GitHub Actions Workflows (`.github/workflows/`)**:
  - Ensure workflows specify least privilege permissions (e.g. `permissions: contents: read`).
  - Scan for unpinned third-party actions or insecure step runs (e.g. evaluating untrusted PR event data in run steps).
- **Mobile Manifests & Network Security**:
  - Android: Ensure `android:usesCleartextTraffic` is set to `false` in production manifests.
  - iOS: Check `Info.plist` for overly permissive `NSAllowsArbitraryLoads`.

---

## 5. Linters, Type Safety & Complexity Metrics

### Checks
- **TypeScript / Vue**:
  - Run type checks (`vue-tsc --noEmit` or `tsc --noEmit`).
  - Run linter (`npm run lint` or `npx eslint .`).
  - Flag overly complex methods (>15 cognitive complexity) and oversized single files (>400 lines).
- **Flutter / Dart**:
  - Run `flutter analyze` inside Flutter packages.
- **Android / Kotlin & iOS / Swift**:
  - Check with `./gradlew lint` or `ktlint` (Android) and `SwiftLint` (iOS).

---

## 6. Dead Code, Circular Dependencies & Package Hygiene

### Detection Strategy
- **Dead Code / Unused Exports**:
  - Check for unused components, orphaned styles, and unreferenced exports (using `knip` or `ts-prune`).
- **Circular Dependencies**:
  - Scan modules for recursive or circular imports using `madge --circular .` or `dpdm`.

---

## 7. Accessibility (a11y) & Automated Testing

### Quality & Accessibility Gates
- **WCAG 2.1 AA Compliance**:
  - Verify interactive UI elements have accessible labels (`aria-label`, `aria-expanded`, alt texts).
  - Verify keyboard focus visible indicators and tab indexing.
- **Unit & Component Tests**:
  - Execute Vitest tests (`npm run test`) for core UI Framework components.
  - Execute Flutter widget tests (`flutter test`).
- **Bundle Size Budgets**:
  - Inspect production bundle build outputs to verify gzip sizes remain within reasonable budgets.

---

## Full Audit Execution Routine

1. **SAST & Secret Sweep**: Execute pattern scans for secrets, injection, and unsanitized DOM sinks.
2. **SCA & Dependency Audit**: Run `npm audit` and verify lockfiles.
3. **IaC & Workflow Audit**: Review permissions and environment isolation in `.github/workflows/`.
4. **Type Check & Linting**: Run `vue-tsc` / `flutter analyze` / `eslint`.
5. **Hygiene & a11y Check**: Audit dead code, circular imports, and accessibility tags.
6. **Consolidate & Report**: Provide severity-rated findings with line links and remediation steps.
