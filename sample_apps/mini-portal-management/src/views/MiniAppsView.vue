<script setup lang="ts">
import { ref, computed } from 'vue'
import AdminLayout from '../layouts/AdminLayout.vue'
import { mockMiniApps, type MiniApp } from '../data/mockData'

const miniApps = ref<MiniApp[]>([...mockMiniApps])
const selectedCategory = ref('All')
const searchQuery = ref('')
const viewMode = ref<'grid' | 'table'>('grid')
const showCreateModal = ref(false)

const categories = ['All', 'Food & Beverage', 'Entertainment', 'Services', 'Mobility', 'Finance']

const newApp = ref({
  name: '',
  slug: '',
  category: 'Services',
  description: '',
  version: 'v1.0.0',
  packageType: 'zip' as 'zip' | 'web_url' | 'native_aar',
  packageUrl: '',
  uploadedFileName: '',
  uploadedFileSize: '',
  androidPackageName: '',
  androidActivityClass: '',
  iosViewControllerClass: ''
})

const filteredApps = computed(() => {
  return miniApps.value.filter(app => {
    const matchCategory = selectedCategory.value === 'All' || app.category === selectedCategory.value
    const matchSearch = app.name.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                        app.slug.toLowerCase().includes(searchQuery.value.toLowerCase())
    return matchCategory && matchSearch
  })
})

const toggleAppStatus = (app: MiniApp) => {
  app.status = app.status === 'active' ? 'staging' : 'active'
}

const handleFileSelect = (event: Event) => {
  const target = event.target as HTMLInputElement
  if (target.files && target.files[0]) {
    const file = target.files[0]
    newApp.value.uploadedFileName = file.name
    newApp.value.uploadedFileSize = `${(file.size / (1024 * 1024)).toFixed(1)} MB`
  }
}

const handleCreateApp = () => {
  if (!newApp.value.name) return
  
  const created: MiniApp = {
    id: `app-${Date.now()}`,
    name: newApp.value.name,
    slug: newApp.value.slug || newApp.value.name.toLowerCase().replace(/\s+/g, '-'),
    category: newApp.value.category as any,
    icon: 'apps-outline',
    version: newApp.value.version,
    packageType: newApp.value.packageType,
    packageUrl: newApp.value.packageType === 'web_url' ? newApp.value.packageUrl : undefined,
    fileName: newApp.value.packageType !== 'web_url' ? (newApp.value.uploadedFileName || `${newApp.value.name.toLowerCase()}.${newApp.value.packageType === 'zip' ? 'zip' : 'aar'}`) : undefined,
    fileSize: newApp.value.packageType !== 'web_url' ? (newApp.value.uploadedFileSize || '5.2 MB') : undefined,
    status: 'staging',
    usersCount: 0,
    rating: 5.0,
    path: `/sample-apps/${newApp.value.slug}/`,
    updatedAt: new Date().toISOString().split('T')[0],
    description: newApp.value.description || 'Newly registered mini application.'
  }

  miniApps.value.unshift(created)
  showCreateModal.value = false
  newApp.value = {
    name: '',
    slug: '',
    category: 'Services',
    description: '',
    version: 'v1.0.0',
    packageType: 'zip',
    packageUrl: '',
    uploadedFileName: '',
    uploadedFileSize: '',
    androidPackageName: '',
    androidActivityClass: '',
    iosViewControllerClass: ''
  }
}
</script>

