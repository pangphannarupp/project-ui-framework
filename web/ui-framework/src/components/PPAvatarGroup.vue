<template>
  <div class="pp-avatar-group" :class="[`size-${size}`]">
    <div class="avatar-wrapper" v-for="(avatar, index) in visibleAvatars" :key="index" :style="{ zIndex: items.length - index }">
      <PPAvatar 
        :src="avatar.src"
        :name="avatar.name"
        :icon="avatar.icon"
        :size="size"
        :shape="shape"
        :bgColor="avatar.bgColor"
        :textColor="avatar.textColor"
      />
    </div>
    
    <div class="avatar-wrapper more-avatar" v-if="overflowCount > 0" :style="{ zIndex: 0 }">
      <PPAvatar 
        :name="`+${overflowCount}`"
        :size="size"
        :shape="shape"
        bgColor="#e2e8f0"
        textColor="#475569"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import PPAvatar from './PPAvatar.vue';

interface AvatarItem {
  src?: string;
  name?: string;
  icon?: string;
  bgColor?: string;
  textColor?: string;
}

const props = withDefaults(defineProps<{
  items: AvatarItem[];
  max?: number;
  size?: 'xs' | 'sm' | 'md' | 'lg' | 'xl';
  shape?: 'circle' | 'square' | 'rounded';
}>(), {
  max: 4,
  size: 'md',
  shape: 'circle'
});

const visibleAvatars = computed(() => {
  return props.items.slice(0, props.max);
});

const overflowCount = computed(() => {
  return Math.max(0, props.items.length - props.max);
});
</script>

<style scoped>
.pp-avatar-group {
  display: inline-flex;
  align-items: center;
}

.avatar-wrapper {
  position: relative;
  transition: transform 0.2s ease;
}

.avatar-wrapper:hover {
  transform: translateY(-4px);
  z-index: 100 !important;
}

/* Overlapping based on sizes */
.size-xs .avatar-wrapper:not(:first-child) { margin-left: -8px; }
.size-sm .avatar-wrapper:not(:first-child) { margin-left: -12px; }
.size-md .avatar-wrapper:not(:first-child) { margin-left: -16px; }
.size-lg .avatar-wrapper:not(:first-child) { margin-left: -20px; }
.size-xl .avatar-wrapper:not(:first-child) { margin-left: -24px; }
</style>
