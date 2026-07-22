<template>
  <PPBottomSheet :modelValue="modelValue" @update:modelValue="$emit('update:modelValue', $event)">
    <div class="country-sheet-content">
      <div class="country-header">
        <h2 class="country-title">Select Your Country Code</h2>
      </div>

      <div class="country-search">
        <PPInput 
          v-model="searchQuery" 
          placeholder="Search" 
        >
          <template #iconLeft>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="search-icon"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
          </template>
        </PPInput>
      </div>

      <div class="country-segment">
        <PPSegment v-model="activeTab">
          <PPSegmentButton value="popular">Popular</PPSegmentButton>
          <PPSegmentButton value="all">All Country</PPSegmentButton>
        </PPSegment>
      </div>

      <div class="country-list">
        <div 
          v-for="country in filteredCountries" 
          :key="country.code"
          class="country-item"
          :class="{ 'is-active': modelValueCode === country.dialCode }"
          @click="selectCountry(country.dialCode)"
        >
          <span class="country-name">{{ country.name }} ({{ country.dialCode }})</span>
          <div class="country-radio">
            <div class="radio-inner" v-if="modelValueCode === country.dialCode"></div>
          </div>
        </div>
      </div>
    </div>
  </PPBottomSheet>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import PPBottomSheet from './PPBottomSheet.vue';
import PPInput from './PPInput.vue';
import PPSegment from './PPSegment.vue';
import PPSegmentButton from './PPSegmentButton.vue';

defineProps({
  modelValue: {
    type: Boolean,
    default: false
  },
  modelValueCode: {
    type: String,
    default: '+855'
  }
});

const emit = defineEmits(['update:modelValue', 'update:modelValueCode', 'change']);

const searchQuery = ref('');
const activeTab = ref('popular');

const popularCountries = [
  { code: 'KH', name: 'Cambodia', dialCode: '+855' },
  { code: 'KR', name: 'Republic of Korea', dialCode: '+82' },
  { code: 'CN', name: 'China', dialCode: '+86' },
  { code: 'JP', name: 'Japan', dialCode: '+81' }
];

const allCountries = [
  ...popularCountries,
  { code: 'US', name: 'United States', dialCode: '+1' },
  { code: 'GB', name: 'United Kingdom', dialCode: '+44' },
  { code: 'TH', name: 'Thailand', dialCode: '+66' },
  { code: 'VN', name: 'Vietnam', dialCode: '+84' },
  { code: 'SG', name: 'Singapore', dialCode: '+65' }
];

const filteredCountries = computed(() => {
  const list = activeTab.value === 'popular' ? popularCountries : allCountries;
  if (!searchQuery.value) return list;
  
  const query = searchQuery.value.toLowerCase();
  return list.filter(c => 
    c.name.toLowerCase().includes(query) || 
    c.dialCode.includes(query)
  );
});

const selectCountry = (dialCode: string) => {
  emit('update:modelValueCode', dialCode);
  emit('change', dialCode);
  setTimeout(() => {
    emit('update:modelValue', false);
  }, 200);
};
</script>

<style scoped>
.country-sheet-content {
  padding: 16px 24px 32px 24px;
  display: flex;
  flex-direction: column;
  max-height: 80vh;
}

.country-header {
  margin-bottom: 20px;
}

.country-title {
  font-size: 16px;
  font-weight: 700;
  color: var(--pp-primary-variant, #1a2a5e);
  margin: 0;
}

.country-search {
  margin-bottom: 16px;
}

.search-icon {
  width: 18px;
  height: 18px;
  color: #999;
}

.country-segment {
  margin-bottom: 16px;
}

.country-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
  overflow-y: auto;
  padding-bottom: 20px;
}

.country-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 14px 16px;
  border-radius: 12px;
  border: 1.5px solid #eaeaea;
  background: white;
  cursor: pointer;
  transition: all 0.2s;
}

.country-item.is-active {
  border-color: #0066cc;
}

.country-name {
  font-size: 14px;
  font-weight: 500;
  color: #111;
}

.country-item.is-active .country-name {
  color: #0066cc;
}

.country-radio {
  width: 20px;
  height: 20px;
  border-radius: 50%;
  border: 2px solid #eaeaea;
  display: flex;
  align-items: center;
  justify-content: center;
}

.country-item.is-active .country-radio {
  border-color: #0066cc;
}

.radio-inner {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background-color: #0066cc;
}
</style>
