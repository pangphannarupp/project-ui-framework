<template>
  <div 
    class="pp-header-bar" 
    :class="[
      `theme-${theme}`, 
      { 'is-fixed': fixed, 'is-bordered': bordered }
    ]"
    :style="{ height: height }"
  >
    <!-- Left Section (Logo / Sidebar Toggle) -->
    <div class="header-left">
      <slot name="left"></slot>
    </div>

    <!-- Center Section (Title / Search) -->
    <div class="header-center">
      <slot name="center"></slot>
    </div>

    <!-- Right Section (Profile / Actions) -->
    <div class="header-right">
      <slot name="right"></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
withDefaults(defineProps<{
  theme?: 'light' | 'dark' | 'transparent';
  fixed?: boolean;
  height?: string;
  bordered?: boolean;
}>(), {
  theme: 'light',
  fixed: false,
  height: '64px',
  bordered: true
});
</script>

<style scoped>
.pp-header-bar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 24px;
  width: 100%;
  box-sizing: border-box;
  transition: background-color 0.3s ease, border-color 0.3s ease;
  z-index: 100;
}

.pp-header-bar.is-fixed {
  position: sticky;
  top: 0;
}

.pp-header-bar.is-bordered {
  border-bottom: 1px solid var(--header-border, #e2e8f0);
}

.header-left {
  display: flex;
  align-items: center;
  gap: 16px;
  flex: 1;
}

.header-center {
  display: flex;
  align-items: center;
  justify-content: center;
  flex: 2;
}

.header-right {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  gap: 16px;
  flex: 1;
}

/* Themes */
.theme-light {
  background-color: #ffffff;
  color: #1e293b;
  --header-border: #e2e8f0;
}

.theme-dark {
  background-color: #1e293b;
  color: #f8fafc;
  --header-border: #334155;
}

.theme-transparent {
  background-color: transparent;
  color: inherit;
  --header-border: transparent;
}

/* Responsiveness */
@media (max-width: 768px) {
  .pp-header-bar {
    padding: 0 16px;
  }
  .header-center {
    display: none; /* Often center is hidden on mobile in favor of a search icon on right */
  }
}
</style>
