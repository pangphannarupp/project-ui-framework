<template>
  <div class="biz-app-bar" :class="{ 'has-bottom': $slots.bottom }">
    <div class="app-bar-top">
      <div class="app-bar-left">
        <slot name="left"></slot>
      </div>
      <div class="app-bar-center">
        <slot name="center">
          <h1 v-if="title" class="app-bar-title">{{ title }}</h1>
        </slot>
      </div>
      <div class="app-bar-right">
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
.biz-app-bar {
  background-color: var(--biz-app-bar-bg, #0b33a2);
  color: var(--biz-app-bar-color, white);
  padding-top: var(--biz-app-bar-pt, env(safe-area-inset-top, 0px));
  width: 100%;
  position: relative;
  z-index: 10;
}

/* Optional border radius at the bottom like some screens */
.biz-app-bar.has-bottom {
  border-bottom-left-radius: var(--biz-app-bar-radius, 24px);
  border-bottom-right-radius: var(--biz-app-bar-radius, 24px);
  padding-bottom: var(--biz-app-bar-pb, 16px);
}

.app-bar-top {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: var(--biz-app-bar-height, 56px);
  padding: 0 16px;
}

.app-bar-left, .app-bar-right {
  display: flex;
  align-items: center;
  min-width: 40px; /* Ensure space even if empty */
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
  font-size: var(--biz-app-bar-title-size, 18px);
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
