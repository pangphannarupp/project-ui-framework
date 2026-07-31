<template>
  <div 
    class="pp-scroll-area"
    :class="[
      `is-${direction}`,
      `scrollbar-${scrollbar}`,
      { 'hide-scrollbar': hideScrollbar || scrollbar === 'none' }
    ]"
  >
    <div class="pp-scroll-area__content">
      <slot></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
withDefaults(defineProps<{
  direction?: 'horizontal' | 'vertical' | 'both';
  hideScrollbar?: boolean;
  scrollbar?: 'default' | 'thin' | 'mac' | 'none';
}>(), {
  direction: 'vertical',
  hideScrollbar: false,
  scrollbar: 'default'
});
</script>

<style scoped>
.pp-scroll-area {
  position: relative;
  width: 100%;
  height: 100%;
}

.pp-scroll-area__content {
  display: flex;
  width: 100%;
  height: 100%;
}

.is-vertical {
  overflow-y: auto;
  overflow-x: hidden;
}
.is-vertical > .pp-scroll-area__content {
  flex-direction: column;
}

.is-horizontal {
  overflow-x: auto;
  overflow-y: hidden;
}
.is-horizontal > .pp-scroll-area__content {
  flex-direction: row;
  flex-wrap: nowrap;
}

.is-both {
  overflow: auto;
}

/* Scrollbar hiding */
.hide-scrollbar::-webkit-scrollbar {
  display: none;
}
.hide-scrollbar {
  -ms-overflow-style: none;
  scrollbar-width: none;
}

/* Default custom scrollbar */
.scrollbar-default::-webkit-scrollbar {
  width: 6px;
  height: 6px;
}
.scrollbar-default::-webkit-scrollbar-track {
  background: transparent;
}
.scrollbar-default::-webkit-scrollbar-thumb {
  background-color: #d1d5db;
  border-radius: 20px;
}
.scrollbar-default::-webkit-scrollbar-thumb:hover {
  background-color: #9ca3af;
}

/* Thin variant */
.scrollbar-thin::-webkit-scrollbar {
  width: 2px;
  height: 2px;
}
.scrollbar-thin::-webkit-scrollbar-track {
  background: transparent;
}
.scrollbar-thin::-webkit-scrollbar-thumb {
  background-color: rgba(0,0,0,0.2);
}
.scrollbar-thin::-webkit-scrollbar-thumb:hover {
  background-color: rgba(0,0,0,0.4);
}

/* Mac-like variant */
.scrollbar-mac::-webkit-scrollbar {
  width: 10px;
  height: 10px;
}
.scrollbar-mac::-webkit-scrollbar-track {
  background: transparent;
  border-left: 1px solid #f3f4f6;
}
.scrollbar-mac::-webkit-scrollbar-thumb {
  background-color: rgba(0,0,0,0.15);
  border-radius: 10px;
  border: 2px solid transparent;
  background-clip: padding-box;
}
.scrollbar-mac::-webkit-scrollbar-thumb:hover {
  background-color: rgba(0,0,0,0.3);
}
</style>
