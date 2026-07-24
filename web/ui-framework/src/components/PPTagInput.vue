<template>
  <div class="pp-tag-input" :class="{ 'is-focused': isFocused }">
    <div class="tags-wrapper">
      <div v-for="(tag, index) in tags" :key="index" class="tag-chip">
        <span>{{ tag }}</span>
        <button class="remove-btn" @click="removeTag(index)">&times;</button>
      </div>
      <input
        type="text"
        v-model="inputValue"
        :placeholder="tags.length === 0 ? placeholder : ''"
        @keydown.enter.prevent="addTag"
        @keydown.backspace="removeLastTag"
        @focus="isFocused = true"
        @blur="isFocused = false"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';

const props = withDefaults(defineProps<{
  modelValue?: string[];
  placeholder?: string;
}>(), {
  modelValue: () => [],
  placeholder: 'Type and press Enter...'
});

const emit = defineEmits<{
  (e: 'update:modelValue', val: string[]): void;
}>();

const tags = ref<string[]>([...props.modelValue]);
const inputValue = ref('');
const isFocused = ref(false);

watch(() => props.modelValue, (newVal) => {
  if (JSON.stringify(newVal) !== JSON.stringify(tags.value)) {
    tags.value = [...newVal];
  }
});

const addTag = () => {
  const val = inputValue.value.trim();
  if (val && !tags.value.includes(val)) {
    tags.value.push(val);
    emit('update:modelValue', tags.value);
    inputValue.value = '';
  }
};

const removeTag = (index: number) => {
  tags.value.splice(index, 1);
  emit('update:modelValue', tags.value);
};

const removeLastTag = () => {
  if (inputValue.value === '' && tags.value.length > 0) {
    tags.value.pop();
    emit('update:modelValue', tags.value);
  }
};
</script>

<style scoped>
.pp-tag-input {
  border: 1px solid #cbd5e1;
  border-radius: 8px;
  padding: 8px 12px;
  background: white;
  transition: all 0.2s;
  min-height: 48px;
  cursor: text;
}
.pp-tag-input.is-focused {
  border-color: #3b82f6;
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

.tags-wrapper {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  align-items: center;
}

.tag-chip {
  background: #f1f5f9;
  color: #334155;
  font-size: 13px;
  font-weight: 500;
  padding: 4px 8px 4px 12px;
  border-radius: 16px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.remove-btn {
  background: transparent;
  border: none;
  cursor: pointer;
  color: #94a3b8;
  font-size: 16px;
  line-height: 1;
  padding: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 16px;
  height: 16px;
  border-radius: 50%;
  transition: all 0.2s;
}

.remove-btn:hover {
  background: #cbd5e1;
  color: #334155;
}

input {
  border: none;
  outline: none;
  background: transparent;
  font-size: 14px;
  color: #334155;
  flex: 1;
  min-width: 120px;
  padding: 4px 0;
}
</style>
