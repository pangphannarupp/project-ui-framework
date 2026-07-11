<template>
  <BizBottomSheet :modelValue="modelValue" @update:modelValue="$emit('update:modelValue', $event)">
    <div class="sort-sheet-content">
      <div class="sheet-header">
        <h2 class="sheet-title">Sort</h2>
        <p class="sheet-subtitle">More convenient to locate the branch you wish to visit.</p>
      </div>

      <div class="sort-options">
        <div 
          v-for="option in options" 
          :key="option.value"
          class="sort-option"
          :class="{ active: modelValueSort === option.value }"
          @click="selectSort(option.value)"
        >
          <span class="option-label">{{ option.label }}</span>
          <div class="radio-circle">
            <div class="radio-inner" v-if="modelValueSort === option.value"></div>
          </div>
        </div>
      </div>
    </div>
  </BizBottomSheet>
</template>

<script setup lang="ts">
import BizBottomSheet from './BizBottomSheet.vue';

defineProps({
  modelValue: {
    type: Boolean,
    default: false
  },
  modelValueSort: {
    type: String,
    default: 'distance' // 'distance', 'name'
  }
});

const emit = defineEmits(['update:modelValue', 'update:modelValueSort', 'change']);

const options = [
  { label: 'By Distance', value: 'distance' },
  { label: 'By Name', value: 'name' }
];

const selectSort = (value: string) => {
  emit('update:modelValueSort', value);
  emit('change', value);
  setTimeout(() => {
    emit('update:modelValue', false);
  }, 200);
};
</script>

<style scoped>
.sort-sheet-content {
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
  color: var(--biz-primary-variant, #1a2a5e);
  margin: 0 0 8px 0;
}

.sheet-subtitle {
  font-size: 14px;
  color: #555;
  margin: 0;
}

.sort-options {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.sort-option {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px 20px;
  border-radius: 12px;
  border: 1px solid #eaeaea;
  background-color: white;
  cursor: pointer;
  transition: all 0.2s;
}

.sort-option.active {
  border-color: var(--biz-primary-variant, #1a2a5e);
  border-width: 2px;
  padding: 15px 19px; /* adjust padding to compensate for thicker border */
}

.option-label {
  font-size: 15px;
  color: #111;
}

.sort-option.active .option-label {
  font-weight: 700;
}

.radio-circle {
  width: 22px;
  height: 22px;
  border-radius: 50%;
  border: 1.5px solid #eaeaea;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.2s;
}

.sort-option.active .radio-circle {
  border-color: var(--biz-primary-variant, #1a2a5e);
  border-width: 2.5px;
}

.radio-inner {
  width: 10px;
  height: 10px;
  background-color: var(--biz-primary-variant, #1a2a5e);
  border-radius: 50%;
}
</style>
