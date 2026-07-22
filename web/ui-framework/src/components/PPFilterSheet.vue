<template>
  <PPBottomSheet :modelValue="modelValue" @update:modelValue="$emit('update:modelValue', $event)">
    <div class="filter-sheet-content">
      <div class="sheet-header">
        <h2 class="sheet-title">Filter</h2>
        <p class="sheet-subtitle">Search branch you wish to visit faster.</p>
      </div>

      <div class="filter-section">
        <h3 class="section-title">BRANCH FACILITY</h3>
        <div class="chip-group">
          <button 
            v-for="facility in facilities" 
            :key="facility"
            class="filter-chip"
            :class="{ active: selectedFacilities.includes(facility) }"
            @click="toggleFacility(facility)"
          >
            {{ facility }}
          </button>
        </div>
      </div>

      <div class="action-area">
        <PPButton variant="primary" block @click="applyFilters">Apply</PPButton>
        <button class="outline-btn" @click="$emit('update:modelValue', false)">Close</button>
      </div>
    </div>
  </PPBottomSheet>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import PPBottomSheet from './PPBottomSheet.vue';
import PPButton from './PPButton.vue';

const props = defineProps({
  modelValue: {
    type: Boolean,
    default: false
  },
  modelValueFacilities: {
    type: Array,
    default: () => []
  }
});

const emit = defineEmits(['update:modelValue', 'update:modelValueFacilities', 'apply']);

const facilities = ['Korea Desk', 'Japan Desk', 'China Desk', 'SME Center', 'Coffee'];
const selectedFacilities = ref<string[]>([]);

watch(() => props.modelValue, (newVal) => {
  if (newVal) {
    selectedFacilities.value = [...props.modelValueFacilities as string[]];
  }
});

const toggleFacility = (facility: string) => {
  const index = selectedFacilities.value.indexOf(facility);
  if (index > -1) {
    selectedFacilities.value.splice(index, 1);
  } else {
    selectedFacilities.value.push(facility);
  }
};

const applyFilters = () => {
  emit('update:modelValueFacilities', selectedFacilities.value);
  emit('apply', selectedFacilities.value);
  emit('update:modelValue', false);
};
</script>

<style scoped>
.filter-sheet-content {
  padding: 8px 24px 32px 24px;
  display: flex;
  flex-direction: column;
}

.sheet-header {
  margin-bottom: 24px;
}

.sheet-title {
  font-size: 20px;
  font-weight: 700;
  color: var(--pp-primary-variant, #1a2a5e);
  margin: 0 0 8px 0;
}

.sheet-subtitle {
  font-size: 14px;
  color: #555;
  margin: 0;
}

.filter-section {
  margin-bottom: 32px;
}

.section-title {
  font-size: 12px;
  font-weight: 700;
  color: var(--pp-primary-variant, #1a2a5e);
  margin: 0 0 16px 0;
  letter-spacing: 0.5px;
}

.chip-group {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
}

.filter-chip {
  padding: 10px 16px;
  border-radius: 20px;
  background-color: white;
  border: 1px solid #eaeaea;
  color: #111;
  font-size: 13px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s;
}

.filter-chip.active {
  background-color: var(--pp-primary-variant, #1a2a5e);
  border-color: var(--pp-primary-variant, #1a2a5e);
  color: white;
}

.action-area {
  display: flex;
  flex-direction: column;
  gap: 12px;
  margin-top: auto;
}

.outline-btn {
  background-color: white;
  border: 1px solid #eaeaea;
  color: var(--pp-primary-variant, #1a2a5e);
  font-size: 15px;
  font-weight: 600;
  padding: 14px;
  border-radius: 12px;
  width: 100%;
  cursor: pointer;
}
</style>
