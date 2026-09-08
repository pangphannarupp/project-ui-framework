<template>
  <div class="home-view">
    <!-- Hero Banner -->
    <div class="hero-banner glass-panel">
      <div class="hero-content">
        <div class="hero-badge">
          <span class="badge-dot"></span>
          <span>@phanna/ui-framework v1.0.11</span>
        </div>
        <h1 class="hero-title">{{ t.hubTitle }}</h1>
        <p class="hero-subtitle">{{ t.hubSubtitle }}</p>

        <!-- Search Bar with PPSearch -->
        <div class="search-wrapper">
          <PPSearch
            v-model="searchQuery"
            :placeholder="t.searchPlugins"
            style="width: 100%;"
          />
        </div>
      </div>

      <div class="hero-stats">
        <div class="stat-card">
          <span class="stat-num">{{ mockPlugins.length }}</span>
          <span class="stat-lbl">{{ t.pluginsTotal }}</span>
        </div>
        <div class="stat-divider"></div>
        <div class="stat-card">
          <span class="stat-num">{{ mockProjects.length }}</span>
          <span class="stat-lbl">{{ t.projectsTotal }}</span>
        </div>
      </div>
    </div>

    <!-- Category Filter Bar (PPSegment) -->
    <div class="category-segment-container">
      <PPSegment v-model="selectedCategory" variant="pill">
        <PPSegmentButton value="All">{{ t.allCategories }}</PPSegmentButton>
        <PPSegmentButton value="Native & Hardware">Native & Hardware</PPSegmentButton>
        <PPSegmentButton value="File & Storage">File & Storage</PPSegmentButton>
        <PPSegmentButton value="Network & Security">Network & Security</PPSegmentButton>
        <PPSegmentButton value="System & Utilities">System & Utilities</PPSegmentButton>
      </PPSegment>
    </div>

    <!-- Plugins Grid -->
    <div class="plugins-section">
      <div class="section-title-row">
        <h2>Native Hybrid & Plugins Catalog</h2>
        <span class="results-count">{{ filteredPlugins.length }} plugins available</span>
      </div>

      <div class="plugins-grid" v-if="filteredPlugins.length > 0">
        <PluginCard
          v-for="plugin in filteredPlugins"
          :key="plugin.id"
          :plugin="plugin"
          @select="openPluginDetail"
        />
      </div>

      <div v-else class="empty-state glass-panel">
        <PPNoResult
          title="No Plugins Found"
          description="Try adjusting your search keywords or switching category filters."
        />
      </div>
    </div>

    <!-- Interactive Component Preview Bottom Sheet -->
    <PPBottomSheet v-model="showPreviewSheet">
      <div class="preview-sheet-content" v-if="selectedPlugin">
        <div class="sheet-top-header">
          <div class="sheet-icon" :style="{ backgroundColor: `${selectedPlugin.color || 'var(--pp-primary)'}20`, color: selectedPlugin.color || 'var(--pp-primary)' }">
            <ion-icon :icon="selectedPlugin.icon" class="sheet-icon-el"></ion-icon>
          </div>
          <div class="sheet-titles">
            <h3>{{ selectedPlugin.title }}</h3>
            <span class="sheet-lib-name">{{ selectedPlugin.name }}</span>
          </div>
        </div>

        <p class="sheet-description">{{ selectedPlugin.description }}</p>

        <!-- Live Component Demo Preview -->
        <div class="demo-box">
          <div class="demo-header">
            <span>NATIVE BRIDGE CALL INVOCATION</span>
            <PPChip :label="selectedPlugin.category" size="sm" variant="soft" />
          </div>

          <div class="code-execution-box">
            <div class="code-block-header">
              <span>Method: <code>{{ selectedPlugin.name }}</code></span>
            </div>
            <pre class="code-preview-text"><code>// Native invocation signature
{{ getPluginCallCode(selectedPlugin) }}</code></pre>
          </div>

          <div class="test-action-row">
            <PPButton
              variant="primary"
              size="md"
              class="call-action-btn"
              :disabled="isCallingBizMOB"
              @click="runNativeSimulation(selectedPlugin)"
            >
              <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2.5" style="margin-right:6px;">
                <polygon points="5 3 19 12 5 21 5 3"></polygon>
              </svg>
              <span>{{ isCallingBizMOB ? 'Executing Native Call...' : 'Execute bizMOB Native Call' }}</span>
            </PPButton>
            <span v-if="callStatusText" class="sim-result-badge">{{ callStatusText }}</span>
          </div>

          <div v-if="demoCallResult" class="response-result-box">
            <div class="response-header">
              <span>RESPONSE PAYLOAD (Callback)</span>
            </div>
            <pre class="response-json"><code>{{ demoCallResult }}</code></pre>
          </div>
        </div>

        <div class="sheet-actions">
          <PPButton variant="soft" size="lg" style="width: 100%; font-weight: 700;" @click="showPreviewSheet = false">
            {{ t.close }}
          </PPButton>
        </div>
      </div>
    </PPBottomSheet>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import {
  PPButton,
  PPSearch,
  PPSegment,
  PPSegmentButton,
  PPBottomSheet,
  PPChip,
  PPNoResult
} from '@phanna/ui-framework'
import { mockPlugins, mockProjects } from '../data/mockData'
import { useAppState } from '../stores/appState'
import PluginCard from '../components/home/PluginCard.vue'
import type { PluginItem } from '../types'

