---
name: "bizmob-native-dev"
description: "Workflow for developing and integrating bizMOB Native Hybrid APIs and Plugins in Vue applications"
---

# bizMOB Native Hybrid Development Workflow

This skill outlines the standard workflow for implementing native hybrid feature screens, invoking bizMOB plugins, and displaying interactive hardware/plugin controls in Vue 3 applications.

## Key Capabilities & Namespaces

1. **bizMOB Window & Hardware Views**:
   - `bizMOB.Window.openCodeReader({ _fCallback })`: Launch native Barcode/QR reader.
   - `bizMOB.Window.openSignPad({ _sTargetPath, _fCallback })`: Open signature canvas modal.
   - `bizMOB.Window.openImageViewer({ _sImagePath, _fCallback })`: Open photo gallery viewer.
   - `bizMOB.Window.openFileExplorer({ _atype, _fCallback })`: Invoke native file picker.

2. **bizMOB Device & System APIs**:
   - `bizMOB.Device.getInfo()`: Retrieve device model, OS, and UUID.
   - `bizMOB.System.getGPS({ _fCallback })`: Fetch GPS latitude & longitude.
   - `bizMOB.System.callGallery({ _aType, _fCallback })`: Open device image gallery.
   - `bizMOB.System.callCamera({ _sTargetPath, _fCallback })`: Capture photo from device camera.
   - `bizMOB.System.callSMS({ _aNumber, _sMessage, _fCallback })`: Trigger native SMS.
   - `bizMOB.System.callTEL({ _sNumber, _fCallback })`: Launch native phone dialer.
   - `bizMOB.System.callExternalBrowser({ _sURL, _fCallback })`: Launch system web browser.

3. **bizMOB Custom Plugins (`bizMOB.App.callPlugIn`)**:
   - `TAKE_PHOTO_PLUGIN`: Custom camera capture with base64 result.
   - `HAPTIC_PLUGIN`: Custom vibration types (1, 2, 3) and repetition.
   - `SCREENSHOT_PLUGIN`: Toggle screenshot prevention security flags.
   - `SET_SHAKE`: Listen for accelerometer shake motions.
   - `REQUEST_HTTP`: Native background HTTP requests bypassing CORS restrictions.

## Implementation Standard in Vue 3

1. **Wrap in Async / Promise Utilities**:
   Always provide clean promise wrappers or reactive composables so views do not rely on raw callback spaghetti.
2. **Safe Web Fallback**:
   Check `window.bizMOB?.Device?.isApp()` or mock responses so features can be previewed seamlessly in regular browsers.
3. **Use `@phanna/ui-framework`**:
   Build screens using `PPButton`, `PPTextField`, `PPBottomSheet`, `PPChip`, `PPBadge`, `PPToast`, `PPQRCode` with live response viewers.
