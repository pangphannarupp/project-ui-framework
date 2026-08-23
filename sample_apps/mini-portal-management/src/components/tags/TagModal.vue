<script setup lang="ts">
import RichTextEditor from '../RichTextEditor.vue'

defineProps<{
  show: boolean
  isEditing: boolean
  colorPalette: string[]
  availableIcons: { name: string; label: string }[]
  tagForm: {
    name: string
    slug: string
    color: string
    icon: string
    description: string
    isFeatured: boolean
  }
}>()

const emit = defineEmits<{
  (e: 'close'): void
  (e: 'submit'): void
  (e: 'nameInput'): void
}>()
</script>

<template>
  <div v-if="show" class="modal-backdrop">
    <div class="modal-card glass-panel">
      <div class="modal-header">
        <div>
          <h3>{{ isEditing ? 'Edit Tag Details' : 'Create New Search Tag' }}</h3>
          <p class="modal-subtitle">Configure taxonomy indexing metadata, icon branding, and promotion</p>
        </div>
        <button @click="emit('close')" class="close-btn">✕</button>
      </div>

      <form @submit.prevent="emit('submit')" class="modal-form">
        <div class="form-row">
          <div class="form-group flex-2">
            <label>Tag Label / Display Name <span class="required">*</span></label>
            <PPInput
              v-model="tagForm.name"
              placeholder="e.g. Fast Food"
              required
              @input="emit('nameInput')"
            />
          </div>
          <div class="form-group flex-1">
            <label>URL Slug</label>
            <PPInput
              v-model="tagForm.slug"
              placeholder="e.g. fast-food"
              required
            />
          </div>
        </div>

        <!-- Tag Icon Selection -->
        <div class="form-group">
          <label>Select Semantic Tag Icon</label>
          <div class="icon-selector-grid">
            <button
              type="button"
              v-for="iconItem in availableIcons"
              :key="iconItem.name"
              class="icon-select-btn"
              :class="{ active: tagForm.icon === iconItem.name }"
              @click="tagForm.icon = iconItem.name"
            >
              <svg v-if="iconItem.name === 'pricetag'" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M20.59 13.41l-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z"></path><line x1="7" y1="7" x2="7.01" y2="7"></line></svg>
              <svg v-else-if="iconItem.name === 'flash'" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
              <svg v-else-if="iconItem.name === 'coffee'" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8h1a4 4 0 0 1 0 8h-1"></path><path d="M2 8h16v9a4 4 0 0 1-4 4H6a4 4 0 0 1-4-4V8z"></path><line x1="6" y1="1" x2="6" y2="4"></line><line x1="10" y1="1" x2="10" y2="4"></line><line x1="14" y1="1" x2="14" y2="4"></line></svg>
              <svg v-else-if="iconItem.name === 'film'" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="2" width="20" height="20" rx="2.18" ry="2.18"></rect><line x1="7" y1="2" x2="7" y2="22"></line><line x1="17" y1="2" x2="17" y2="22"></line><line x1="2" y1="12" x2="22" y2="12"></line><line x1="2" y1="7" x2="7" y2="7"></line><line x1="2" y1="17" x2="7" y2="17"></line><line x1="17" y1="17" x2="22" y2="17"></line><line x1="17" y1="7" x2="22" y2="7"></line></svg>
              <svg v-else-if="iconItem.name === 'battery-charging'" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 18H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h3.19M15 6h2a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2h-3.19"></path><line x1="23" y1="13" x2="23" y2="11"></line><polyline points="11 6 7 12 13 12 9 18"></polyline></svg>
              <svg v-else-if="iconItem.name === 'card'" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><rect x="1" y="4" width="22" height="16" rx="2" ry="2"></rect><line x1="1" y1="10" x2="23" y2="10"></line></svg>
              <svg v-else-if="iconItem.name === 'qr-code'" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"></rect><rect x="14" y="3" width="7" height="7"></rect><rect x="14" y="14" width="7" height="7"></rect><rect x="3" y="14" width="7" height="7"></rect></svg>
              <svg v-else-if="iconItem.name === 'sparkles'" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"></path></svg>
              <svg v-else-if="iconItem.name === 'cube'" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path><polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline><line x1="12" y1="22.08" x2="12" y2="12"></line></svg>
              <svg v-else-if="iconItem.name === 'star'" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
              <svg v-else-if="iconItem.name === 'gift'" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 12 20 22 4 22 4 12"></polyline><rect x="2" y="7" width="20" height="5"></rect><line x1="12" y1="22" x2="12" y2="7"></line><path d="M12 7H7.5a2.5 2.5 0 0 1 0-5C11 2 12 7 12 7z"></path><path d="M12 7h4.5a2.5 2.5 0 0 0 0-5C13 2 12 7 12 7z"></path></svg>
              <svg v-else viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>
              <span>{{ iconItem.label }}</span>
            </button>
          </div>
        </div>

        <!-- Color Palette Selection -->
        <div class="form-group">
          <label>Brand Accent Color</label>
          <div class="color-palette-row">
            <div class="color-preview-tag" :style="{ borderColor: tagForm.color, color: tagForm.color }">
              {{ tagForm.name || 'Sample Preview' }}
            </div>
            <div class="color-circles">
              <div
                v-for="c in colorPalette"
                :key="c"
                class="color-circle"
                :style="{ backgroundColor: c }"
                :class="{ active: tagForm.color === c }"
                @click="tagForm.color = c"
              ></div>
            </div>
          </div>
        </div>

        <!-- Feature Promotion Toggle -->
        <div class="toggle-box">
          <div>
            <strong>Feature in Search Suggestions</strong>
            <p>Highlight this tag at the top of client search screens</p>
          </div>
          <PPSwitch v-model="tagForm.isFeatured" />
        </div>

        <!-- Rich Text Description -->
        <div class="form-group">
          <label>Tag Scope & Guidelines</label>
          <RichTextEditor
            v-model="tagForm.description"
            placeholder="Explain the criteria and usage for this tag..."
            min-height="90px"
          />
        </div>

        <div class="modal-footer">
          <PPButton type="button" variant="outline" size="small" @click="emit('close')">
            <span>Cancel</span>
          </PPButton>
          <PPButton type="submit" variant="primary" size="small">
            <span>{{ isEditing ? 'Save Tag Changes' : 'Create & Publish Tag' }}</span>
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
  background: rgba(0, 0, 0, 0.75);
  backdrop-filter: blur(8px);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 100;
  padding: 20px;
}

