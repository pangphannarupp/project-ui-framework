<template>
  <div 
    class="pp-avatar"
    :class="[
      `size-${size}`,
      `shape-${shape}`,
      { 'has-image': src, 'is-text': !src && !icon }
    ]"
    :style="customStyle"
  >
    <img v-if="src" :src="src" :alt="alt || name" @error="handleImageError" />
    <ion-icon v-else-if="icon" :icon="icon" />
    <span v-else>{{ initials }}</span>
  </div>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue';
import { IonIcon } from '@ionic/vue';

const props = withDefaults(defineProps<{
  src?: string;
  name?: string;
  alt?: string;
  icon?: string;
  size?: 'xs' | 'sm' | 'md' | 'lg' | 'xl';
  shape?: 'circle' | 'square' | 'rounded';
  bgColor?: string;
  textColor?: string;
}>(), {
  size: 'md',
  shape: 'circle',
});

const imageError = ref(false);

const handleImageError = () => {
  imageError.value = true;
};

const initials = computed(() => {
  if (props.name) {
    const parts = props.name.split(' ').filter(p => p.length > 0);
    if (parts.length >= 2) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    } else if (parts.length === 1) {
      return parts[0].substring(0, 2).toUpperCase();
    }
  }
  return '?';
});

const customStyle = computed(() => {
  const styles: any = {};
  if (props.bgColor) styles.backgroundColor = props.bgColor;
  if (props.textColor) styles.color = props.textColor;
  return styles;
});
</script>

<style scoped>
.pp-avatar {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  background-color: #cbd5e1;
  color: #475569;
  font-weight: 600;
  user-select: none;
  flex-shrink: 0;
}

.pp-avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.pp-avatar ion-icon {
  font-size: 1.2em;
}

/* Sizes */
.size-xs { width: 24px; height: 24px; font-size: 10px; }
.size-sm { width: 32px; height: 32px; font-size: 12px; }
.size-md { width: 40px; height: 40px; font-size: 14px; }
.size-lg { width: 56px; height: 56px; font-size: 18px; }
.size-xl { width: 72px; height: 72px; font-size: 24px; }

/* Shapes */
.shape-circle { border-radius: 50%; }
.shape-square { border-radius: 0; }
.shape-rounded { border-radius: 8px; }

/* In groups, we might need a border */
.pp-avatar-group .pp-avatar {
  border: 2px solid #ffffff;
}
</style>
