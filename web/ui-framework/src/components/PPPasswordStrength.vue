<template>
  <div class="pp-password-strength">
    <div class="input-wrapper" :class="{ 'is-focused': isFocused }">
      <input 
        :type="showPassword ? 'text' : 'password'"
        v-model="password"
        placeholder="Enter your password"
        @focus="isFocused = true"
        @blur="isFocused = false"
      />
      <button class="toggle-btn" @click.prevent="showPassword = !showPassword">
        {{ showPassword ? 'Hide' : 'Show' }}
      </button>
    </div>

    <div class="strength-meter">
      <div class="meter-bar">
        <div class="meter-fill" :class="strengthClass" :style="{ width: `${(score / 4) * 100}%` }"></div>
      </div>
      <div class="strength-text" :class="strengthClass">{{ strengthLabel }}</div>
    </div>

    <ul class="rules-list">
      <li :class="{ passed: rules.length }">
        <span class="icon">{{ rules.length ? '✓' : '○' }}</span> 8+ Characters
      </li>
      <li :class="{ passed: rules.upper }">
        <span class="icon">{{ rules.upper ? '✓' : '○' }}</span> Uppercase Letter
      </li>
      <li :class="{ passed: rules.number }">
        <span class="icon">{{ rules.number ? '✓' : '○' }}</span> Number
      </li>
      <li :class="{ passed: rules.special }">
        <span class="icon">{{ rules.special ? '✓' : '○' }}</span> Special Character
      </li>
    </ul>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch } from 'vue';

const props = defineProps<{
  modelValue?: string;
}>();

const emit = defineEmits<{
  (e: 'update:modelValue', val: string): void;
}>();

const password = ref(props.modelValue || '');
const isFocused = ref(false);
const showPassword = ref(false);

watch(password, (val) => {
  emit('update:modelValue', val);
});

watch(() => props.modelValue, (val) => {
  if (val !== undefined && val !== password.value) {
    password.value = val;
  }
});

const rules = computed(() => {
  const p = password.value;
  return {
    length: p.length >= 8,
    upper: /[A-Z]/.test(p),
    number: /[0-9]/.test(p),
    special: /[^A-Za-z0-9]/.test(p)
  };
});

const score = computed(() => {
  return Object.values(rules.value).filter(Boolean).length;
});

const strengthClass = computed(() => {
  if (score.value <= 1) return 'weak';
  if (score.value <= 3) return 'fair';
  return 'strong';
});

const strengthLabel = computed(() => {
  if (password.value.length === 0) return '';
  if (score.value <= 1) return 'Weak';
  if (score.value <= 3) return 'Fair';
  return 'Strong';
});
</script>

<style scoped>
.pp-password-strength {
  width: 100%;
}

.input-wrapper {
  display: flex;
  align-items: center;
  border: 1px solid #cbd5e1;
  border-radius: 8px;
  background: white;
  padding: 0 12px;
  transition: all 0.2s;
  height: 48px;
}

.input-wrapper.is-focused {
  border-color: #3b82f6;
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

input {
  flex: 1;
  border: none;
  outline: none;
  background: transparent;
  font-size: 14px;
  color: #334155;
  height: 100%;
}

.toggle-btn {
  background: transparent;
  border: none;
  color: #64748b;
  font-size: 12px;
  font-weight: 600;
  cursor: pointer;
  padding: 4px 8px;
  border-radius: 4px;
}
.toggle-btn:hover {
  background: #f1f5f9;
  color: #334155;
}

.strength-meter {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-top: 12px;
  margin-bottom: 16px;
}

.meter-bar {
  flex: 1;
  height: 6px;
  background: #e2e8f0;
  border-radius: 3px;
  overflow: hidden;
}

.meter-fill {
  height: 100%;
  width: 0%;
  transition: all 0.3s ease;
}

.meter-fill.weak { background: #ef4444; }
.meter-fill.fair { background: #f59e0b; }
.meter-fill.strong { background: #22c55e; }

.strength-text {
  font-size: 12px;
  font-weight: 700;
  width: 45px;
  text-align: right;
}
.strength-text.weak { color: #ef4444; }
.strength-text.fair { color: #f59e0b; }
.strength-text.strong { color: #22c55e; }

.rules-list {
  list-style: none;
  padding: 0;
  margin: 0;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 8px;
}

.rules-list li {
  font-size: 12px;
  color: #94a3b8;
  display: flex;
  align-items: center;
  gap: 6px;
  transition: color 0.2s;
}

.rules-list li.passed {
  color: #22c55e;
}

.icon {
  font-size: 14px;
  line-height: 1;
}
</style>
