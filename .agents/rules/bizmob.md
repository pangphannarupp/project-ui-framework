# bizMOB Native & Vue Plugin Integration Rules

When developing or integrating native hybrid features and bizMOB plugins in Vue applications (such as `sample_apps/mini-showcase-hub`, `bizmob-vue-sample`, and other hybrid apps), follow these mandatory architectural principles:

## 1. bizMOB Native Architecture & Calling Patterns

1. **Global Accessor & Types**:
   - Access the global bridge via `window.bizMOB` or `(this as any).$bizMOB`.
   - Provide safe fallback/mock handling for Web mode (`bizMOB.Device.isWeb()`) to ensure smooth local browser development without crashing.
   
2. **Standard bizMOB Core Namespaces**:
   - **`bizMOB.Window`**: Window and native modal views.
     - `openCodeReader({ _fCallback })`: Opens native barcode / QR scanner.
     - `openSignPad({ _sTargetPath, _fCallback })`: Opens native signature draw pad.
     - `openImageViewer({ _sImagePath, _fCallback })`: Native high-resolution photo viewer.
     - `openFileExplorer({ _atype, _fCallback })`: Native file picker dialog.
   - **`bizMOB.System`**: Device OS hardware and sensor triggers.
     - `getGPS({ _fCallback })`: Retrieves native GPS coordinates.
     - `callGallery({ _aType, _fCallback })`: Opens native system photo gallery.
     - `callCamera({ _sTargetPath, _fCallback })`: Captures camera photos.
     - `callSMS({ _aNumber, _sMessage, _fCallback })`: Dispatches native SMS composer.
     - `callTEL({ _sNumber, _fCallback })`: Initiates phone call dialer.
     - `callExternalBrowser({ _sURL, _fCallback })`: Launches default OS browser with URL.
   - **`bizMOB.Device`**: Device hardware metadata & environment detection.
     - `getInfo()`: Returns model name, OS version, app version, unique device ID.
     - `isApp()` / `isWeb()`: Platform runtime check.
   - **`bizMOB.App`**: App lifecycle & custom plugin bridges.
     - `callPlugIn(apiName, params)`: Executes custom native plugins (e.g. `TAKE_PHOTO_PLUGIN`, `HAPTIC_PLUGIN`, `SCREENSHOT_PLUGIN`, `SET_SHAKE`, `REQUEST_HTTP`).
     - `exit({ _sType: "exit" | "kill" })`: Terminates app process.
   - **`bizMOB.File`**: Hybrid sandbox file management.
     - `download({ _aFileList, _sMode, _sProgressBar, _fCallback })`: Downloads files to sandbox storage (`{external}/`, `{internal}/`).
     - `open({ _sSourcePath, _fCallback })`: Opens local files in system viewers.
     - `copy`, `move`, `remove`, `zip`, `unzip`, `exist`, `directory`, `resizeImage`.
   - **`bizMOB.Network` & `bizMOB.Properties` / `Storage`**:
     - `requestTr({ _sTrcode, _oHeader, _oBody, _fCallback })`: Gateway request to bizMOB server.
     - `Properties.set({ _sKey, _vValue })` / `Properties.get({ _sKey })`: Encrypted/persisted cross-session key-value storage.

## 2. Vue 3 Integration & Screen Implementation Standard

1. **Stateful vs Stateless Pattern**:
   - **Stateful Container (`src/views/`)**: Handles `bizMOB` calling methods, promise resolution, error handling, loading spinners, and state updates.
   - **Stateless Subcomponents (`src/components/`)**: Receive response data via `props` and emit user actions (e.g. `@trigger-scan`, `@submit-signature`).
2. **Lifecycle & Native Hardware Events**:
   - Register hardware events (like Android hardware `backbutton`, lifecycle pause/resume) using `bizMOB.addEvent("backbutton", handler)` on mount, and clean up on unmount.
3. **UI Framework Compliance**:
   - Exclusively render UI with `@phanna/ui-framework` (`PPButton`, `PPTextField`, `PPBottomSheet`, `PPToast`, `PPBadge`, `PPChip`, `PPQRCode`, `PPSwitch`, etc.).
   - Display raw request params and JSON responses in formatted inspectable code panels for testing and debugging.
