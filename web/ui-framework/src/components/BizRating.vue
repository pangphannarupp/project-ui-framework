<template>
  <div 
    class="biz-rating"
    :class="{ 'biz-rating--readonly': readonly }"
    @mouseleave="hoverValue = 0"
  >
    <button
      v-for="star in max"
      :key="star"
      type="button"
      class="biz-rating-star"
      :class="{ 'biz-rating-star--active': star <= displayValue }"
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
.biz-rating {
  display: inline-flex;
  align-items: center;
  gap: 4px;
}

.biz-rating-star {
  background: transparent;
  border: none;
  padding: 0;
  margin: 0;
  cursor: pointer;
  color: #e0e0e0;
  transition: all 0.2s ease;
}

.biz-rating-star svg {
  fill: transparent;
  transition: all 0.2s ease;
}

.biz-rating-star--active {
  color: #ffc107;
}
.biz-rating-star--active svg {
  fill: #ffc107;
}

.biz-rating:not(.biz-rating--readonly) .biz-rating-star:hover {
  transform: scale(1.15);
}

.biz-rating--readonly .biz-rating-star {
  cursor: default;
}
</style>
