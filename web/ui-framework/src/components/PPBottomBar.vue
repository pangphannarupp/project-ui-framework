<template>
  <div 
    class="pp-bottom-bar"
    :class="[
      `align-${align}`, 
      `theme-${theme}`,
      { 'is-fixed': fixed, 'is-bordered': bordered }
    ]"
  >
    <div v-if="$slots.left" class="bottom-bar-left">
      <slot name="left"></slot>
    </div>
    
    <div class="bottom-bar-main">
      <slot></slot>
    </div>
    
    <div v-if="$slots.right" class="bottom-bar-right">
      <slot name="right"></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
withDefaults(defineProps<{
  theme?: 'light' | 'dark' | 'transparent';
  fixed?: boolean;
  bordered?: boolean;
  align?: 'left' | 'center' | 'right' | 'space-between';
}>(), {
  theme: 'light',
  fixed: true,
  bordered: true,
  align: 'right'
});
</script>

<style scoped>
.pp-bottom-bar {
  display: flex;
  align-items: center;
  padding: 12px 24px;
  width: 100%;
  box-sizing: border-box;
  transition: background-color 0.3s ease, border-color 0.3s ease;
  z-index: 90;
  min-height: 64px;
  gap: 16px;
}

.pp-bottom-bar.is-fixed {
  position: sticky;
  bottom: 0;
  left: 0;
  right: 0;
}

.pp-bottom-bar.is-bordered {
  border-top: 1px solid var(--bottom-bar-border, #e2e8f0);
}

/* Alignments for main default slot when left/right slots are empty */
.pp-bottom-bar.align-left .bottom-bar-main {
  justify-content: flex-start;
}
.pp-bottom-bar.align-center .bottom-bar-main {
  justify-content: center;
}
.pp-bottom-bar.align-right .bottom-bar-main {
  justify-content: flex-end;
}
.pp-bottom-bar.align-space-between .bottom-bar-main {
  justify-content: space-between;
}

.bottom-bar-left {
  display: flex;
  align-items: center;
  gap: 12px;
}

.bottom-bar-main {
  display: flex;
  align-items: center;
  flex: 1;
  gap: 12px;
}

.bottom-bar-right {
  display: flex;
  align-items: center;
  gap: 12px;
}

/* Themes */
.theme-light {
  background-color: #ffffff;
  color: #1e293b;
  --bottom-bar-border: #e2e8f0;
}

.theme-dark {
  background-color: #1e293b;
  color: #f8fafc;
  --bottom-bar-border: #334155;
}

.theme-transparent {
  background-color: transparent;
  color: inherit;
  --bottom-bar-border: transparent;
}

/* Responsiveness */
@media (max-width: 768px) {
  .pp-bottom-bar {
    padding: 12px 16px;
    flex-wrap: wrap;
  }
}
</style>
