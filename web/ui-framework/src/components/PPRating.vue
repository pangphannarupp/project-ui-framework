<template>
  <div 
    class="pp-rating"
    :class="{ 'pp-rating--readonly': readonly }"
    @mouseleave="hoverValue = 0"
  >
    <button
      v-for="star in max"
      :key="star"
      type="button"
      class="pp-rating-star"
      :class="{ 'pp-rating-star--active': star <= displayValue }"
      :disabled="readonly"
      @click="!readonly && updateValue(star)"
      @mouseenter="!readonly && (hoverValue = star)"
    >
      <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
        <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
      </svg>
    </button>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const props = withDefaults(defineProps<{
  modelValue?: number;
  max?: number;
  readonly?: boolean;
}>(), {
  modelValue: 0,
  max: 5,
  readonly: false
});

const emit = defineEmits(['update:modelValue', 'change']);

const hoverValue = ref(0);

const displayValue = computed(() => {
  return hoverValue.value > 0 ? hoverValue.value : props.modelValue;
});

const updateValue = (val: number) => {
  emit('update:modelValue', val);
  emit('change', val);
};
</script>

<style scoped>
.pp-rating {
  display: inline-flex;
  align-items: center;
  gap: 4px;
}

.pp-rating-star {
  background: transparent;
  border: none;
  padding: 0;
  margin: 0;
  cursor: pointer;
  color: #e0e0e0;
  transition: all 0.2s ease;
}

.pp-rating-star svg {
  fill: transparent;
  transition: all 0.2s ease;
}

.pp-rating-star--active {
  color: #ffc107;
}
.pp-rating-star--active svg {
  fill: #ffc107;
}

.pp-rating:not(.pp-rating--readonly) .pp-rating-star:hover {
  transform: scale(1.15);
}

.pp-rating--readonly .pp-rating-star {
  cursor: default;
}
</style>
