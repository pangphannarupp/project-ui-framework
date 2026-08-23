<script setup lang="ts">
import { ref } from 'vue'
import type { ApiAuthType, MiniAppApiEndpoint, FieldMappingItem } from '../../data/mockData'
import RichTextEditor from '../RichTextEditor.vue'

const props = defineProps<{
  show: boolean
  categories: string[]
  newApp: {
    name: string
    slug: string
    category: string
    description: string
    version: string
    icon: string
    banner: string
    tags: string[]
    order: number
    packageType: 'zip' | 'web_url' | 'native_aar' | 'api'
    packageUrl: string
    uploadedFileName: string
    uploadedFileSize: string
    androidPackageName: string
    androidActivityClass: string
    iosViewControllerClass: string
    apiBaseUrl: string
    apiTimeoutMs: number
    apiAuth: {
      authType: ApiAuthType
      apiKey?: string
      apiSecret?: string
      headerName?: string
      bearerToken?: string
      username?: string
      password?: string
      tokenUrl?: string
      clientId?: string
      clientSecret?: string
      scope?: string
      signatureSecret?: string
      privateKeyPem?: string
    }
    apiEndpoints: MiniAppApiEndpoint[]
  }
}>()

const emit = defineEmits<{
  (e: 'close'): void
  (e: 'submit'): void
  (e: 'iconSelect', event: Event): void
  (e: 'bannerSelect', event: Event): void
  (e: 'packageFileSelect', event: Event): void
  (e: 'addApiEndpoint'): void
  (e: 'removeApiEndpoint', index: number): void
  (e: 'addFieldMapping', endpointIndex: number): void
  (e: 'removeFieldMapping', endpointIndex: number, mappingIndex: number): void
  (e: 'toggleTransform', endpointIndex: number, mappingIndex: number): void
}>()

const activeTabMap = ref<Record<string, 'config' | 'curl' | 'preview'>>({})
const copiedIndex = ref<number | null>(null)

const getActiveTab = (epId: string) => {
  return activeTabMap.value[epId] || 'config'
}

const setActiveTab = (epId: string, tab: 'config' | 'curl' | 'preview') => {
  activeTabMap.value[epId] = tab
}

