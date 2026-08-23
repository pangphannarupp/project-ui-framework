<script setup lang="ts">
import RichTextEditor from '../RichTextEditor.vue'

defineProps<{
  show: boolean
  isEditing: boolean
  availableColors: string[]
  categoryForm: {
    name: string
    slug: string
    color: string
    order: number
    description: string
    status: 'active' | 'inactive'
  }
}>()

const emit = defineEmits<{
  (e: 'close'): void
  (e: 'submit'): void
}>()
</script>

<template>
  <div v-if="show" class="modal-backdrop">
    <div class="modal-card glass-panel">
      <div class="modal-header">
        <div>
          <h3>{{ isEditing ? 'Edit Category' : 'Register New Category' }}</h3>
          <p class="modal-subtitle">Manage category classification metadata for discovery</p>
        </div>
        <button @click="emit('close')" class="close-btn">✕</button>
      </div>

      <form @submit.prevent="emit('submit')" class="modal-form">
        <div class="form-row">
          <div class="form-group flex-2">
            <label>Category Name <span class="required">*</span></label>
            <PPInput
              v-model="categoryForm.name"
              placeholder="e.g. Health & Wellness"
              required
            />
          </div>
          <div class="form-group flex-1">
            <label>Display Order</label>
            <PPInput
              type="number"
              v-model="categoryForm.order"
              placeholder="1"
              required
            />
          </div>
        </div>

        <div class="form-group">
          <label>URL Slug / Identifier</label>
          <PPInput
            v-model="categoryForm.slug"
            placeholder="e.g. health-wellness (leave empty to auto-generate)"
          />
        </div>

        <!-- Color Picker -->
        <div class="form-group">
          <label>Theme Brand Color</label>
          <div class="color-selector">
            <button
              type="button"
              v-for="c in availableColors"
              :key="c"
              class="color-dot"
              :style="{ backgroundColor: c }"
              :class="{ selected: categoryForm.color === c }"
              @click="categoryForm.color = c"
            >
              <span v-if="categoryForm.color === c">✓</span>
            </button>
            <input type="color" v-model="categoryForm.color" class="custom-color-input" title="Custom color" />
          </div>
        </div>

        <div class="form-group">
          <label>Category Description</label>
          <RichTextEditor
            v-model="categoryForm.description"
            placeholder="Brief summary of applications grouped under this category..."
            min-height="100px"
          />
        </div>

        <div class="form-group">
          <label>Status</label>
          <div class="radio-status-group">
            <label class="radio-card" :class="{ selected: categoryForm.status === 'active' }">
              <input type="radio" value="active" v-model="categoryForm.status" />
              <div>
                <strong>Active</strong>
                <small>Visible in client app directory</small>
              </div>
            </label>
            <label class="radio-card" :class="{ selected: categoryForm.status === 'inactive' }">
              <input type="radio" value="inactive" v-model="categoryForm.status" />
              <div>
                <strong>Inactive</strong>
                <small>Hidden from public navigation</small>
              </div>
            </label>
          </div>
        </div>

        <div class="modal-footer">
          <PPButton type="button" variant="outline" size="small" @click="emit('close')">
            <span>Cancel</span>
          </PPButton>
          <PPButton type="submit" variant="primary" size="small">
            <span>{{ isEditing ? 'Update Category' : 'Save & Publish' }}</span>
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

.color-selector {
  display: flex;
  gap: 8px;
  align-items: center;
  flex-wrap: wrap;
}

.color-dot {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  border: 2px solid transparent;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  font-size: 14px;
}

.color-dot.selected {
  border-color: #fff;
  transform: scale(1.1);
}

.custom-color-input {
  width: 32px;
  height: 32px;
  border: none;
  background: transparent;
  cursor: pointer;
}

.radio-status-group {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
}

.radio-card {
  display: flex;
  align-items: center;
  gap: 12px;
  background: #0f172a;
  border: 1px solid #1f2937;
  padding: 12px 14px;
  border-radius: 10px;
  cursor: pointer;
}

.radio-card.selected {
  border-color: #3b82f6;
  background: rgba(59, 130, 246, 0.1);
}

.radio-card strong {
  display: block;
  font-size: 13px;
  color: #fff;
}

.radio-card small {
  font-size: 11px;
  color: #94a3b8;
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
