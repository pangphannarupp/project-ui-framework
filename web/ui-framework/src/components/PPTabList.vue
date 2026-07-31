<template>
  <div class="pp-tab-list-wrapper" :class="{ 'is-scrollable': scrollable }">
    <div class="pp-tab-list custom-scrollbar">
      <slot></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
withDefaults(defineProps<{
  scrollable?: boolean;
}>(), {
  scrollable: false
});
</script>

<style scoped>
.pp-tab-list-wrapper {
  position: relative;
  width: 100%;
}
.pp-tab-list {
  display: flex;
  align-items: center;
  width: 100%;
  gap: 8px;
}
.pp-tab-list-wrapper.is-scrollable .pp-tab-list {
  overflow-x: auto;
  flex-wrap: nowrap;
  -webkit-overflow-scrolling: touch;
  padding-bottom: 4px;
}
.pp-tab-list-wrapper:not(.is-scrollable) .pp-tab-list {
  flex-wrap: wrap;
}

/* Hide scrollbar for cleaner look if scrollable */
.custom-scrollbar::-webkit-scrollbar {
  display: none;
}
.custom-scrollbar {
  -ms-overflow-style: none;
  scrollbar-width: none;
}
</style>