const generateCurl = (ep: MiniAppApiEndpoint) => {
  let fullPath = ep.path.startsWith('/') ? ep.path : `/${ep.path}`
  if (ep.queryParams) {
    const cleanParams = ep.queryParams.replace(/^\?/, '')
    fullPath += (fullPath.includes('?') ? '&' : '?') + cleanParams
  }
  const url = `${props.newApp.apiBaseUrl.replace(/\/$/, '')}${fullPath}`
  let lines: string[] = []
  lines.push(`curl -X ${ep.httpMethod} "${url}" \\`)

  // Auth header
  const auth = props.newApp.apiAuth
  if (auth.authType === 'apiKey') {
    lines.push(`  -H "${auth.headerName || 'X-API-Key'}: ${auth.apiKey || 'YOUR_API_KEY'}" \\`)
  } else if (auth.authType === 'bearer') {
    lines.push(`  -H "Authorization: Bearer ${auth.bearerToken || 'eyJhbGciOi...'}" \\`)
  } else if (auth.authType === 'basic') {
    const creds = `${auth.username || 'admin'}:${auth.password || 'password'}`
    lines.push(`  -u "${creds}" \\`)
  } else if (auth.authType.startsWith('oauth2')) {
    lines.push(`  -H "Authorization: Bearer \${ACCESS_TOKEN}" \\`)
  } else if (auth.authType === 'hmac_sha256') {
    lines.push(`  -H "X-Partner-ID: ${auth.apiKey || 'partner_123'}" \\`)
    lines.push(`  -H "X-Signature: \${HMAC_SHA256_HEX}" \\`)
    lines.push(`  -H "X-Timestamp: $(date +%s)" \\`)
  }

  // Content-Type header
  const cType = ep.contentType || 'application/json'
  lines.push(`  -H "Content-Type: ${cType}" \\`)

  // Custom request headers
  if (ep.requestHeaders) {
    try {
      const parsed = JSON.parse(ep.requestHeaders)
      Object.entries(parsed).forEach(([k, v]) => {
        if (k.toLowerCase() !== 'content-type') {
          lines.push(`  -H "${k}: ${v}" \\`)
        }
      })
    } catch {
      // ignore
    }
  }

  // Payload for POST / PUT / PATCH / DELETE
  if (['POST', 'PUT', 'PATCH', 'DELETE'].includes(ep.httpMethod) && ep.requestPayloadSchema) {
    const cleanPayload = ep.requestPayloadSchema.replace(/\n/g, ' ').replace(/"/g, '\\"')
    lines.push(`  -d "${cleanPayload}"`)
  } else {
    // Trim trailing slash on last line
    if (lines.length > 0) {
      lines[lines.length - 1] = lines[lines.length - 1].replace(/\s+\\$/, '')
    }
  }

  return lines.join('\n')
}

const copyCurl = (ep: MiniAppApiEndpoint, idx: number) => {
  const curl = generateCurl(ep)
  navigator.clipboard.writeText(curl)
  copiedIndex.value = idx
  setTimeout(() => {
    copiedIndex.value = null
  }, 2000)
}

const getSimulatedResponse = (ep: MiniAppApiEndpoint) => {
  const result: Record<string, any> = {}
  ep.fieldMappings.forEach(rule => {
    if (!rule.targetField) return

    if (rule.transform && rule.transform.type === 'addSuffix') {
      result[rule.targetField] = `3.5 USD (${rule.transform.param || ''})`
    } else if (rule.defaultValue) {
      result[rule.targetField] = rule.defaultValue
    } else if (rule.targetField === 'id') {
      result[rule.targetField] = 'cof_01'
    } else if (rule.targetField === 'name') {
      result[rule.targetField] = 'Iced Salted Cream Caramel Latte'
    } else if (rule.targetField === 'imageUrl') {
      result[rule.targetField] = 'https://picsum.photos/400/300?random=301'
    } else {
      result[rule.targetField] = `Extracted from [${rule.sourceJsonPath || '$.data'}]`
    }
  })
  return JSON.stringify({
    success: true,
    portal_mapped_data: [result]
  }, null, 2)
}
</script>

<template>
  <div v-if="show" class="modal-backdrop">
    <div class="modal-card glass-panel">
      <div class="modal-header">
        <div>
          <h3>Register New Mini Application</h3>
          <p class="modal-subtitle">Configure metadata, visual image assets, and deployment bundles</p>
        </div>
        <button @click="emit('close')" class="close-btn">✕</button>
      </div>
      <form @submit.prevent="emit('submit')" class="modal-form">
        <div class="form-group">
          <label>App Name <span class="required">*</span></label>
          <PPInput v-model="newApp.name" placeholder="e.g. Smart Parking" required />
        </div>
        
        <div class="form-row">
          <div class="form-group flex-1">
            <label>URL Slug / Path <span class="required">*</span></label>
            <PPInput v-model="newApp.slug" placeholder="e.g. mini-smart-parking" required />
          </div>
          <div class="form-group flex-1">
            <label>Category <span class="required">*</span></label>
            <PPSelect
              v-model="newApp.category"
              :options="categories.filter(c => c !== 'All').map(c => ({ label: c, value: c }))"
            />
          </div>
        </div>

        <!-- Tags Input -->
        <div class="form-group">
          <label>Search & Discoverability Tags</label>
          <PPTagInput
            v-model="newApp.tags"
            placeholder="Type tag (e.g. Coffee, Fast Delivery, KHQR) and press Enter..."
          />
        </div>

        <!-- Image Attachments Section -->
        <div class="media-attachments-section">
          <div class="media-title">
            <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="#60a5fa" stroke-width="2" style="display:inline; vertical-align:text-bottom; margin-right:6px;"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg>
            <span>Visual Brand Assets (Image Attachments)</span>
          </div>
          
          <div class="form-row">
            <!-- App Icon Upload -->
            <div class="form-group flex-1">
              <label>App Icon Image (1:1 Ratio)</label>
              <label class="image-upload-box">
                <input type="file" accept="image/*" @change="e => emit('iconSelect', e)" class="hidden-file-input" />
                <div v-if="newApp.icon" class="image-preview-wrapper icon-preview">
                  <img :src="newApp.icon" alt="Icon Preview" />
                  <span class="change-overlay">Change Icon</span>
                </div>
                <div v-else class="image-placeholder">
                  <svg class="upload-icon-svg" viewBox="0 0 24 24" width="24" height="24" fill="none" stroke="currentColor" stroke-width="2"><path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"></path><circle cx="12" cy="13" r="4"></circle></svg>
                  <strong>Upload Icon</strong>
                  <small>PNG, JPG, SVG, WebP (Square)</small>
                </div>
              </label>
            </div>

            <!-- App Banner Upload -->
            <div class="form-group flex-2">
              <label>Marketing Header Banner (16:6 Ratio)</label>
              <label class="image-upload-box">
                <input type="file" accept="image/*" @change="e => emit('bannerSelect', e)" class="hidden-file-input" />
                <div v-if="newApp.banner" class="image-preview-wrapper banner-preview">
                  <img :src="newApp.banner" alt="Banner Preview" />
                  <span class="change-overlay">Change Banner</span>
                </div>
                <div v-else class="image-placeholder">
                  <svg class="upload-icon-svg" viewBox="0 0 24 24" width="24" height="24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg>
                  <strong>Upload Banner Header</strong>
                  <small>Recommended: 800x300 or wide landscape</small>
                </div>
              </label>
            </div>
          </div>
        </div>

        <!-- Package Type Selector -->
        <div class="form-group">
          <label>Deployment Content Type</label>
          <div class="package-type-selector">
            <label class="type-option" :class="{ 'selected': newApp.packageType === 'zip' }">
              <input type="radio" value="zip" v-model="newApp.packageType" />
              <div class="option-content">
                <strong>Content Zip</strong>
                <small>Static web bundle (.zip)</small>
              </div>
            </label>
            <label class="type-option" :class="{ 'selected': newApp.packageType === 'web_url' }">
              <input type="radio" value="web_url" v-model="newApp.packageType" />
              <div class="option-content">
                <strong>Web URL</strong>
                <small>Hosted remote endpoint</small>
              </div>
            </label>
            <label class="type-option" :class="{ 'selected': newApp.packageType === 'native_aar' }">
              <input type="radio" value="native_aar" v-model="newApp.packageType" />
              <div class="option-content">
                <strong>Native AAR</strong>
                <small>Embedded Native SDK</small>
              </div>
            </label>
            <label class="type-option" :class="{ 'selected': newApp.packageType === 'api' }">
              <input type="radio" value="api" v-model="newApp.packageType" />
              <div class="option-content">
                <strong>Partner API</strong>
                <small>REST API & Response Mapping</small>
              </div>
            </label>
          </div>
        </div>

        <!-- Dynamic Input based on Package Type -->
        <!-- 1. Content Zip -->
        <div v-if="newApp.packageType === 'zip'" class="upload-box">
          <label class="upload-dropzone">
            <input type="file" accept=".zip" @change="e => emit('packageFileSelect', e)" class="hidden-file-input" />
            <div class="dropzone-content">
              <svg class="upload-icon-svg" viewBox="0 0 24 24" width="28" height="28" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="17 8 12 3 7 8"></polyline><line x1="12" y1="3" x2="12" y2="15"></line></svg>
              <strong v-if="newApp.uploadedFileName">{{ newApp.uploadedFileName }} ({{ newApp.uploadedFileSize }})</strong>
              <strong v-else>Click or drag & drop Content ZIP file</strong>
              <small>Max upload size: 50MB (Extracts HTML, CSS, JS)</small>
            </div>
          </label>
        </div>

        <!-- 2. Web URL -->
        <div v-else-if="newApp.packageType === 'web_url'" class="form-group">
          <label>Remote Web Application URL</label>
          <PPInput v-model="newApp.packageUrl" placeholder="https://cdn.yourdomain.com/app/index.html" required />
        </div>

        <!-- 3. Native AAR: No file attachment, No Android activity class -->
        <div v-else-if="newApp.packageType === 'native_aar'" class="native-config-section">
          <div class="native-inputs-card">
            <div class="native-title">
              <span>Android Configuration</span>
            </div>
            <div class="form-group">
              <label>Android Package Identifier</label>
              <PPInput v-model="newApp.androidPackageName" placeholder="com.mcnc.miniapp.evcharge" required />
              <small class="field-hint">Native SDK will dynamically resolve and mount the bundle without extra activity registration.</small>
            </div>

            <div class="native-title" style="margin-top: 14px;">
              <span>iOS Configuration</span>
            </div>
            <div class="form-group">
              <label>Entry UIViewController Class / Storyboard ID</label>
              <PPInput v-model="newApp.iosViewControllerClass" placeholder="EVChargeMainViewController" />
            </div>
          </div>
        </div>

        <!-- 4. Partner API: Global Base URL, Auth Types, Multiple Endpoints, and Visual Response Mapping Table -->
        <div v-else-if="newApp.packageType === 'api'" class="api-config-section">
          <!-- A. Gateway Base URL & Global Settings -->
          <div class="api-inputs-card">
            <div class="api-title">
              <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="#60a5fa" stroke-width="2">
                <circle cx="12" cy="12" r="10"></circle>
                <line x1="2" y1="12" x2="22" y2="12"></line>
                <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1 4-10z"></path>
              </svg>
              <span>Partner API Gateway & Base Host</span>
            </div>

            <div class="form-row">
              <div class="form-group flex-2">
                <label>Base URL Endpoint <span class="required">*</span></label>
                <PPInput v-model="newApp.apiBaseUrl" placeholder="https://api.partner.com/v1" required />
              </div>
              <div class="form-group flex-1">
                <label>HTTP Timeout (ms)</label>
                <PPInput type="number" v-model="newApp.apiTimeoutMs" placeholder="5000" />
              </div>
            </div>

            <!-- B. Comprehensive API Authentication Mechanisms -->
            <div class="api-title" style="margin-top: 10px;">
              <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="#f59e0b" stroke-width="2">
                <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
              </svg>
              <span>API Authentication & Token Protocol</span>
            </div>

            <div class="form-row">
              <div class="form-group flex-1">
                <label>Authentication Protocol</label>
                <PPSelect
                  v-model="newApp.apiAuth.authType"
                  :options="[
                    { label: 'None (Public Open API)', value: 'none' },
                    { label: 'API Key (Custom Header / Param)', value: 'apiKey' },
                    { label: 'Bearer Token (JWT)', value: 'bearer' },
                    { label: 'HTTP Basic Auth (Username / Password)', value: 'basic' },
                    { label: 'OAuth 2.0 (Client Credentials)', value: 'oauth2_client_credentials' },
                    { label: 'OAuth 2.0 (Authorization Code + PKCE)', value: 'oauth2_auth_code' },
                    { label: 'HMAC-SHA256 Request Signature', value: 'hmac_sha256' },
                    { label: 'Mutual TLS (mTLS) Client Certificate', value: 'mtls' },
                    { label: 'AWS Signature Version 4 (SigV4)', value: 'aws_sigv4' },
                    { label: 'Signed JWT Assertion (RS256)', value: 'jwt_signed' }
                  ]"
                />
              </div>
            </div>

            <!-- Dynamic auth credentials row -->
            <div v-if="newApp.apiAuth.authType !== 'none'" class="form-row" style="margin-top: 4px;">
              <template v-if="newApp.apiAuth.authType === 'apiKey'">
                <div class="form-group flex-1">
                  <label>Header / Parameter Name</label>
                  <PPInput v-model="newApp.apiAuth.headerName" placeholder="X-API-Key" />
                </div>
                <div class="form-group flex-1">
                  <label>API Key Secret</label>
                  <PPInput v-model="newApp.apiAuth.apiKey" type="password" placeholder="sk_live_..." />
                </div>
              </template>

              <template v-else-if="newApp.apiAuth.authType === 'bearer'">
                <div class="form-group flex-1">
                  <label>Static Bearer JWT Token</label>
                  <PPInput v-model="newApp.apiAuth.bearerToken" type="password" placeholder="eyJhbGciOi..." />
                </div>
              </template>

              <template v-else-if="newApp.apiAuth.authType === 'basic'">
                <div class="form-group flex-1">
                  <label>Username</label>
                  <PPInput v-model="newApp.apiAuth.username" placeholder="api_user" />
                </div>
                <div class="form-group flex-1">
                  <label>Password</label>
                  <PPInput v-model="newApp.apiAuth.password" type="password" placeholder="••••••••" />
                </div>
              </template>

              <template v-else-if="newApp.apiAuth.authType.startsWith('oauth2')">
                <div class="form-group flex-1">
                  <label>OAuth Token URL</label>
                  <PPInput v-model="newApp.apiAuth.tokenUrl" placeholder="https://auth.partner.com/oauth/token" />
                </div>
                <div class="form-group flex-1">
                  <label>Client ID</label>
                  <PPInput v-model="newApp.apiAuth.clientId" placeholder="client_id_..." />
                </div>
                <div class="form-group flex-1">
                  <label>Client Secret</label>
                  <PPInput v-model="newApp.apiAuth.clientSecret" type="password" placeholder="client_secret_..." />
                </div>
              </template>

              <template v-else-if="newApp.apiAuth.authType === 'hmac_sha256'">
                <div class="form-group flex-1">
                  <label>API Key / Client ID</label>
                  <PPInput v-model="newApp.apiAuth.apiKey" placeholder="partner_id_..." />
                </div>
                <div class="form-group flex-1">
                  <label>HMAC Secret Key (Hex/Base64)</label>
                  <PPInput v-model="newApp.apiAuth.signatureSecret" type="password" placeholder="hmac_secret_..." />
                </div>
              </template>

              <template v-else-if="newApp.apiAuth.authType === 'mtls' || newApp.apiAuth.authType === 'jwt_signed'">
                <div class="form-group flex-1">
                  <label>{{ newApp.apiAuth.authType === 'mtls' ? 'Client Cert / Private Key (.pem)' : 'Private Key for JWT signing (.pem)' }}</label>
                  <textarea
                    v-model="newApp.apiAuth.privateKeyPem"
                    class="code-editor-textarea"
                    rows="2"
                    placeholder="-----BEGIN RSA PRIVATE KEY-----..."
                  ></textarea>
                </div>
              </template>
            </div>
          </div>

          <!-- C. Multiple Endpoints List -->
          <div class="endpoints-header-row">
            <div class="endpoints-title">
              <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="#60a5fa" stroke-width="2">
                <polyline points="16 18 22 12 16 6"></polyline>
                <polyline points="8 6 2 12 8 18"></polyline>
              </svg>
              <strong>API Operations & Endpoints ({{ newApp.apiEndpoints.length }})</strong>
            </div>
            <PPButton type="button" size="small" variant="outline" @click="emit('addApiEndpoint')">
              <span>+ Add Endpoint</span>
            </PPButton>
          </div>

          <div class="endpoints-container">
            <div v-for="(ep, epIdx) in newApp.apiEndpoints" :key="ep.id" class="endpoint-card">
              <div class="endpoint-card-header">
                <div class="endpoint-main-meta">
                  <span class="http-badge" :class="ep.httpMethod.toLowerCase()">{{ ep.httpMethod }}</span>
                  <strong>{{ ep.name }}</strong>
                  <code class="endpoint-path-code">{{ ep.path }}</code>
                </div>

                <div class="endpoint-header-right">
                  <!-- View Switcher Tabs -->
                  <div class="ep-tab-pills">
                    <button
                      type="button"
                      class="ep-tab-pill"
                      :class="{ active: getActiveTab(ep.id) === 'config' }"
                      @click="setActiveTab(ep.id, 'config')"
                    >
                      ⚙ Config
                    </button>
                    <button
                      type="button"
                      class="ep-tab-pill curl"
                      :class="{ active: getActiveTab(ep.id) === 'curl' }"
                      @click="setActiveTab(ep.id, 'curl')"
                    >
                      <svg viewBox="0 0 24 24" width="12" height="12" fill="none" stroke="currentColor" stroke-width="2"><polyline points="4 17 10 11 4 5"></polyline><line x1="12" y1="19" x2="20" y2="19"></line></svg>
                      Preview cURL
                    </button>
                    <button
                      type="button"
                      class="ep-tab-pill preview"
                      :class="{ active: getActiveTab(ep.id) === 'preview' }"
                      @click="setActiveTab(ep.id, 'preview')"
                    >
                      ✨ Mapped JSON
                    </button>
                  </div>

                  <button
                    type="button"
                    class="remove-endpoint-btn"
                    v-if="newApp.apiEndpoints.length > 1"
                    @click="emit('removeApiEndpoint', epIdx)"
                    title="Remove this endpoint"
                  >
                    ✕
                  </button>
                </div>
              </div>

              <!-- TAB 1: Main Endpoint & Response Mapping Configuration -->
              <div v-if="getActiveTab(ep.id) === 'config'" class="endpoint-body">
                <!-- UI Template Selection -->
                <div class="form-row">
                  <div class="form-group flex-1">
                    <label>UI Template <span class="required">*</span></label>
                    <PPSelect
                      v-model="ep.uiTemplate"
                      :options="[
                        { label: 'Template 1 (Product Catalog & Cards)', value: 'Template 1 (Product Catalog & Cards)' },
                        { label: 'Template 2 (Order Detail & Checkout)', value: 'Template 2 (Order Detail & Checkout)' },
                        { label: 'Template 3 (User Account & Profile)', value: 'Template 3 (User Account & Profile)' },
                        { label: 'Template 4 (Dynamic Table & List)', value: 'Template 4 (Dynamic Table & List)' }
                      ]"
                    />
                  </div>
                </div>

                <!-- Endpoint Header & Source URL + HTTP Method + Content-Type -->
                <div class="endpoint-inner-header">
                  <div class="endpoint-heading-title">
                    <strong>{{ ep.path || '/product' }}</strong>
                    <span class="required-tag">Required</span>
                  </div>
                  <div class="form-row" style="margin-top: 10px; align-items: flex-end;">
                    <div class="form-group" style="width: 110px;">
                      <label>Method</label>
                      <PPSelect
                        v-model="ep.httpMethod"
                        :options="[
                          { label: 'GET', value: 'GET' },
                          { label: 'POST', value: 'POST' },
                          { label: 'PUT', value: 'PUT' },
                          { label: 'PATCH', value: 'PATCH' },
                          { label: 'DELETE', value: 'DELETE' }
                        ]"
                      />
                    </div>
                    <div class="form-group flex-2">
                      <label>Source URL <span class="required">*</span></label>
                      <PPInput v-model="ep.path" placeholder="/product" required />
                    </div>
                    <div class="form-group flex-1">
                      <label>Content-Type (MIME)</label>
                      <PPSelect
                        v-model="ep.contentType"
                        :options="[
                          { label: 'application/json', value: 'application/json' },
                          { label: 'application/x-www-form-urlencoded', value: 'application/x-www-form-urlencoded' },
                          { label: 'multipart/form-data', value: 'multipart/form-data' },
                          { label: 'text/plain', value: 'text/plain' },
                          { label: 'application/xml', value: 'application/xml' }
                        ]"
                      />
                    </div>
                  </div>

                  <!-- Request Query Parameters (Optional) -->
                  <div class="form-group" style="margin-top: 10px;">
                    <label>Query Parameters (e.g. <code>category=coffee&limit=10</code>)</label>
                    <PPInput v-model="ep.queryParams" placeholder="page=1&limit=20&filter=active" />
                  </div>

                  <!-- Request Body / Payload Configuration -->
                  <div class="form-group" style="margin-top: 10px;" v-if="['POST', 'PUT', 'PATCH', 'DELETE'].includes(ep.httpMethod)">
                    <label>Request Body / Payload Template</label>
                    <textarea
                      v-model="ep.requestPayloadSchema"
                      class="target-format-code font-mono"
                      rows="4"
                      placeholder='{
  "userId": "{{user.id}}",
  "items": "{{cart.items}}",
  "currency": "USD"
}'
                    ></textarea>
                  </div>
                </div>

                <!-- Target format (reference) -->
                <div class="form-group" style="margin-top: 14px;">
                  <label>Target format (reference)</label>
                  <div class="target-format-wrapper">
                    <textarea
                      v-model="ep.targetFormatJson"
                      class="target-format-code font-mono"
                      rows="10"
                      spellcheck="false"
                    ></textarea>
                  </div>
                </div>

                <!-- Match format Toggle -->
                <div class="toggle-format-row">
                  <PPSwitch v-model="ep.partnerMatchesFormat" />
                  <span>Partner response already matches this format</span>
                </div>

                <!-- Field Mapping List (Matching user reference layout) -->
                <div v-if="!ep.partnerMatchesFormat" class="field-mapping-container">
                  <div class="field-mapping-title">
                    <span>Field mapping</span>
                  </div>

                  <div class="mapping-rows-list">
                    <div v-for="(rule, mIdx) in ep.fieldMappings" :key="mIdx" class="mapping-field-item">
                      <div class="mapping-row-main">
                        <div class="target-field-col">
                          <!-- If target field has a preset name, show label; if empty or custom, allow typing -->
                          <input
                            v-if="!rule.targetField || mIdx >= 8"
                            v-model="rule.targetField"
                            placeholder="Target key..."
                            class="custom-target-input"
                          />
                          <strong v-else>{{ rule.targetField }}</strong>
                        </div>

                        <div class="source-jsonpath-col">
                          <PPInput
                            v-model="rule.sourceJsonPath"
                            :placeholder="`Source, e.g. $[*].${rule.targetField || 'field'}`"
                          />
                        </div>

                        <div class="default-value-col">
                          <PPInput
                            v-model="rule.defaultValue"
                            placeholder="Default (optional)"
                          />
                        </div>

                        <div class="transform-action-col">
                          <button
                            type="button"
                            class="transform-toggle-btn"
                            :class="{ active: rule.showTransform }"
                            @click="emit('toggleTransform', epIdx, mIdx)"
                          >
                            {{ rule.showTransform ? '- Transform' : '+ Transform' }}
                          </button>
                        </div>

                        <button
                          v-if="mIdx >= 8"
                          type="button"
                          class="remove-custom-field-btn"
                          @click="emit('removeFieldMapping', epIdx, mIdx)"
                          title="Delete field"
                        >
                          ✕
                        </button>
                      </div>

                      <!-- Expandable Transform configuration row (e.g. addSuffix $.items[0].currency) -->
                      <div v-if="rule.showTransform" class="transform-sub-row">
                        <div class="transform-type-select">
                          <select v-if="rule.transform" v-model="rule.transform.type" class="transform-select">
                            <optgroup label="🔤 String & Text">
                              <option value="addSuffix">addSuffix (Append text or source)</option>
                              <option value="addPrefix">addPrefix (Prepend text or source)</option>
                              <option value="replace">replace (Regex/String replacement)</option>
                              <option value="trim">trim (Remove whitespace)</option>
                              <option value="toUpperCase">toUpperCase (ALL CAPS)</option>
                              <option value="toLowerCase">toLowerCase (all lower)</option>
                              <option value="capitalize">capitalize (Title Case)</option>
                              <option value="maskSensitive">maskSensitive (e.g. ****1234)</option>
                            </optgroup>

                            <optgroup label="🔢 Number & Math">
                              <option value="currencyFormat">currencyFormat (e.g. $1,234.50)</option>
                              <option value="numberFormat">numberFormat (e.g. 1,000.00)</option>
                              <option value="round">round (Precision / Decimals)</option>
                              <option value="mathMultiply">mathMultiply (Scale e.g. 0.01 for cents)</option>
                              <option value="mathDivide">mathDivide (Divide factor)</option>
                            </optgroup>

                            <optgroup label="📅 Date & Time">
                              <option value="dateFormat">dateFormat (e.g. YYYY-MM-DD HH:mm)</option>
                              <option value="timestampToDate">timestampToDate (Unix ms to ISO)</option>
                              <option value="relativeTime">relativeTime (e.g. "3 mins ago")</option>
                            </optgroup>

                            <optgroup label="⚖ Boolean & Logic">
                              <option value="toBoolean">toBoolean (Cast truthy / falsy)</option>
                              <option value="booleanInvert">booleanInvert (NOT !value)</option>
                              <option value="coalesce">coalesce (First non-null fallback)</option>
                              <option value="valueLookup">valueLookup (Key-Value Dict mapping)</option>
                            </optgroup>

                            <optgroup label="📋 Array & Collection">
                              <option value="join">join (Join array by delimiter)</option>
                              <option value="split">split (Split string to array)</option>
                              <option value="arrayMap">arrayMap (Map item properties)</option>
                              <option value="arrayFilter">arrayFilter (Filter by condition)</option>
                              <option value="arraySlice">arraySlice (Limit / slice array)</option>
                              <option value="arraySum">arraySum (Sum numeric property)</option>
                              <option value="arrayCount">arrayCount (Count items length)</option>
                            </optgroup>

                            <optgroup label="✨ Expression & Script">
                              <option value="template">templateExpression (e.g. ${code} - ${name})</option>
                              <option value="customScript">customScript (JavaScript inline fn)</option>
                            </optgroup>
                          </select>
                        </div>

                        <div class="transform-param-input">
                          <PPInput
                            v-if="rule.transform"
                            v-model="rule.transform.param"
                            :placeholder="
                              rule.transform.type === 'addSuffix' ? 'e.g. $.items[0].currency or \' USD\'' :
                              rule.transform.type === 'addPrefix' ? 'e.g. \'SKU-\' or \'https://\'' :
                              rule.transform.type === 'replace' ? 'e.g. /old/g -> new' :
                              rule.transform.type === 'currencyFormat' ? 'e.g. USD or EUR' :
                              rule.transform.type === 'mathMultiply' ? 'e.g. 0.01 (cents to dollars)' :
                              rule.transform.type === 'dateFormat' ? 'e.g. YYYY-MM-DD HH:mm:ss' :
                              rule.transform.type === 'valueLookup' ? 'e.g. 1:Active, 0:Disabled, 2:Pending' :
                              rule.transform.type === 'join' ? 'e.g. \', \' or \' | \'' :
                              rule.transform.type === 'template' ? 'e.g. ${brand} - ${title} (${id})' :
                              rule.transform.type === 'customScript' ? 'e.g. (val) => val ? val.trim() : null' :
                              'Parameter (optional)'
                            "
                          />
                        </div>

                        <button
                          type="button"
                          class="remove-transform-btn"
                          @click="emit('toggleTransform', epIdx, mIdx)"
                        >
                          Remove
                        </button>
                      </div>
                    </div>
                  </div>

                  <div class="add-field-row" style="margin-top: 14px;">
                    <button type="button" class="add-custom-field-btn" @click="emit('addFieldMapping', epIdx)">
                      + Add Custom Target Field
                    </button>
                  </div>
                </div>
              </div>

              <!-- TAB 2: cURL Command Live Preview -->
              <div v-else-if="getActiveTab(ep.id) === 'curl'" class="curl-tab-body">
                <div class="code-preview-header">
                  <div class="code-preview-title">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="#60a5fa" stroke-width="2"><polyline points="4 17 10 11 4 5"></polyline><line x1="12" y1="19" x2="20" y2="19"></line></svg>
                    <span>Auto-Generated cURL Command</span>
                  </div>
                  <button type="button" class="copy-btn" @click="copyCurl(ep, epIdx)">
                    {{ copiedIndex === epIdx ? '✓ Copied!' : 'Copy cURL' }}
                  </button>
                </div>
                <pre class="curl-code-block font-mono"><code>{{ generateCurl(ep) }}</code></pre>
                <small class="field-hint">You can paste this cURL command directly into Terminal, Postman, or Insomnia to verify partner API responses.</small>
              </div>

              <!-- TAB 3: Simulated JSON Response Output Preview -->
              <div v-else class="preview-tab-body">
                <div class="code-preview-header">
                  <div class="code-preview-title">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="#10b981" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline></svg>
                    <span>Simulated Portal Mapped Response Preview</span>
                  </div>
                  <span class="preview-badge-status">Status: 200 OK</span>
                </div>
                <pre class="curl-code-block font-mono json-preview"><code>{{ getSimulatedResponse(ep) }}</code></pre>
              </div>
            </div>
          </div>
        </div>

        <div class="form-group" style="margin-top: 12px;">
          <label>App Description & Documentation</label>
          <RichTextEditor
            v-model="newApp.description"
            placeholder="Write styled description with bold, lists, headings or links..."
            min-height="110px"
          />
        </div>

        <div class="modal-footer">
          <PPButton type="button" variant="outline" size="small" @click="emit('close')">
            <span>Cancel</span>
          </PPButton>
          <PPButton type="submit" variant="primary" size="small">
            <span>Deploy & Register App</span>
          </PPButton>
        </div>
      </form>
    </div>
  </div>