const { t } = useAppState()

const searchQuery = ref('')
const selectedCategory = ref('All')
const selectedPlugin = ref<PluginItem | null>(null)
const showPreviewSheet = ref(false)

const filteredPlugins = computed(() => {
  return mockPlugins.filter(p => {
    const matchesCategory =
      selectedCategory.value === 'All' ||
      p.category.toLowerCase().includes(selectedCategory.value.toLowerCase())
    
    const query = searchQuery.value.toLowerCase().trim()
    const matchesSearch =
      !query ||
      p.title.toLowerCase().includes(query) ||
      p.name.toLowerCase().includes(query) ||
      p.description.toLowerCase().includes(query) ||
      p.category.toLowerCase().includes(query)
    
    return matchesCategory && matchesSearch
  })
})

const isCallingBizMOB = ref(false)
const demoCallResult = ref<string>('')
const demoCallSuccess = ref(false)
const callStatusText = ref('')

const getPluginCallCode = (plugin: PluginItem): string => {
  switch (plugin.id) {
    case 'bizmob-code-reader':
      return `this.$bizMOB.Window.openCodeReader({
  _fCallback: function(res) {
    console.log("Scan Result:", res);
  }
});`
    case 'bizmob-camera-capture':
      return `this.$bizMOB.App.callPlugIn("TAKE_PHOTO_PLUGIN", {
  callback: function(response) {
    console.log("Photo Base64:", response.base64);
  }
});`
    case 'bizmob-signature':
      return `this.$bizMOB.Window.openSignPad({
  _sTargetPath: "{external}/signpad/sign.bmp",
  _fCallback: function(res) {
    console.log("Signature saved to:", res.target_path);
  }
});`
    case 'bizmob-haptic':
      return `this.$bizMOB.App.callPlugIn("HAPTIC_PLUGIN", {
  body: { type: 1, vibrate_repeat: 3 },
  callback: function(res) {
    console.log("Haptic triggered:", res);
  }
});`
    case 'bizmob-gps':
      return `this.$bizMOB.System.getGPS({
  _fCallback: function(res) {
    console.log("Coordinates:", res.lat, res.lon);
  }
});`
    case 'bizmob-gallery':
      return `this.$bizMOB.System.callGallery({
  _aType: "image",
  _fCallback: function(res) {
    console.log("Selected Image:", res);
  }
});`
    case 'bizmob-request-http':
      return `this.$bizMOB.App.callPlugIn("REQUEST_HTTP", {
  url: "https://jsonplaceholder.typicode.com/posts/1",
  method: "get",
  progress: true,
  callback: function(res) {
    console.log("HTTP Response:", res);
  }
});`
    case 'bizmob-device-info':
      return `const info = this.$bizMOB.Device.getInfo();
console.log("Device Info:", info);`
    default:
      return `${plugin.name}({\n  _fCallback: (res) => console.log(res)\n});`
  }
}

