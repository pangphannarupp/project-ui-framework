<template>
  <div 
    class="pp-button-group" 
    :class="[
      { 'pp-button-group--vertical': vertical },
      `pp-button-group--${variant}`
    ]"
  >
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
withDefaults(defineProps<{
  vertical?: boolean;
  variant?: 'connected' | 'segmented' | 'separated';
}>(), {
  vertical: false,
  variant: 'connected'
});
</script>

<style scoped>
.pp-button-group {
  display: inline-flex;
  align-items: center;
}

.pp-button-group--vertical {
  flex-direction: column;
  align-items: stretch;
}

/* -------------------------------------
   Connected Variant (Default)
-------------------------------------- */
/* Horizontal Connected */
.pp-button-group--connected:not(.pp-button-group--vertical) :deep(.pp-button) {
  border-radius: 0;
  margin-left: -1px; /* Avoid double borders for outline buttons */
}
.pp-button-group--connected:not(.pp-button-group--vertical) :deep(.pp-button:first-child) {
  border-top-left-radius: 12px;
  border-bottom-left-radius: 12px;
  margin-left: 0;
}
.pp-button-group--connected:not(.pp-button-group--vertical) :deep(.pp-button:last-child) {
  border-top-right-radius: 12px;
  border-bottom-right-radius: 12px;
}

/* Vertical Connected */
.pp-button-group--connected.pp-button-group--vertical :deep(.pp-button) {
  border-radius: 0;
  margin-top: -1px;
}
.pp-button-group--connected.pp-button-group--vertical :deep(.pp-button:first-child) {
  border-top-left-radius: 12px;
  border-top-right-radius: 12px;
  margin-top: 0;
}
.pp-button-group--connected.pp-button-group--vertical :deep(.pp-button:last-child) {
  border-bottom-left-radius: 12px;
  border-bottom-right-radius: 12px;
}

/* -------------------------------------
   Segmented Variant
-------------------------------------- */
.pp-button-group--segmented {
  background-color: #f1f5f9;
  padding: 4px;
  border-radius: 14px;
}
.pp-button-group--segmented :deep(.pp-button) {
  border-radius: 10px;
  background-color: transparent;
  color: #64748b;
  border-color: transparent;
  box-shadow: none;
  font-weight: 500;
}
.pp-button-group--segmented :deep(.pp-button:hover) {
  background-color: rgba(15, 23, 42, 0.05);
  color: #334155;
}
/* When a button is active/primary inside segmented */
.pp-button-group--segmented :deep(.pp-button.pp-button--primary),
.pp-button-group--segmented :deep(.pp-button.pp-button--elevated) {
  background-color: #ffffff;
  color: #0f172a;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1), 0 1px 2px rgba(0, 0, 0, 0.06);
}

.pp-button-group--segmented.pp-button-group--vertical {
  padding: 4px;
}

/* -------------------------------------
   Separated Variant
-------------------------------------- */
.pp-button-group--separated {
  gap: 8px;
}
/* Ensure normal border radiuses aren't overridden if they somehow clash */
.pp-button-group--separated :deep(.pp-button) {
  border-radius: 12px;
}

/* Hover states stacking for connected elements */
.pp-button-group--connected :deep(.pp-button:hover),
.pp-button-group--connected :deep(.pp-button:focus),
.pp-button-group--connected :deep(.pp-button:active) {
  z-index: 1;
}
</style>