<template>
  <AdminLayout>
    <div class="mini-apps-view">
      <!-- Action Toolbar -->
      <div class="toolbar glass-panel">
        <div class="toolbar-left">
          <div class="filter-pills">
            <button
              v-for="cat in categories"
              :key="cat"
              class="pill-btn"
              :class="{ 'active': selectedCategory === cat }"
              @click="selectedCategory = cat"
            >
              {{ cat }}
            </button>
          </div>
        </div>

        <div class="toolbar-right">
          <div class="search-input">
            <span>🔍</span>
            <input type="text" v-model="searchQuery" placeholder="Filter mini apps..." />
          </div>

          <div class="view-switch">
            <button :class="{ 'active': viewMode === 'grid' }" @click="viewMode = 'grid'">▦</button>
            <button :class="{ 'active': viewMode === 'table' }" @click="viewMode = 'table'">☰</button>
          </div>

          <button @click="showCreateModal = true" class="btn btn-primary">
            <span>+ Register New App</span>
          </button>
        </div>
      </div>

      <!-- Grid View -->
      <div v-if="viewMode === 'grid'" class="apps-grid">
        <div v-for="app in filteredApps" :key="app.id" class="app-card glass-panel">
          <div class="app-card-header">
            <div class="app-icon">
              <span>{{ app.name.slice(0, 1) }}</span>
            </div>
            <div class="app-title-area">
              <h3>{{ app.name }}</h3>
              <code>{{ app.slug }}</code>
            </div>
            <span class="status-badge" :class="app.status">{{ app.status }}</span>
          </div>

          <p class="app-desc">{{ app.description }}</p>

          <div class="app-metrics">
            <div class="metric">
              <small>Package Type</small>
              <span class="pkg-badge" :class="app.packageType">
                <span v-if="app.packageType === 'zip'">📦 Zip Bundle</span>
                <span v-else-if="app.packageType === 'web_url'">🌐 Web URL</span>
                <span v-else>🤖 Native AAR</span>
              </span>
            </div>
            <div class="metric">
              <small>Version</small>
              <strong>{{ app.version }}</strong>
            </div>
            <div class="metric">
              <small>Active Users</small>
              <strong>{{ (app.usersCount).toLocaleString() }}</strong>
            </div>
          </div>

          <div v-if="app.fileName || app.packageUrl" class="package-source-info">
            <small class="text-muted font-mono" v-if="app.fileName">📁 {{ app.fileName }} ({{ app.fileSize }})</small>
            <small class="text-muted font-mono" v-else-if="app.packageUrl">🔗 {{ app.packageUrl }}</small>
          </div>

          <div class="app-card-actions">
            <button @click="toggleAppStatus(app)" class="action-btn toggle-btn" :class="{ 'active-btn': app.status === 'active' }">
              {{ app.status === 'active' ? 'Deactivate' : 'Activate' }}
            </button>
            <a :href="`https://pangphannarupp.github.io/project-ui-framework${app.path}`" target="_blank" class="action-btn launch-btn">
              Launch Webview ↗
            </a>
          </div>
        </div>
      </div>

      <!-- Table View -->
      <div v-else class="card glass-panel">
        <div class="table-container">
          <table class="portal-table">
            <thead>
              <tr>
                <th>NAME & SLUG</th>
                <th>CATEGORY</th>
                <th>PACKAGE TYPE</th>
                <th>VERSION</th>
                <th>STATUS</th>
                <th>MAU</th>
                <th>LAST UPDATED</th>
                <th>ACTIONS</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="app in filteredApps" :key="app.id">
                <td>
                  <div class="table-app-info">
                    <strong>{{ app.name }}</strong>
                    <code class="text-muted">{{ app.slug }}</code>
                  </div>
                </td>
                <td><span class="category-pill">{{ app.category }}</span></td>
                <td>
                  <span class="pkg-badge" :class="app.packageType">
                    {{ app.packageType === 'zip' ? '📦 Zip' : app.packageType === 'web_url' ? '🌐 Web URL' : '🤖 Native AAR' }}
                  </span>
                </td>
                <td class="font-mono">{{ app.version }}</td>
                <td><span class="status-badge" :class="app.status">{{ app.status }}</span></td>
                <td class="font-medium">{{ app.usersCount.toLocaleString() }}</td>
                <td class="text-muted font-mono">{{ app.updatedAt }}</td>
                <td>
                  <div class="table-actions">
                    <button @click="toggleAppStatus(app)" class="small-btn">Toggle</button>
                    <a :href="`https://pangphannarupp.github.io/project-ui-framework${app.path}`" target="_blank" class="small-btn highlight">Launch</a>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- Create Modal -->
      <div v-if="showCreateModal" class="modal-backdrop">
        <div class="modal-card glass-panel">
          <div class="modal-header">
            <h3>Register New Mini Application</h3>
            <button @click="showCreateModal = false" class="close-btn">✕</button>
          </div>
          <form @submit.prevent="handleCreateApp" class="modal-form">
            <div class="form-group">
              <label>App Name</label>
              <input type="text" v-model="newApp.name" placeholder="e.g. Smart Parking" required />
            </div>
            
            <div class="form-row">
              <div class="form-group flex-1">
                <label>URL Slug / Path</label>
                <input type="text" v-model="newApp.slug" placeholder="e.g. mini-smart-parking" required />
              </div>
              <div class="form-group flex-1">
                <label>Category</label>
                <select v-model="newApp.category">
                  <option v-for="c in categories.filter(c => c !== 'All')" :key="c" :value="c">{{ c }}</option>
                </select>
              </div>
            </div>

            <!-- Package Type Selector -->
            <div class="form-group">
              <label>Deployment Content Type</label>
              <div class="package-type-selector">
                <label class="type-option" :class="{ 'selected': newApp.packageType === 'zip' }">
                  <input type="radio" value="zip" v-model="newApp.packageType" />
                  <div class="option-content">
                    <strong>📦 Content Zip</strong>
                    <small>Static web bundle (.zip)</small>
                  </div>
                </label>
                <label class="type-option" :class="{ 'selected': newApp.packageType === 'web_url' }">
                  <input type="radio" value="web_url" v-model="newApp.packageType" />
                  <div class="option-content">
                    <strong>🌐 Web URL</strong>
                    <small>Hosted remote endpoint</small>
                  </div>
                </label>
                <label class="type-option" :class="{ 'selected': newApp.packageType === 'native_aar' }">
                  <input type="radio" value="native_aar" v-model="newApp.packageType" />
                  <div class="option-content">
                    <strong>🤖 Native AAR</strong>
                    <small>Android / Native SDK (.aar)</small>
                  </div>
                </label>
              </div>
            </div>

            <!-- Dynamic Input based on Package Type -->
            <div v-if="newApp.packageType === 'zip'" class="upload-box">
              <label class="upload-dropzone">
                <input type="file" accept=".zip" @change="handleFileSelect" class="hidden-file-input" />
                <div class="dropzone-content">
                  <span class="upload-icon">📁</span>
                  <strong v-if="newApp.uploadedFileName">{{ newApp.uploadedFileName }} ({{ newApp.uploadedFileSize }})</strong>
                  <strong v-else>Click or drag & drop Content ZIP file</strong>
                  <small>Max upload size: 50MB (Extracts HTML, CSS, JS)</small>
                </div>
              </label>
            </div>

            <div v-else-if="newApp.packageType === 'web_url'" class="form-group">
              <label>Remote Web Application URL</label>
              <input type="url" v-model="newApp.packageUrl" placeholder="https://cdn.yourdomain.com/app/index.html" required />
            </div>

            <div v-else class="native-config-section">
              <div class="upload-box">
                <label class="upload-dropzone">
                  <input type="file" accept=".aar,.framework,.xcframework,.zip" @change="handleFileSelect" class="hidden-file-input" />
                  <div class="dropzone-content">
                    <span class="upload-icon">📦</span>
                    <strong v-if="newApp.uploadedFileName">{{ newApp.uploadedFileName }} ({{ newApp.uploadedFileSize }})</strong>
                    <strong v-else>Upload Android .aar or iOS .xcframework binary</strong>
                    <small>Binary module package for native execution</small>
                  </div>
                </label>
              </div>

              <div class="native-inputs-card">
                <div class="native-title">
                  <span>🤖 Android Configuration</span>
                </div>
                <div class="form-row">
                  <div class="form-group flex-1">
                    <label>Android Package Name</label>
                    <input type="text" v-model="newApp.androidPackageName" placeholder="com.mcnc.miniapp.evcharge" class="font-mono text-sm" />
                  </div>
                  <div class="form-group flex-1">
                    <label>Entry Activity Class</label>
                    <input type="text" v-model="newApp.androidActivityClass" placeholder="com.mcnc.evcharge.MainActivity" class="font-mono text-sm" />
                  </div>
                </div>

                <div class="native-title" style="margin-top: 12px;">
                  <span>🍏 iOS Configuration</span>
                </div>
                <div class="form-group">
                  <label>Entry UIViewController Class / Storyboard ID</label>
                  <input type="text" v-model="newApp.iosViewControllerClass" placeholder="EVChargeMainViewController" class="font-mono text-sm" />
                </div>
              </div>
            </div>

            <div class="form-group">
              <label>Description</label>
              <textarea v-model="newApp.description" rows="2" placeholder="Brief functionality description..."></textarea>
            </div>

            <div class="modal-footer">
              <button type="button" @click="showCreateModal = false" class="btn btn-secondary">Cancel</button>
              <button type="submit" class="btn btn-primary">Deploy & Register App</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </AdminLayout>
