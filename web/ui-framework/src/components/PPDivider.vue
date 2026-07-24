<template>
  <div 
    class="pp-divider"
    :class="[
      `variant-${variant}`, 
      `orientation-${orientation}`,
      `align-${align}`,
      { 'has-content': $slots.default }
    ]"
    :style="customStyle"
  >
    <div v-if="$slots.default && orientation === 'horizontal'" class="divider-content">
      <slot></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

const props = withDefaults(defineProps<{
  variant?: 'solid' | 'dashed' | 'dotted';
  orientation?: 'horizontal' | 'vertical';
  align?: 'left' | 'center' | 'right';
  color?: string;
  margin?: string;
}>(), {
  variant: 'solid',
  orientation: 'horizontal',
  align: 'center'
});

const customStyle = computed(() => {
  const styles: any = {};
  
  if (props.color) {
    styles.borderColor = props.color;
    styles.color = props.color;
  }
  
  if (props.margin) {
    if (props.orientation === 'horizontal') {
      styles.margin = `${props.margin} 0`;
    } else {
      styles.margin = `0 ${props.margin}`;
    }
  }
  
  return styles;
});
</script>

<style scoped>
.pp-divider {
  display: flex;
  align-items: center;
  color: #64748b;
  border-color: #e2e8f0;
  box-sizing: border-box;
}

/* Horizontal */
.pp-divider.orientation-horizontal {
  width: 100%;
  margin: 16px 0;
}

.pp-divider.orientation-horizontal:not(.has-content) {
  border-top-width: 1px;
}

.pp-divider.orientation-horizontal.has-content::before,
.pp-divider.orientation-horizontal.has-content::after {
  content: '';
  flex: 1;
  border-top-width: 1px;
  border-top-style: inherit;
  border-top-color: inherit;
}

.divider-content {
  padding: 0 16px;
  font-size: 14px;
  font-weight: 500;
  white-space: nowrap;
}

/* Horizontal Alignments */
.pp-divider.orientation-horizontal.align-left::before { flex: 0.1; }
.pp-divider.orientation-horizontal.align-right::after { flex: 0.1; }

/* Vertical */
.pp-divider.orientation-vertical {
  display: inline-block;
  height: 1em;
  margin: 0 8px;
  border-left-width: 1px;
  vertical-align: middle;
}

/* Variants */
.pp-divider.variant-solid {
  border-style: solid;
}
.pp-divider.variant-dashed {
  border-style: dashed;
}
.pp-divider.variant-dotted {
  border-style: dotted;
}
</style>
