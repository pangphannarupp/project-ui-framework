<template>
  <div class="pp-app-bar" :class="{ 'has-bottom': $slots.bottom }">
    <div class="app-bar-top">
      <div class="app-bar-left" v-if="$slots.left">
        <slot name="left"></slot>
      </div>
      <div class="app-bar-center">
        <slot name="center">
          <h1 v-if="title" class="app-bar-title">{{ title }}</h1>
        </slot>
      </div>
      <div class="app-bar-right" v-if="$slots.right">
        <slot name="right"></slot>
      </div>
    </div>
    <div class="app-bar-bottom" v-if="$slots.bottom">
      <slot name="bottom"></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps({
  title: {
    type: String,
    default: ''
  }
});
</script>

<style scoped>
.pp-app-bar {
  background-color: var(--pp-app-bar-bg, #0b33a2);
  color: var(--pp-app-bar-color, white);
  padding-top: var(--pp-app-bar-pt, env(safe-area-inset-top, 0px));
  width: 100%;
  position: relative;
  z-index: 10;
}

/* Optional border radius at the bottom like some screens */
.pp-app-bar.has-bottom {
  border-bottom-left-radius: var(--pp-app-bar-radius, 24px);
  border-bottom-right-radius: var(--pp-app-bar-radius, 24px);
  padding-bottom: var(--pp-app-bar-pb, 16px);
}

.app-bar-top {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: var(--pp-app-bar-height, 56px);
  padding: 0 16px;
}

.app-bar-left, .app-bar-right {
  display: flex;
  align-items: center;
}

.app-bar-right {
  justify-content: flex-end;
}

.app-bar-center {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
}

.app-bar-title {
  margin: 0;
  font-size: var(--pp-app-bar-title-size, 18px);
  font-weight: 700;
  color: inherit;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.app-bar-bottom {
  padding: 0 16px;
  /* Additional bottom content spacing */
}

:deep(.app-bar-left svg),
:deep(.app-bar-right svg) {
  width: 24px;
  height: 24px;
  color: inherit;
}
</style>