</template>

<style scoped>
.modal-backdrop {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background: rgba(0, 0, 0, 0.7);
  backdrop-filter: blur(8px);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 100;
  padding: 20px;
}

.modal-card {
  width: 100%;
  max-width: 860px;
  max-height: 92vh;
  overflow-y: auto;
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 18px;
  padding: 28px 32px;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 20px;
  border-bottom: 1px solid #1f2937;
  padding-bottom: 16px;
}

.modal-header h3 {
  font-size: 18px;
  font-weight: 700;
  color: #fff;
}

.modal-subtitle {
  font-size: 13px;
  color: #94a3b8;
  margin-top: 2px;
}

.close-btn {
  background: transparent;
  border: none;
  color: #94a3b8;
  font-size: 18px;
  cursor: pointer;
}

.modal-form {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.form-group label {
  font-size: 13px;
  font-weight: 600;
  color: #cbd5e1;
}

.required {
  color: #ef4444;
}

.form-row {
  display: flex;
  gap: 16px;
}

.flex-1 { flex: 1; }
.flex-2 { flex: 2; }

.media-attachments-section {
  background: #0d1321;
  border: 1px solid #1f2937;
  border-radius: 12px;
  padding: 16px;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.media-title {
  font-size: 13px;
  font-weight: 600;
  color: #93c5fd;
}

.image-upload-box {
  display: block;
  cursor: pointer;
}

.hidden-file-input {
  display: none;
}

.image-placeholder {
  border: 2px dashed #374151;
  border-radius: 12px;
  padding: 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  background: #0f172a;
  transition: all 0.2s;
}

.image-placeholder:hover {
  border-color: #3b82f6;
  background: #1e293b;
}

.upload-icon-svg {
  color: #60a5fa;
  margin-bottom: 6px;
}

.image-placeholder strong {
  font-size: 12px;
  color: #f8fafc;
}

.image-placeholder small {
  font-size: 10px;
  color: #64748b;
  margin-top: 2px;
}

.image-preview-wrapper {
  position: relative;
  border-radius: 12px;
  overflow: hidden;
  border: 1px solid #374151;
}

.icon-preview {
  width: 90px;
  height: 90px;
}

.banner-preview {
  width: 100%;
  height: 90px;
}

.image-preview-wrapper img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.change-overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: rgba(0, 0, 0, 0.7);
  color: #fff;
  font-size: 10px;
  text-align: center;
  padding: 4px;
}

.package-type-selector {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10px;
}

.type-option {
  position: relative;
  display: flex;
  cursor: pointer;
  background: #0f172a;
  border: 1px solid #1f2937;
  border-radius: 10px;
  padding: 10px 12px;
  transition: all 0.2s;
}

.type-option input {
  position: absolute;
  opacity: 0;
}

.type-option.selected {
  border-color: #3b82f6;
  background: rgba(59, 130, 246, 0.1);
}

.option-content strong {
  display: block;
  font-size: 13px;
  color: #fff;
}

.option-content small {
  font-size: 11px;
  color: #94a3b8;
}

.upload-dropzone {
  display: block;
  cursor: pointer;
}

.dropzone-content {
  border: 2px dashed #374151;
  border-radius: 12px;
  padding: 24px;
  display: flex;
  flex-direction: column;
  align-items: center;
  align-items: center;
  justify-content: center;
  text-align: center;
  background: #0f172a;
  cursor: pointer;
  transition: all 0.2s;
}

.upload-dropzone:hover {
  border-color: #3b82f6;
  background: #1e293b;
}

.dropzone-content {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.dropzone-content strong {
  font-size: 13px;
  color: #fff;
  margin-top: 8px;
}

.dropzone-content small {
  font-size: 11px;
  color: #94a3b8;
  margin-top: 4px;
}

/* Native & API Config Sections */
.native-inputs-card,
.api-inputs-card {
  background: #0d1321;
  border: 1px solid #1f2937;
  border-radius: 12px;
  padding: 16px;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.native-title,
.api-title {
  font-size: 12px;
  font-weight: 700;
  color: #93c5fd;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.field-hint {
  font-size: 11px;
  color: #64748b;
  margin-top: 2px;
}

.code-editor-textarea {
  width: 100%;
  background: #090d16;
  border: 1px solid #374151;
  border-radius: 8px;
  padding: 10px 12px;
  color: #38bdf8;
  font-family: 'JetBrains Mono', monospace;
  font-size: 12px;
  line-height: 1.4;
  resize: vertical;
}

.code-editor-textarea:focus {
  outline: none;
  border-color: #3b82f6;
  box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.25);
}

/* Multi-Endpoint Styles */
.endpoints-header-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 16px;
  margin-bottom: 8px;
}

.endpoints-title {
  display: flex;
  align-items: center;
  gap: 8px;
  color: #f8fafc;
  font-size: 14px;
}

.endpoints-container {
  display: flex;
  flex-direction: column;
  gap: 14px;
}

.endpoint-card {
  background: #090d16;
  border: 1px solid #1f2937;
  border-radius: 12px;
  padding: 16px;
}

.endpoint-card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-bottom: 12px;
  border-bottom: 1px solid #1f2937;
  margin-bottom: 14px;
}

