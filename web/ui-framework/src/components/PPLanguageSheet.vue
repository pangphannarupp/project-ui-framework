<template>
  <PPBottomSheet :modelValue="modelValue" @update:modelValue="$emit('update:modelValue', $event)">
    <div class="lang-sheet-content">
      <div class="lang-header">
        <h2 class="lang-title">Please Select Your Language</h2>
        <p class="lang-subtitle">Choose the language and region you want to use in smartBiz app</p>
      </div>

      <div class="lang-list">
        <div 
          v-for="lang in languages" 
          :key="lang.code"
          class="lang-item"
          :class="{ 'is-active': modelValueLang === lang.code }"
          @click="selectLanguage(lang.code)"
        >
          <div class="lang-left">
            <div class="lang-flag">{{ lang.flag }}</div>
            <span class="lang-name">{{ lang.name }}</span>
          </div>
          <div class="lang-radio">
            <div class="radio-inner" v-if="modelValueLang === lang.code"></div>
          </div>
        </div>
      </div>
    </div>
  </PPBottomSheet>
</template>

<script setup lang="ts">
import PPBottomSheet from './PPBottomSheet.vue';

defineProps({
  modelValue: {
    type: Boolean,
    default: false
  },
  modelValueLang: {
    type: String,
    default: 'en'
  }
});

const emit = defineEmits(['update:modelValue', 'update:modelValueLang', 'change']);

const languages = [
  { code: 'km', name: 'ភាសាខ្មែរ', flag: '🇰🇭' },
  { code: 'en', name: 'English', flag: '🇬🇧' },
  { code: 'ko', name: '한국어', flag: '🇰🇷' },
  { code: 'ja', name: '日本語', flag: '🇯🇵' },
  { code: 'zh', name: '漢語', flag: '🇨🇳' }
];

const selectLanguage = (code: string) => {
  emit('update:modelValueLang', code);
  emit('change', code);
  // close sheet
  setTimeout(() => {
    emit('update:modelValue', false);
  }, 200);
};
</script>

<style scoped>
.lang-sheet-content {
  padding: 16px 24px 32px 24px;
}

.lang-header {
  margin-bottom: 24px;
}

.lang-title {
  font-size: 16px;
  font-weight: 700;
  color: var(--pp-primary-variant, #1a2a5e);
  margin: 0 0 8px 0;
}

.lang-subtitle {
  font-size: 12px;
  color: #555;
  margin: 0;
  line-height: 1.4;
}

.lang-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.lang-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px 16px;
  border-radius: 12px;
  border: 1.5px solid #eaeaea;
  background: white;
  cursor: pointer;
  transition: all 0.2s;
}

.lang-item.is-active {
  border-color: var(--pp-primary-variant, #1a2a5e);
}

.lang-left {
  display: flex;
  align-items: center;
  gap: 12px;
}

.lang-flag {
  font-size: 20px;
  line-height: 1;
  width: 24px;
  height: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.lang-name {
  font-size: 14px;
  font-weight: 600;
  color: #111;
}

.lang-radio {
  width: 20px;
  height: 20px;
  border-radius: 50%;
  border: 2px solid #eaeaea;
  display: flex;
  align-items: center;
  justify-content: center;
}

.lang-item.is-active .lang-radio {
  border-color: var(--pp-primary-variant, #1a2a5e);
}

.radio-inner {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background-color: var(--pp-primary-variant, #1a2a5e);
}
</style>
