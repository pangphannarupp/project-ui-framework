# Security, Dependency, Secrets, IaC & Code Quality Guidelines

This rule defines mandatory scanning and code quality auditing practices across all codebases in this workspace (Web/Vue/TypeScript, Flutter/Dart, Android/Kotlin, iOS/Swift, and scripts/IaC/CI configurations).

---

## 1. SAST (Static Application Security Testing)
- **XSS & Injection Prevention**:
  - Web (Vue/TS): Never use `v-html` or `innerHTML` with unsanitized user-controllable input. Use DOMPurify or built-in template bindings `{{ }}`.
  - Query / SQL / Param construction: Always use parameterized queries or type-safe ORM/Query builders; prevent raw string interpolation in database or shell commands.
- **Input Validation & Sanitization**:
  - Enforce schema validation (e.g. Zod / Valibot / class validators) on external endpoints, forms, deep links, and IPC messages.
- **Client-Side Storage**:
  - Never store sensitive data (tokens, PII, payment info) in unencrypted `localStorage` or unencrypted SQLite/SharedPreferences. Use OS-level secure storage (Keychain on iOS, EncryptedSharedPreferences/Keystore on Android, SecureStorage on Flutter).
- **Insecure Deserialization & Evaluators**:
  - Avoid `eval()`, `new Function()`, `unsafe_load` / unsafe reflection deserialization.

---

## 2. SCA (Software Composition Analysis) & Dependencies
- **Vulnerability Checks**:
  - Run package vulnerability audits regularly (`npm audit`, `flutter pub outdated`, `bundle audit`, `gradle dependencyCheckAnalyzer`).
- **Dependency Hygiene**:
  - Maintain committed lockfiles (`package-lock.json`, `pubspec.lock`, `Podfile.lock`).
  - Avoid wildcard/floating versions in production dependencies (`*` or `latest`).
  - Regularly prune unused dependencies and tree-shake libraries.
  - Review licenses of third-party dependencies with license-checker (ensure MIT, Apache 2.0, BSD; prohibit AGPL/GPL copyleft without authorization).

---

## 3. Secret Detection & Credential Hygiene
- **Zero Secrets in Code**:
  - Strictly prohibit hardcoded API keys, private keys, JWT secrets, OAuth tokens, AWS/GCP credentials, database passwords, or auth bearer tokens in Git.
- **Environment Separation**:
  - Use environment variables (`.env.local`, `.env.example`), secret managers (GCP Secret Manager, HashiCorp Vault), or CI/CD secrets.
  - Keep `.env`, `.env.local`, `*.keystore`, `*.jks`, `*.p12`, `*.mobileprovision` strictly in `.gitignore`.
- **Pre-commit & Staged Hook Scanning**:
  - Automate local pre-commit checks with Husky/lint-staged & Gitleaks regex scanning before any commit enters git history.

---

## 4. IaC (Infrastructure as Code) & CI/CD Security
- **Least Privilege Access**:
  - GitHub Actions, Dockerfiles, and cloud resources must run with minimal necessary permissions (`permissions: contents: read`, non-root user in Dockerfiles).
- **Pinned Actions & Images**:
  - Pin GitHub Actions by commit SHA or audited tags. Pin base Docker images with specific digests or patch versions (avoid `latest`).
- **Secure Networking & Ports**:
  - Ensure CORS policies, CSP (Content Security Policy) headers, and open ports are locked down to trusted origins.
- **TLS/HTTPS Enforcement**:
  - Disable cleartext traffic in mobile configs (`android:usesCleartextTraffic="false"` and `NSAppTransportSecurity` exceptions).

---

## 5. Linters, Static Analysis & Complexity Metrics
- **Type Safety**:
  - Web: Strict TypeScript (`strict: true`, no unnecessary `any`, proper interface definitions).
  - Mobile: Strong typing in Kotlin/Swift/Dart (null safety strictly enforced).
- **Complexity & Maintainability**:
  - Limit cyclomatic and cognitive complexity in component methods and composables.
  - Avoid large monolithic components (>400 lines); split into composables and presentational sub-components.
- **Circular Dependencies & Dead Code**:
  - Scan for circular dependencies using tools like `madge` or `dpdm`.
  - Scan and eliminate dead exports and orphaned files using `knip` or `ts-prune`.

---

## 6. Automated Testing & Accessibility (a11y)
- **Unit & Component Testing**:
  - Web: Vitest + `@vue/test-utils` for component prop/event validation.
  - Flutter: Widget tests for `flutter_ui_framework`.
- **Accessibility Standards**:
  - Enforce WCAG 2.1 AA compliance: adequate color contrast, proper ARIA roles/labels, and full keyboard navigability on interactive UI elements.
- **Bundle Size Budgets**:
  - Maintain performance budgets for build artifacts (e.g. gzip limit for UI framework libraries).