.endpoint-main-meta {
  display: flex;
  align-items: center;
  gap: 10px;
}

.http-badge {
  font-size: 10px;
  font-weight: 800;
  padding: 3px 8px;
  border-radius: 4px;
  text-transform: uppercase;
}

.http-badge.get { background: rgba(16, 185, 129, 0.2); color: #34d399; }
.http-badge.post { background: rgba(59, 130, 246, 0.2); color: #60a5fa; }
.http-badge.put { background: rgba(245, 158, 11, 0.2); color: #fbbf24; }
.http-badge.patch { background: rgba(168, 85, 247, 0.2); color: #c084fc; }
.http-badge.delete { background: rgba(239, 68, 68, 0.2); color: #f87171; }

.endpoint-path-code {
  font-size: 12px;
  color: #38bdf8;
  background: rgba(15, 23, 42, 0.6);
  padding: 2px 8px;
  border-radius: 4px;
  border: 1px solid #1e293b;
}

.remove-endpoint-btn {
  background: none;
  border: none;
  color: #ef4444;
  font-size: 12px;
  font-weight: 600;
  cursor: pointer;
  padding: 4px 8px;
  border-radius: 4px;
  transition: background-color 0.2s;
}

.remove-endpoint-btn:hover {
  background: rgba(239, 68, 68, 0.15);
}

/* Visual Response Mapping Section */
.mapping-section {
  margin-top: 14px;
  background: #0f172a;
  border: 1px solid #1f2937;
  border-radius: 10px;
  padding: 14px;
}

.mapping-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 10px;
  margin-bottom: 12px;
}

.mapping-title {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 12px;
  font-weight: 700;
  color: #10b981;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.mapping-actions {
  display: flex;
  align-items: center;
  gap: 12px;
}

.root-path-box {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 11px;
  color: #94a3b8;
}

.mini-text-input {
  background: #090d16;
  border: 1px solid #374151;
  border-radius: 4px;
  color: #f8fafc;
  font-family: 'JetBrains Mono', monospace;
  font-size: 11px;
  padding: 4px 8px;
  width: 130px;
}

.add-rule-btn {
  background: rgba(16, 185, 129, 0.15);
  border: 1px solid rgba(16, 185, 129, 0.3);
  color: #34d399;
  font-size: 11px;
  font-weight: 600;
  padding: 5px 10px;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s;
}

.add-rule-btn:hover {
  background: rgba(16, 185, 129, 0.25);
  border-color: #34d399;
}

.mapping-table-wrapper {
  overflow-x: auto;
}

.mapping-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 12px;
}

.mapping-table th {
  font-size: 10px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  color: #64748b;
  padding: 8px 10px;
  border-bottom: 1px solid #1f2937;
  text-align: left;
}

.mapping-table td {
  padding: 6px 8px;
  border-bottom: 1px solid rgba(31, 41, 55, 0.5);
  vertical-align: middle;
}

.mapping-input {
  width: 100%;
  background: #090d16;
  border: 1px solid #374151;
  border-radius: 6px;
  color: #f8fafc;
  font-size: 12px;
  padding: 6px 8px;
}

.mapping-input:focus {
  outline: none;
  border-color: #3b82f6;
}

.mapping-select {
  width: 100%;
  background: #090d16;
  border: 1px solid #374151;
  border-radius: 6px;
  color: #cbd5e1;
  font-size: 12px;
  padding: 6px 8px;
}

.remove-rule-btn {
  background: none;
  border: none;
  color: #ef4444;
  font-size: 13px;
  cursor: pointer;
  padding: 4px;
}

.empty-rules {
  text-align: center;
  color: #64748b;
  font-style: italic;
  padding: 16px !important;
}

/* Tab Pills and Preview Viewers */
.endpoint-header-right {
  display: flex;
  align-items: center;
  gap: 12px;
}

.ep-tab-pills {
  display: flex;
  background: #0f172a;
  padding: 2px;
  border-radius: 8px;
  border: 1px solid #1f2937;
  gap: 2px;
}

.ep-tab-pill {
  background: transparent;
  border: none;
  color: #94a3b8;
  font-size: 11px;
  font-weight: 600;
  padding: 4px 10px;
  border-radius: 6px;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
  transition: all 0.15s ease;
}

.ep-tab-pill:hover {
  color: #f8fafc;
  background: rgba(255, 255, 255, 0.05);
}

.ep-tab-pill.active {
  background: #1e293b;
  color: #f8fafc;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.4);
}

.ep-tab-pill.curl.active {
  color: #60a5fa;
  background: rgba(59, 130, 246, 0.15);
}

.ep-tab-pill.preview.active {
  color: #34d399;
  background: rgba(16, 185, 129, 0.15);
}

.curl-tab-body,
.preview-tab-body {
  display: flex;
  flex-direction: column;
  gap: 10px;
  background: #090d16;
  border: 1px solid #1f2937;
  border-radius: 10px;
  padding: 14px;
}

.code-preview-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.code-preview-title {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 12px;
  font-weight: 700;
  color: #cbd5e1;
}

.copy-btn {
  background: #1e293b;
  border: 1px solid #374151;
  color: #f8fafc;
  font-size: 11px;
  font-weight: 600;
  padding: 4px 10px;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.copy-btn:hover {
  background: #3b82f6;
  border-color: #3b82f6;
}

.preview-badge-status {
  background: rgba(16, 185, 129, 0.2);
  color: #34d399;
  font-size: 11px;
  font-weight: 700;
  padding: 2px 8px;
  border-radius: 4px;
}

.curl-code-block {
  background: #050811;
  border: 1px solid #1e293b;
  border-radius: 8px;
  padding: 14px 16px;
  color: #38bdf8;
  font-size: 12px;
  line-height: 1.5;
  overflow-x: auto;
  white-space: pre-wrap;
  word-break: break-word;
}

.curl-code-block.json-preview {
  color: #34d399;
}

/* User Reference Layout Styles */
.endpoint-inner-header {
  background: #090d16;
  border: 1px solid #1f2937;
  border-radius: 10px;
  padding: 14px;
  margin-top: 10px;
}

.endpoint-heading-title {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 14px;
  color: #f8fafc;
}

.required-tag {
  font-size: 11px;
  color: #64748b;
}

.target-format-wrapper {
  background: #050811;
  border: 1px solid #1f2937;
  border-radius: 8px;
  overflow: hidden;
}

.target-format-code {
  width: 100%;
  background: transparent;
  border: none;
  color: #f87171;
  font-family: 'JetBrains Mono', monospace;
  font-size: 12px;
  line-height: 1.5;
  padding: 14px;
  resize: vertical;
}

.target-format-code:focus {
  outline: none;
}

.toggle-format-row {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 13px;
  color: #cbd5e1;
  margin-top: 12px;
  padding: 8px 0;
}

.field-mapping-container {
  background: #090d16;
  border: 1px solid #1f2937;
  border-radius: 12px;
  padding: 16px;
  margin-top: 12px;
}

.field-mapping-title {
  font-size: 13px;
  font-weight: 700;
  color: #94a3b8;
  margin-bottom: 12px;
}

.mapping-rows-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.mapping-field-item {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.mapping-row-main {
  display: flex;
  align-items: center;
  gap: 12px;
}

.target-field-col {
  width: 120px;
  font-size: 13px;
  color: #cbd5e1;
  white-space: nowrap;
}

.custom-target-input {
  width: 100%;
  background: #090d16;
  border: 1px solid #374151;
  border-radius: 6px;
  color: #60a5fa;
  font-weight: 600;
  font-size: 12px;
  padding: 6px 8px;
}

.custom-target-input:focus {
  outline: none;
  border-color: #3b82f6;
}

.remove-custom-field-btn {
  background: none;
  border: none;
  color: #ef4444;
  font-size: 13px;
  cursor: pointer;
  padding: 4px;
}

.remove-custom-field-btn:hover {
  color: #f87171;
}

.source-jsonpath-col {
  flex: 2;
}

.default-value-col {
  flex: 1;
}

.transform-action-col {
  width: 95px;
}

.transform-toggle-btn {
  width: 100%;
  background: transparent;
  border: 1px dashed #374151;
  color: #94a3b8;
  font-size: 11px;
  font-weight: 600;
  padding: 7px 10px;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s;
  white-space: nowrap;
}

.transform-toggle-btn:hover {
  border-color: #60a5fa;
  color: #60a5fa;
}

.transform-toggle-btn.active {
  background: rgba(59, 130, 246, 0.15);
  border-color: #3b82f6;
  color: #60a5fa;
}

.transform-sub-row {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-left: 122px;
  background: rgba(15, 23, 42, 0.7);
  border: 1px solid #1f2937;
  border-radius: 8px;
  padding: 8px 12px;
}

.transform-type-select {
  width: 160px;
}

.transform-select {
  width: 100%;
  background: #090d16;
  border: 1px solid #374151;
  border-radius: 6px;
  color: #cbd5e1;
  font-size: 12px;
  padding: 6px 8px;
}

.transform-param-input {
  flex: 1;
}

.remove-transform-btn {
  background: none;
  border: none;
  color: #ef4444;
  font-size: 12px;
  font-weight: 600;
  cursor: pointer;
  padding: 4px 8px;
}

.remove-transform-btn:hover {
  text-decoration: underline;
}

.add-custom-field-btn {
  background: rgba(59, 130, 246, 0.15);
  border: 1px dashed rgba(59, 130, 246, 0.4);
  color: #60a5fa;
  font-size: 12px;
  font-weight: 600;
  padding: 8px 14px;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s;
}

.add-custom-field-btn:hover {
  background: rgba(59, 130, 246, 0.25);
  border-color: #60a5fa;
}

.modal-footer {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  margin-top: 8px;
  padding-top: 16px;
  border-top: 1px solid #1f2937;
}
</style>