</template>

<style scoped>
.mini-apps-view {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 14px;
}

.filter-pills {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}

.pill-btn {
  background: #1f2937;
  border: 1px solid #374151;
  color: #9ca3af;
  padding: 6px 14px;
  border-radius: 20px;
  font-size: 13px;
  cursor: pointer;
  transition: all 0.2s;
}

.pill-btn:hover {
  background: #374151;
  color: #fff;
}

.pill-btn.active {
  background: #2563eb;
  border-color: #3b82f6;
  color: #fff;
  font-weight: 600;
}

.toolbar-right {
  display: flex;
  align-items: center;
  gap: 12px;
}

.search-input {
  display: flex;
  align-items: center;
  gap: 8px;
  background: #0f172a;
  border: 1px solid #374151;
  padding: 8px 12px;
  border-radius: 8px;
}

.search-input input {
  background: transparent;
  border: none;
  color: #fff;
  font-size: 13px;
  outline: none;
}

.view-switch {
  display: flex;
  background: #1f2937;
  padding: 3px;
  border-radius: 8px;
}

.view-switch button {
  background: transparent;
  border: none;
  color: #9ca3af;
  padding: 6px 10px;
  border-radius: 6px;
  cursor: pointer;
}

.view-switch button.active {
  background: #3b82f6;
  color: #fff;
}