const runNativeSimulation = (plugin: PluginItem) => {
  isCallingBizMOB.value = true
  demoCallSuccess.value = false
  demoCallResult.value = 'Calling bizMOB Native Bridge...'
  callStatusText.value = 'Executing...'

  const bizMOB = (window as any).bizMOB

  // Helper to handle callback responses
  const handleResponse = (res: any, source: string) => {
    isCallingBizMOB.value = false
    demoCallSuccess.value = true
    callStatusText.value = `✓ Received from ${source}`
    demoCallResult.value = JSON.stringify(res, null, 2)
  }

  try {
    if (bizMOB) {
      if (plugin.id === 'bizmob-code-reader' && bizMOB.Window?.openCodeReader) {
        bizMOB.Window.openCodeReader({
          _fCallback: (res: any) => handleResponse(res, 'bizMOB.Window')
        })
        return
      }

      if (plugin.id === 'bizmob-signature' && bizMOB.Window?.openSignPad) {
        bizMOB.Window.openSignPad({
          _sTargetPath: '{external}/signpad/sign.bmp',
          _fCallback: (res: any) => handleResponse(res, 'bizMOB.Window')
        })
        return
      }

      if (plugin.id === 'bizmob-gallery' && bizMOB.System?.callGallery) {
        bizMOB.System.callGallery({
          _aType: 'image',
          _fCallback: (res: any) => handleResponse(res, 'bizMOB.System')
        })
        return
      }

      if (plugin.id === 'bizmob-gps' && bizMOB.System?.getGPS) {
        bizMOB.System.getGPS({
          _fCallback: (res: any) => handleResponse(res, 'bizMOB.System')
        })
        return
      }

      if (plugin.id === 'bizmob-device-info' && bizMOB.Device?.getInfo) {
        const info = bizMOB.Device.getInfo()
        handleResponse(info, 'bizMOB.Device')
        return
      }

      if (plugin.id === 'bizmob-haptic' && bizMOB.App?.callPlugIn) {
        bizMOB.App.callPlugIn('HAPTIC_PLUGIN', {
          body: { type: 1, vibrate_repeat: 3 },
          callback: (res: any) => handleResponse(res, 'bizMOB.App Plugin')
        })
        return
      }

      if (plugin.id === 'bizmob-camera-capture' && bizMOB.App?.callPlugIn) {
        bizMOB.App.callPlugIn('TAKE_PHOTO_PLUGIN', {
          callback: (res: any) => handleResponse(res, 'bizMOB.App Plugin')
        })
        return
      }

      if (plugin.id === 'bizmob-request-http' && bizMOB.App?.callPlugIn) {
        bizMOB.App.callPlugIn('REQUEST_HTTP', {
          url: 'https://jsonplaceholder.typicode.com/posts/1',
          method: 'get',
          progress: true,
          callback: (res: any) => handleResponse(res, 'bizMOB.App Plugin')
        })
        return
      }

      if (plugin.id === 'bizmob-storage-prop' && bizMOB.Properties) {
        bizMOB.Properties.set({ _sKey: 'SAMPLE_KEY', _vValue: { user: 'Admin', timestamp: Date.now() } })
        const val = bizMOB.Properties.get({ _sKey: 'SAMPLE_KEY' })
        handleResponse({ storedKey: 'SAMPLE_KEY', value: val }, 'bizMOB.Properties')
        return
      }
    }

    // Fallback simulation when in pure browser mode without native bridge container
    setTimeout(() => {
      let mockRes: any = {
        result: true,
        source: 'bizMOB Web Bridge Simulation',
        timestamp: new Date().toISOString()
      }

      if (plugin.id === 'bizmob-code-reader') {
        mockRes = { result: true, data: 'https://pangphannarupp.github.io/project-ui-framework/', format: 'QR_CODE' }
      } else if (plugin.id === 'bizmob-camera-capture') {
        mockRes = { result: true, base64: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAE...', file_size: '2.4MB' }
      } else if (plugin.id === 'bizmob-gps') {
        mockRes = { result: true, lat: 11.5564, lon: 104.9282, accuracy: 5.0, address: 'Phnom Penh, Cambodia' }
      } else if (plugin.id === 'bizmob-device-info') {
        mockRes = { result: true, model: navigator.userAgent.includes('Mobile') ? 'Mobile Device' : 'Desktop Browser', platform: navigator.platform, isWeb: true }
      } else if (plugin.id === 'bizmob-signature') {
        mockRes = { result: true, target_path: '{external}/signpad/sign.bmp', format: 'BMP' }
      }

      handleResponse(mockRes, 'bizMOB Web Bridge')
    }, 400)
  } catch (err: any) {
    isCallingBizMOB.value = false
    demoCallSuccess.value = false
    callStatusText.value = 'Error invoking plugin'
    demoCallResult.value = JSON.stringify({ error: err.message || String(err) }, null, 2)
  }
}

const openPluginDetail = (plugin: PluginItem) => {
  selectedPlugin.value = plugin
  demoCallResult.value = ''
  demoCallSuccess.value = false
  callStatusText.value = ''
  showPreviewSheet.value = true
}
</script>

<style scoped>
.home-view {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.hero-banner {
  padding: 24px;
  border-radius: var(--radius-lg);
  border: 1px solid var(--border-color);
  background: linear-gradient(135deg, var(--bg-card) 0%, var(--bg-card-glass) 100%);
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 20px;
  position: relative;
  overflow: hidden;
}

.hero-banner::before {
  content: '';
  position: absolute;
  top: -50%;
  right: -20%;
  width: 300px;
  height: 300px;
  border-radius: 50%;
  background: var(--pp-primary);
  opacity: 0.08;
  pointer-events: none;
  filter: blur(40px);
}

.hero-content {
  flex: 1;
  min-width: 280px;
}

.hero-badge {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 4px 12px;
  border-radius: 20px;
  background: var(--pp-primary-light);
  color: var(--pp-primary);
  font-size: 11px;
  font-weight: 700;
  margin-bottom: 10px;
}

.badge-dot {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background-color: var(--pp-primary);
}

.hero-title {
  font-size: 22px;
  font-weight: 800;
  color: var(--text-main);
  margin-bottom: 6px;
}

.hero-subtitle {
  font-size: 13px;
  color: var(--text-muted);
  margin-bottom: 16px;
  line-height: 1.4;
}

.search-wrapper {
  max-width: 480px;
}

.hero-stats {
  display: flex;
  align-items: center;
  gap: 20px;
  padding: 14px 20px;
  border-radius: var(--radius-md);
  background: var(--bg-main);
  border: 1px solid var(--border-color);
}

.stat-card {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.stat-num {
  font-size: 24px;
  font-weight: 800;
  color: var(--pp-primary);
}

.stat-lbl {
  font-size: 11px;
  font-weight: 600;
  color: var(--text-muted);
}

.stat-divider {
  width: 1px;
  height: 32px;
  background: var(--border-color);
}

.category-segment-container {
  overflow-x: auto;
  padding-bottom: 4px;
}

.category-segment-container :deep(.pp-segment) {
  background-color: var(--bg-card) !important;
  border: 1px solid var(--border-color) !important;
}

.plugins-section {
  display: flex;
  flex-direction: column;
  gap: 14px;
}

.section-title-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.section-title-row h2 {
  font-size: 17px;
  font-weight: 700;
  color: var(--text-main);
}

.results-count {
  font-size: 12px;
  color: var(--text-sub);
}

.plugins-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
  gap: 16px;
}

.empty-state {
  border-radius: var(--radius-md);
  padding: 30px;
  display: flex;
  align-items: center;
  justify-content: center;
}

/* Bottom Sheet Content */
.preview-sheet-content {
  padding: 20px 24px 32px 24px;
}

.sheet-top-header {
  display: flex;
  align-items: center;
  gap: 14px;
  margin-bottom: 12px;
}

.sheet-icon {
  width: 48px;
  height: 48px;
  border-radius: 14px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.sheet-icon-el {
  font-size: 26px;
}

.sheet-titles h3 {
  font-size: 18px;
  font-weight: 700;
  color: var(--text-main);
}

.sheet-lib-name {
  font-size: 12px;
  font-family: monospace;
  color: var(--text-sub);
}

.sheet-description {
  font-size: 13px;
  color: var(--text-muted);
  line-height: 1.5;
  margin-bottom: 20px;
}

.demo-box {
  border-radius: var(--radius-md);
  padding: 16px;
  background: var(--bg-card);
  border: 1px solid var(--border-color);
  margin-bottom: 20px;
}

.demo-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 11px;
  font-weight: 700;
  color: var(--text-sub);
  letter-spacing: 0.5px;
  margin-bottom: 14px;
}

.code-execution-box {
  border-radius: var(--radius-sm);
  background: var(--bg-main);
  border: 1px solid var(--border-color);
  padding: 14px;
  overflow-x: auto;
}

.code-block-header {
  font-size: 12px;
  font-weight: 700;
  color: var(--text-muted);
  margin-bottom: 8px;
}

.code-block-header code {
  color: var(--pp-primary);
  font-family: monospace;
}

.code-preview-text {
  font-size: 12px;
  font-family: monospace;
  color: var(--text-main);
  margin: 0;
  line-height: 1.5;
  white-space: pre-wrap;
}

.test-action-row {
  margin-top: 14px;
  display: flex;
  gap: 12px;
  align-items: center;
  flex-wrap: wrap;
}

.call-action-btn {
  display: inline-flex;
  align-items: center;
  font-weight: 700;
}

.sim-result-badge {
  font-size: 12px;
  font-weight: 700;
  color: #10b981;
  background: rgba(16, 185, 129, 0.1);
  padding: 4px 10px;
  border-radius: 6px;
}

.response-result-box {
  border-radius: var(--radius-sm);
  background: var(--bg-main);
  border: 1px solid var(--border-color);
  padding: 14px;
  margin-top: 14px;
}

.response-header {
  font-size: 10px;
  font-weight: 800;
  letter-spacing: 0.6px;
  color: var(--text-sub);
  margin-bottom: 8px;
}

.response-json {
  font-size: 11px;
  font-family: monospace;
  color: var(--pp-primary);
  margin: 0;
  line-height: 1.45;
  white-space: pre-wrap;
}

.sheet-actions {
  margin-top: 16px;
}
</style>
