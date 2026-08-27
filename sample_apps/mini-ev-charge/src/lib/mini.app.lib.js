/**
 * MiniApp JS SDK (mini.app.lib.js)
 * Cross-platform JavaScript bridge supporting Android (WebView) and iOS (WKWebView).
 */
(function (global, factory) {
  if (typeof module === 'object' && typeof module.exports === 'object') {
    module.exports = factory(global);
  } else if (typeof define === 'function' && define.amd) {
    define([], function () {
      return factory(global);
    });
  } else {
    global.MiniApp = factory(global);
  }
})(typeof window !== 'undefined' ? window : this, function (window) {
  'use strict';

  // Constants
  const SERVICE_TYPES = {
    MOBILE_TOPUP: 'MOBILE_TOPUP',
    BILL_PAYMENT: 'BILL_PAYMENT',
    KHQR_PURCHASE: 'KHQR_PURCHASE',
    KHQR_PERSONAL: 'KHQR_PERSONAL',
    PERSONAL_PAYMENT: 'PERSONAL_PAYMENT',
    CARD_PAYMENT: 'CARD_PAYMENT'
  };

  /**
   * Detect current platform
   */
  const Platform = {
    isAndroid: function () {
      return (
        typeof window !== 'undefined' &&
        (Boolean(window.PaymentBridge) ||
          Boolean(window.SuperApp) ||
          Boolean(window.BMCManager) ||
          /android/i.test(navigator.userAgent))
      );
    },
    isIOS: function () {
      return (
        typeof window !== 'undefined' &&
        Boolean(window.webkit && window.webkit.messageHandlers)
      );
    }
  };

  /**
   * Helper to generate unique callback names
   */
  let callbackIdCounter = 0;
  function createUniqueCallbackName(prefix) {
    callbackIdCounter = (callbackIdCounter + 1) % 1000000;
    return `__miniAppCallback_${prefix || 'cb'}_${Date.now()}_${callbackIdCounter}`;
  }

  /**
   * MiniApp SDK Core Object
   */
  const MiniApp = {
    version: '1.1.0',
    ServiceType: SERVICE_TYPES,

    /**
     * Get platform information
     */
    getPlatform: function () {
      if (Platform.isIOS()) return 'ios';
      if (Platform.isAndroid()) return 'android';
      return 'web';
    },

    /**
     * Request SSO / User session token
     * @param {Object|string} [options] - Options object { appKey?: string } or appKey string
     * @returns {Promise<string>}
     */
    getToken: function (options) {
      const appKey = typeof options === 'string' ? options : (options && options.appKey) || null;
      return new Promise(function (resolve, reject) {
        try {
          // Android SuperApp interface
          if (window.SuperApp) {
            let resRaw;
            if (typeof window.SuperApp.getSessionTokenWithKey === 'function') {
              resRaw = window.SuperApp.getSessionTokenWithKey(appKey);
            } else if (typeof window.SuperApp.getSessionToken === 'function') {
              resRaw = window.SuperApp.getSessionToken();
            }

            if (resRaw) {
              try {
                const parsed = JSON.parse(resRaw);
                if (parsed.status === 'ERROR') {
                  return reject(parsed);
                }
                if (parsed.token !== undefined) {
                  return resolve(parsed.token);
                }
              } catch (e) {
                // Return plain string if not json
                return resolve(resRaw);
              }
            }
            return resolve(resRaw || '');
          }

          // iOS WKWebView MessageHandler
          if (
            window.webkit &&
            window.webkit.messageHandlers &&
            window.webkit.messageHandlers.SuperApp &&
            typeof window.webkit.messageHandlers.SuperApp.postMessage === 'function'
          ) {
            const callbackName = createUniqueCallbackName('getToken');
            window[callbackName] = function (res) {
              delete window[callbackName];
              if (res && res.status === 'ERROR') {
                reject(res);
              } else {
                resolve(typeof res === 'string' ? res : (res && res.token) || '');
              }
            };
            window.webkit.messageHandlers.SuperApp.postMessage({
              action: 'getToken',
              appKey: appKey,
              callback: callbackName
            });
            return;
          }

          // Fallback / Standalone Web
          resolve('');
        } catch (error) {
          reject(error);
        }
      });
    },

    /**
     * Request User Profile from Super App
     * @param {Object|string} [options] - Options object { appKey?: string } or appKey string
     * @returns {Promise<Object>} Resolves with { userId, name, phoneNumber, email, avatarUrl, ... }
     */
    getUserProfile: function (options) {
      const appKey = typeof options === 'string' ? options : (options && options.appKey) || null;
      return new Promise(function (resolve, reject) {
        try {
          // Android SuperApp interface
          if (window.SuperApp) {
            let profileRaw;
            if (typeof window.SuperApp.getUserProfileWithKey === 'function') {
              profileRaw = window.SuperApp.getUserProfileWithKey(appKey);
            } else if (typeof window.SuperApp.getUserProfile === 'function') {
              profileRaw = window.SuperApp.getUserProfile();
            }

            if (typeof profileRaw === 'string') {
              try {
                const parsed = JSON.parse(profileRaw);
                if (parsed.status === 'ERROR') {
                  return reject(parsed);
                }
                if (parsed.data) {
                  return resolve(parsed.data);
                }
                return resolve(parsed);
              } catch (e) {
                return resolve({ raw: profileRaw });
              }
            } else {
              return resolve(profileRaw || {});
            }
          }

          // iOS WKWebView MessageHandler
          if (
            window.webkit &&
            window.webkit.messageHandlers &&
            window.webkit.messageHandlers.SuperApp &&
            typeof window.webkit.messageHandlers.SuperApp.postMessage === 'function'
          ) {
            const callbackName = createUniqueCallbackName('getUserProfile');
            window[callbackName] = function (res) {
              delete window[callbackName];
              if (res && res.status === 'ERROR') {
                return reject(res);
              }
              if (typeof res === 'string') {
                try {
                  const parsed = JSON.parse(res);
                  if (parsed.data) return resolve(parsed.data);
                  return resolve(parsed);
                } catch (e) {
                  return resolve({ raw: res });
                }
              } else {
                return resolve((res && res.data) || res || {});
              }
            };
            window.webkit.messageHandlers.SuperApp.postMessage({
              action: 'getUserProfile',
              appKey: appKey,
              callback: callbackName
            });
            return;
          }

          // Fallback / Standalone Web mock
          resolve({
            userId: 'usr_guest',
            name: 'Guest User',
            phoneNumber: '',
            email: '',
            avatarUrl: '',
            token: ''
          });
        } catch (error) {
          reject(error);
        }
      });
    },

    /**
     * Request payment with native host container
     * @param {Object} payload
     * @param {string} payload.serviceType - MOBILE_TOPUP | BILL_PAYMENT | KHQR_PURCHASE | CARD_PAYMENT
     * @param {string} payload.prepayId - Unique transaction/order prepay identifier
     * @param {number} payload.amount - Payment amount (must be > 0)
     * @param {string} payload.currency - Currency code (e.g., 'USD', 'KHR')
     * @param {string} payload.partnerCode - Partner/merchant identifier
     * @param {string} payload.apiKey - API Key
     * @param {string} payload.secretKey - Secret
     * @param {string} payload.appId - App ID
     * @param {Object} [payload.metadata] - Extra custom parameters
     * @returns {Promise<Object>} Resolves with { status: "SUCCESS", transactionId: string, data: Object }
     */
    requestPayment: function (payload) {
      return new Promise(function (resolve, reject) {
        // Basic payload validations
        if (!payload || typeof payload !== 'object') {
          return reject({
            status: 'ERROR',
            errorCode: 'INVALID_PAYLOAD',
            errorMessage: 'Payment payload must be an object'
          });
        }

        if (!payload.serviceType || typeof payload.serviceType !== 'string') {
          return reject({
            status: 'ERROR',
            errorCode: 'INVALID_SERVICE_TYPE',
            errorMessage: `Invalid serviceType. Must be a string.`
          });
        }

        if (!payload.prepayId || typeof payload.prepayId !== 'string') {
          return reject({
            status: 'ERROR',
            errorCode: 'MISSING_PREPAY_ID',
            errorMessage: 'prepayId is required and must be a string'
          });
        }

        if (typeof payload.amount !== 'number' || payload.amount <= 0 || isNaN(payload.amount)) {
          return reject({
            status: 'ERROR',
            errorCode: 'INVALID_AMOUNT',
            errorMessage: 'amount must be a valid number greater than 0'
          });
        }

        if (!payload.currency) {
          return reject({
            status: 'ERROR',
            errorCode: 'MISSING_CURRENCY',
            errorMessage: 'currency is required (e.g. USD, KHR)'
          });
        }

        if (!payload.partnerCode) {
          return reject({
            status: 'ERROR',
            errorCode: 'MISSING_PARTNER_CODE',
            errorMessage: 'partnerCode is required'
          });
        }

        if (!payload.apiKey || !payload.secretKey || !payload.appId) {
          return reject({
            status: 'ERROR',
            errorCode: 'MISSING_CREDENTIALS',
            errorMessage: 'apiKey, secretKey, and appId are required'
          });
        }

        const normalizedPayload = {
          serviceType: payload.serviceType,
          prepayId: payload.prepayId,
          amount: payload.amount,
          currency: String(payload.currency).toUpperCase(),
          partnerCode: payload.partnerCode,
          metadata: payload.metadata || {},
          appId: payload.appId,
          apiKey: payload.apiKey || payload.appKey,
          secretKey: payload.secretKeyKey || payload.secretKey,
          merchantId: payload.merchantId,
          merchantName: payload.merchantName
        };

        const callbackName = createUniqueCallbackName('payment');

        // Setup the callback handler
        window[callbackName] = function (response) {
          // Clean up callback from window
          try {
            delete window[callbackName];
          } catch (e) {
            window[callbackName] = undefined;
          }

          if (typeof response === 'string') {
            try {
              response = JSON.parse(response);
            } catch (e) {
              // keep as string
            }
          }

          if (response && response.status === 'SUCCESS') {
            resolve(response);
          } else {
            reject(response || { status: 'FAILED', errorMessage: 'Payment failed' });
          }
        };

        const jsonString = JSON.stringify(normalizedPayload);

        // --- Android Call Execution ---
        if (window.PaymentBridge && typeof window.PaymentBridge.makePayment === 'function') {
          window.PaymentBridge.makePayment(jsonString, callbackName);
          return;
        }

        if (window.SuperApp && typeof window.SuperApp.requestPayment === 'function') {
          window.SuperApp.requestPayment(jsonString, callbackName);
          return;
        }

        if (window.SuperApp && typeof window.SuperApp.pay === 'function') {
          window.SuperApp.pay(jsonString, callbackName);
          return;
        }

        // --- iOS (WKWebView MessageHandler) Call Execution ---
        if (
          window.webkit &&
          window.webkit.messageHandlers &&
          (window.webkit.messageHandlers.PaymentBridge || window.webkit.messageHandlers.paymentBridge)
        ) {
          const handler =
            window.webkit.messageHandlers.PaymentBridge || window.webkit.messageHandlers.paymentBridge;
          handler.postMessage({
            payload: normalizedPayload,
            jsonPayload: jsonString,
            callback: callbackName
          });
          return;
        }

        // --- Legacy/Fallback BMCManager Interface ---
        if (window.BMCManager && typeof window.BMCManager.showPurchaseBottomSheet === 'function') {
          window.BMCManager.showPurchaseBottomSheet(
            JSON.stringify({
              sheetTitle: `Payment: ${normalizedPayload.serviceType}`,
              packName: normalizedPayload.partnerCode,
              packPrice: `${normalizedPayload.amount} ${normalizedPayload.currency}`,
              description: `Prepay ID: ${normalizedPayload.prepayId}`
            })
          );
          resolve({
            status: 'SUCCESS',
            transactionId: 'TXN_' + Date.now(),
            data: normalizedPayload
          });
          return;
        }

        // --- In case no native bridge is detected (development/mock mode) ---
        console.warn('[MiniApp JS SDK] Native payment bridge not found. Running in browser simulation mode.');
        setTimeout(function () {
          if (window[callbackName]) {
            window[callbackName]({
              status: 'SUCCESS',
              transactionId: 'MOCK_TXN_' + Date.now(),
              data: normalizedPayload
            });
          }
        }, 800);
      });
    },

    /**
     * Exit the MiniApp container with an optional native confirmation dialog
     * @param {boolean} [showConfirmationDialog=true] - If true, displays native confirmation dialog
     */
    exit: function (showConfirmationDialog) {
      const showConfirm = showConfirmationDialog !== false; // defaults to true
      
      // 1. Android SuperApp Interface
      if (window.SuperApp && typeof window.SuperApp.exitMiniApp === 'function') {
        window.SuperApp.exitMiniApp(showConfirm);
        return;
      }

      // 2. Android MiniAppBridge Interface
      if (window.MiniAppBridge && typeof window.MiniAppBridge.close === 'function') {
        window.MiniAppBridge.close(JSON.stringify({ showConfirm: showConfirm }));
        return;
      }

      // 3. iOS MessageHandler
      if (
        window.webkit &&
        window.webkit.messageHandlers &&
        window.webkit.messageHandlers.closeMiniApp
      ) {
        window.webkit.messageHandlers.closeMiniApp.postMessage({ showConfirmation: showConfirm });
        return;
      }

      // 4. Browser fallback
      if (showConfirm) {
        if (window.confirm("Are you sure you want to exit?")) {
          window.history.back();
        }
      } else {
        window.history.back();
      }
    },

    /**
     * Close current MiniApp (Alias to exit)
     * @param {Object|boolean} [options] - Options object or boolean for confirmation dialog
     */
    close: function (options) {
      if (typeof options === 'boolean') {
        this.exit(options);
      } else if (options && typeof options.showConfirm === 'boolean') {
        this.exit(options.showConfirm);
      } else {
        this.exit(false);
      }
    },

    /**
     * Share content (text, URL, title) using native Intent Chooser / Share Sheet
     * @param {Object|string} options - Share options { text: string, title?: string, subject?: string, url?: string } or plain text
     * @returns {Promise<Object>}
     */
    share: function (options) {
      const payload = typeof options === 'string' ? { text: options } : (options || {});
      const jsonString = JSON.stringify(payload);

      return new Promise(function (resolve, reject) {
        try {
          // 1. Android SuperApp Interface
          if (window.SuperApp && typeof window.SuperApp.share === 'function') {
            const res = window.SuperApp.share(jsonString);
            return resolve({ status: 'SUCCESS', result: res });
          }

          // 2. iOS WKWebView MessageHandler
          if (
            window.webkit &&
            window.webkit.messageHandlers &&
            window.webkit.messageHandlers.share
          ) {
            window.webkit.messageHandlers.share.postMessage(payload);
            return resolve({ status: 'SUCCESS' });
          }

          // 3. Web Share API fallback
          if (typeof navigator !== 'undefined' && navigator.share) {
            navigator.share({
              title: payload.title || '',
              text: payload.text || '',
              url: payload.url || ''
            }).then(function () {
              resolve({ status: 'SUCCESS' });
            }).catch(function (err) {
              reject({ status: 'ERROR', errorMessage: err && err.message });
            });
            return;
          }

          // 4. Fallback alert / clipboard simulation
          console.warn('[MiniApp JS SDK] Native share not available, fallback simulation.');
          resolve({ status: 'SUCCESS', simulation: true });
        } catch (error) {
          reject({ status: 'ERROR', errorMessage: error && error.message });
        }
      });
    },

    /**
     * Open external URL or deep link in the device default browser or external application
     * @param {string} url - The URL or deep link to open
     * @returns {Promise<Object>}
     */
    openExternal: function (url) {
      return new Promise(function (resolve, reject) {
        if (!url || typeof url !== 'string') {
          return reject({ status: 'ERROR', errorMessage: 'URL must be a non-empty string' });
        }

        try {
          // 1. Android SuperApp Interface
          if (window.SuperApp && typeof window.SuperApp.openExternal === 'function') {
            window.SuperApp.openExternal(url);
            return resolve({ status: 'SUCCESS' });
          }

          // 2. iOS WKWebView MessageHandler
          if (
            window.webkit &&
            window.webkit.messageHandlers &&
            window.webkit.messageHandlers.openExternal
          ) {
            window.webkit.messageHandlers.openExternal.postMessage({ url: url });
            return resolve({ status: 'SUCCESS' });
          }

          // 3. Standard Browser window.open fallback
          window.open(url, '_blank');
          resolve({ status: 'SUCCESS' });
        } catch (error) {
          reject({ status: 'ERROR', errorMessage: error && error.message });
        }
      });
    },

    /**
     * Alias for openExternal
     * @param {string} url
     */
    openBrowser: function (url) {
      return this.openExternal(url);
    },

    /**
     * Get consent status and terms for this mini app
     * @param {Object} [options] - { version?: number, userId?: string, appId?: string }
     * @returns {Promise<Object>} Resolves with { userId, appId, version, term, isAccepted, acceptedAt }
     */
    getConsent: function (options) {
      return new Promise(function (resolve, reject) {
        try {
          const optionsStr = options ? JSON.stringify(options) : '';

          // 1. Android SuperApp Interface
          if (window.SuperApp && typeof window.SuperApp.getConsent === 'function') {
            const raw = window.SuperApp.getConsent(optionsStr);
            try {
              const parsed = JSON.parse(raw);
              if (parsed.status === 'ERROR') {
                return reject(parsed);
              }
              return resolve(parsed.data || parsed);
            } catch (e) {
              return resolve(raw);
            }
          }

          // 2. iOS WKWebView MessageHandler
          if (
            window.webkit &&
            window.webkit.messageHandlers &&
            window.webkit.messageHandlers.getConsent
          ) {
            const callbackName = createUniqueCallbackName('getConsent');
            window[callbackName] = function (res) {
              delete window[callbackName];
              if (res && res.status === 'ERROR') {
                return reject(res);
              }
              return resolve((res && res.data) || res);
            };
            window.webkit.messageHandlers.getConsent.postMessage({
              options: options || {},
              callback: callbackName
            });
            return;
          }

          // 3. Fallback mock
          resolve({
            userId: (options && options.userId) || 'guest',
            appId: (options && options.appId) || 'mock_app',
            version: (options && options.version) || 1,
            term: 'Terms of service accepted.',
            isAccepted: true
          });
        } catch (error) {
          reject({ status: 'ERROR', errorMessage: error && error.message });
        }
      });
    },

    /**
     * Update user consent acceptance or rejection
     * @param {Object} payload - { appId?: string, version: number, userId?: string, isAccepted: boolean }
     * @returns {Promise<Object>}
     */
    updateConsent: function (payload) {
      return new Promise(function (resolve, reject) {
        if (!payload || typeof payload !== 'object') {
          payload = { isAccepted: true, version: 1 };
        }

        try {
          const payloadStr = JSON.stringify(payload);

          // 1. Android SuperApp Interface
          if (window.SuperApp && typeof window.SuperApp.updateConsent === 'function') {
            const raw = window.SuperApp.updateConsent(payloadStr);
            try {
              const parsed = JSON.parse(raw);
              if (parsed.status === 'ERROR') {
                return reject(parsed);
              }
              return resolve(parsed);
            } catch (e) {
              return resolve({ status: 'SUCCESS', raw: raw });
            }
          }

          // 2. iOS WKWebView MessageHandler
          if (
            window.webkit &&
            window.webkit.messageHandlers &&
            window.webkit.messageHandlers.updateConsent
          ) {
            const callbackName = createUniqueCallbackName('updateConsent');
            window[callbackName] = function (res) {
              delete window[callbackName];
              if (res && res.status === 'ERROR') {
                return reject(res);
              }
              return resolve(res || { status: 'SUCCESS' });
            };
            window.webkit.messageHandlers.updateConsent.postMessage({
              payload: payload,
              callback: callbackName
            });
            return;
          }

          // 3. Fallback mock
          resolve({
            status: 'SUCCESS',
            appId: payload.appId || 'mock_app',
            version: payload.version || 1,
            isAccepted: payload.isAccepted !== false,
            message: 'Consent saved locally'
          });
        } catch (error) {
          reject({ status: 'ERROR', errorMessage: error && error.message });
        }
      });
    }
  };

  return MiniApp;
});