.btn {
  padding: 8px 16px;
  border-radius: 8px;
  font-size: 13px;
  font-weight: 600;
  cursor: pointer;
  border: none;
}

.btn-primary {
  background: linear-gradient(135deg, #2563eb, #4f46e5);
  color: #fff;
}

.btn-secondary {
  background: #334155;
  color: #fff;
}

/* Grid */
.apps-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 20px;
}

.app-card {
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 16px;
  padding: 20px;
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.app-card-header {
  display: flex;
  align-items: center;
  gap: 12px;
}

.app-icon {
  width: 42px;
  height: 42px;
  background: linear-gradient(135deg, #6366f1, #3b82f6);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  font-size: 18px;
  color: #fff;
}

.app-title-area {
  flex: 1;
}

.app-title-area h3 {
  font-size: 15px;
  color: #fff;
  font-weight: 700;
}

.app-title-area code {
  font-size: 11px;
  color: #64748b;
}

.status-badge {
  font-size: 11px;
  padding: 2px 8px;
  border-radius: 12px;
  text-transform: capitalize;
  font-weight: 600;
}
.status-badge.active { background: rgba(16, 185, 129, 0.15); color: #10b981; }
.status-badge.staging { background: rgba(245, 158, 11, 0.15); color: #f59e0b; }

.app-desc {
  font-size: 13px;
  color: #94a3b8;
  line-height: 1.5;
  flex: 1;
}

.app-metrics {
  display: flex;
  justify-content: space-between;
  background: #0f172a;
  padding: 10px 14px;
  border-radius: 10px;
  border: 1px solid #1f2937;
}

.metric {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.metric small {
  font-size: 11px;
  color: #64748b;
}

.metric strong {
  font-size: 13px;
  color: #e2e8f0;
}

.app-card-actions {
  display: flex;
  gap: 8px;
}

.action-btn {
  flex: 1;
  padding: 8px;
  border-radius: 8px;
  font-size: 12px;
  font-weight: 600;
  cursor: pointer;
  text-align: center;
  text-decoration: none;
  border: 1px solid #334155;
  background: #1e293b;
  color: #cbd5e1;
  transition: all 0.2s;
}

.action-btn:hover {
  background: #334155;
  color: #fff;
}

.launch-btn {
  background: #2563eb;
  border-color: #3b82f6;
  color: #fff;
}

/* Modal */
.modal-backdrop {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 100;
  padding: 20px;
}

.pkg-badge {
  font-size: 11px;
  padding: 3px 8px;
  border-radius: 6px;
  font-weight: 600;
  display: inline-flex;
  align-items: center;
}

.pkg-badge.zip { background: rgba(59, 130, 246, 0.2); color: #60a5fa; }
.pkg-badge.web_url { background: rgba(16, 185, 129, 0.2); color: #34d399; }
.pkg-badge.native_aar { background: rgba(168, 85, 247, 0.2); color: #c084fc; }

.package-source-info {
  background: #090d16;
  padding: 6px 10px;
  border-radius: 6px;
  border: 1px solid #1f2937;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.form-row {
  display: flex;
  gap: 12px;
}

.flex-1 {
  flex: 1;
}

.package-type-selector {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10px;
  margin-top: 4px;
}

.type-option {
  background: #0f172a;
  border: 1px solid #334155;
  border-radius: 10px;
  padding: 10px;
  cursor: pointer;
  display: flex;
  align-items: flex-start;
  gap: 8px;
  transition: all 0.2s;
}

.type-option input {
  margin-top: 3px;
}

.type-option.selected {
  border-color: #3b82f6;
  background: rgba(59, 130, 246, 0.1);
}

.option-content strong {
  display: block;
  font-size: 12px;
  color: #fff;
}

.option-content small {
  display: block;
  font-size: 10px;
  color: #94a3b8;
}

.upload-box {
  margin-top: 4px;
}

.upload-dropzone {
  display: block;
  border: 2px dashed #374151;
  border-radius: 10px;
  padding: 20px 14px;
  text-align: center;
  cursor: pointer;
  background: #0f172a;
  transition: border-color 0.2s;
}

.upload-dropzone:hover {
  border-color: #60a5fa;
}

.hidden-file-input {
  display: none;
}

.dropzone-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
}

.upload-icon {
  font-size: 28px;
  margin-bottom: 2px;
}

.dropzone-content strong {
  font-size: 13px;
  color: #fff;
}

.dropzone-content small {
  font-size: 11px;
  color: #64748b;
}

.native-config-section {
  display: flex;
  flex-direction: column;
  gap: 14px;
}

.native-inputs-card {
  background: #090d16;
  border: 1px solid #1f2937;
  padding: 16px;
  border-radius: 10px;
}

.native-title {
  font-size: 12px;
  font-weight: 700;
  color: #60a5fa;
  margin-bottom: 8px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.text-sm {
  font-size: 12px !important;
}

.modal-card {
  background: #1e293b;
  border: 1px solid #334155;
  width: 100%;
  max-width: 580px;
  border-radius: 16px;
  padding: 24px;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.modal-header h3 {
  font-size: 18px;
  color: #fff;
}

.close-btn {
  background: transparent;
  border: none;
  color: #94a3b8;
  font-size: 16px;
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
  color: #cbd5e1;
  font-weight: 500;
}

.form-group input,
.form-group select,
.form-group textarea {
  background: #0f172a;
  border: 1px solid #334155;
  padding: 10px 12px;
  border-radius: 8px;
  color: #fff;
  font-size: 13px;
  outline: none;
}

.modal-footer {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
  margin-top: 12px;
}

/* Table elements */
.table-container {
  overflow-x: auto;
}

.portal-table {
  width: 100%;
  border-collapse: collapse;
  text-align: left;
}

.portal-table th {
  font-size: 11px;
  letter-spacing: 0.5px;
  color: #64748b;
  padding: 12px;
  border-bottom: 1px solid #1f2937;
}

.portal-table td {
  padding: 14px 12px;
  font-size: 13px;
  border-bottom: 1px solid #1f2937;
  color: #e2e8f0;
}

.category-pill {
  background: #1f2937;
  padding: 3px 8px;
  border-radius: 12px;
  font-size: 12px;
  color: #94a3b8;
}

.table-actions {
  display: flex;
  gap: 6px;
}

.small-btn {
  padding: 4px 10px;
  border-radius: 6px;
  font-size: 12px;
  background: #1f2937;
  border: 1px solid #374151;
  color: #cbd5e1;
  cursor: pointer;
  text-decoration: none;
}

.small-btn.highlight {
  background: #2563eb;
  color: #fff;
  border-color: #3b82f6;
}
</style>