.modal-card {
  width: 100%;
  max-width: 600px;
  max-height: 90vh;
  overflow-y: auto;
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 18px;
  padding: 28px;
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

.icon-selector-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 8px;
}

.icon-select-btn {
  display: flex;
  align-items: center;
  gap: 8px;
  background: #0f172a;
  border: 1px solid #1f2937;
  padding: 8px 10px;
  border-radius: 8px;
  color: #94a3b8;
  font-size: 12px;
  cursor: pointer;
  transition: all 0.2s;
}

.icon-select-btn:hover {
  background: #1e293b;
  color: #fff;
}

.icon-select-btn.active {
  border-color: #3b82f6;
  background: rgba(59, 130, 246, 0.15);
  color: #60a5fa;
  font-weight: 600;
}

.color-palette-row {
  display: flex;
  align-items: center;
  gap: 16px;
}

.color-preview-tag {
  padding: 6px 12px;
  border-radius: 8px;
  border: 1px solid;
  font-size: 13px;
  font-weight: 600;
  background: #0f172a;
}

.color-circles {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}

.color-circle {
  width: 22px;
  height: 22px;
  border-radius: 50%;
  cursor: pointer;
  border: 2px solid transparent;
  transition: transform 0.2s;
}

.color-circle:hover {
  transform: scale(1.15);
}

.color-circle.active {
  border-color: #fff;
  transform: scale(1.2);
}

.toggle-box {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background: #0f172a;
  border: 1px solid #1f2937;
  padding: 14px 16px;
  border-radius: 12px;
}

.toggle-box strong {
  display: block;
  font-size: 13px;
  color: #fff;
}

.toggle-box p {
  font-size: 11px;
  color: #94a3b8;
  margin-top: 2px;
}

.modal-footer {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  margin-top: 10px;
  padding-top: 16px;
  border-top: 1px solid #1f2937;
}
</style>
