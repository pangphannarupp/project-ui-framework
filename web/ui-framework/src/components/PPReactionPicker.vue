<template>
  <div 
    class="pp-reaction-wrapper"
    @mouseenter="onEnter"
    @mouseleave="onLeave"
  >
    <!-- The Reaction Popup Picker -->
    <transition name="fade-slide">
      <div v-show="isPickerVisible" class="pp-reaction-picker">
        <div 
          v-for="(reaction, index) in activeReactions" 
          :key="reaction.id"
          class="pp-reaction-item"
          :style="{ animationDelay: `${index * 0.05}s` }"
          @click="selectReaction(reaction)"
        >
          <div class="pp-reaction-label">{{ reaction.label }}</div>
          <div class="pp-reaction-icon">{{ reaction.icon }}</div>
        </div>
      </div>
    </transition>

    <!-- The Main Trigger Button -->
    <button class="pp-reaction-trigger" :class="{ 'is-active': activeReaction }" @click="toggleDefaultLike">
      <span v-if="activeReaction" class="pp-reaction-trigger-icon" style="transform: scale(1.2);">{{ activeReaction.icon }}</span>
      <span v-else class="pp-reaction-trigger-icon" style="filter: grayscale(100%) brightness(1.5);">👍</span>
      
      <span class="pp-reaction-trigger-text" :style="{ color: activeReaction ? activeReaction.color : '#64748b' }">
        {{ activeReaction ? activeReaction.label : 'Like' }}
      </span>
    </button>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

export interface ReactionOption {
  id: string;
  label: string;
  icon: string;
  color: string;
}

const props = withDefaults(defineProps<{
  modelValue?: string | null;
  reactions?: ReactionOption[];
}>(), {
  modelValue: null,
  reactions: () => [
    { id: 'like', label: 'Like', icon: '👍', color: '#3b82f6' },
    { id: 'love', label: 'Love', icon: '❤️', color: '#ef4444' },
    { id: 'care', label: 'Care', icon: '🥰', color: '#f59e0b' },
    { id: 'haha', label: 'Haha', icon: '😆', color: '#f59e0b' },
    { id: 'wow', label: 'Wow', icon: '😮', color: '#f59e0b' },
    { id: 'sad', label: 'Sad', icon: '😢', color: '#f59e0b' },
    { id: 'angry', label: 'Angry', icon: '😡', color: '#ef4444' },
  ]
});

const emit = defineEmits<{
  (e: 'update:modelValue', value: string | null): void;
  (e: 'change', value: string | null): void;
}>();

const isPickerVisible = ref(false);
let timeout: any = null;

const activeReactions = computed(() => props.reactions);

const activeReaction = computed(() => {
  if (!props.modelValue) return null;
  return activeReactions.value.find(r => r.id === props.modelValue) || null;
});

const onEnter = () => {
  clearTimeout(timeout);
  timeout = setTimeout(() => {
    isPickerVisible.value = true;
  }, 400); // 400ms delay to show on hover (similar to FB)
};

const onLeave = () => {
  clearTimeout(timeout);
  timeout = setTimeout(() => {
    isPickerVisible.value = false;
  }, 300); // 300ms delay to hide so it doesn't jump
};

const selectReaction = (reaction: ReactionOption) => {
  emit('update:modelValue', reaction.id);
  emit('change', reaction.id);
  isPickerVisible.value = false;
};

const toggleDefaultLike = () => {
  if (props.modelValue) {
    emit('update:modelValue', null);
    emit('change', null);
  } else {
    emit('update:modelValue', 'like');
    emit('change', 'like');
  }
};
</script>

<style scoped>
.pp-reaction-wrapper {
  position: relative;
  display: inline-flex;
}

.pp-reaction-picker {
  position: absolute;
  bottom: 100%;
  left: 0;
  margin-bottom: 8px;
  background: #ffffff;
  border-radius: 30px;
  box-shadow: 0 4px 16px rgba(0,0,0,0.1), 0 8px 32px rgba(0,0,0,0.05);
  display: flex;
  padding: 6px 8px;
  gap: 8px;
  transform-origin: bottom left;
  z-index: 100;
}

.pp-reaction-item {
  position: relative;
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  border-radius: 50%;
  transition: transform 0.2s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

.pp-reaction-icon {
  font-size: 32px;
  line-height: 1;
  transition: transform 0.2s ease-out; /* Smooth return on mouse leave */
}

@keyframes hoverSpring {
  0% { transform: scale(1) translateY(0); }
  50% { transform: scale(1.6) translateY(-14px); }
  100% { transform: scale(1.4) translateY(-12px); }
}

.pp-reaction-item:hover .pp-reaction-icon {
  animation: hoverSpring 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards;
}

.pp-reaction-label {
  position: absolute;
  top: -45px;
  background: rgba(0, 0, 0, 0.8);
  color: white;
  font-size: 11px;
  font-weight: 600;
  padding: 3px 8px;
  border-radius: 12px;
  opacity: 0;
  visibility: hidden;
  transform: translateY(5px);
  transition: all 0.2s ease;
  white-space: nowrap;
  pointer-events: none;
  z-index: 10;
}

.pp-reaction-item:hover .pp-reaction-label {
  opacity: 1;
  visibility: visible;
  transform: translateY(0);
}

.pp-reaction-trigger {
  display: flex;
  align-items: center;
  gap: 6px;
  background: transparent;
  border: none;
  cursor: pointer;
  padding: 8px 12px;
  border-radius: 6px;
  font-size: 14px;
  font-weight: 600;
  transition: background 0.2s;
}

.pp-reaction-trigger:hover {
  background: #f1f5f9;
}

.pp-reaction-trigger-icon {
  font-size: 20px;
  transition: transform 0.2s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

.pp-reaction-trigger:active .pp-reaction-trigger-icon {
  transform: scale(0.9);
}

/* Entry Animation for the picker */
.fade-slide-enter-active {
  transition: opacity 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275), 
              transform 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}
.fade-slide-leave-active {
  transition: opacity 0.2s, transform 0.2s;
}
.fade-slide-enter-from {
  opacity: 0;
  transform: translateY(15px) scale(0.9);
}
.fade-slide-leave-to {
  opacity: 0;
  transform: translateY(10px) scale(0.95);
}

/* Staggered emoji entry */
.fade-slide-enter-active .pp-reaction-item {
  animation: bounceIn 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
}

@keyframes bounceIn {
  0% { transform: translateY(15px) scale(0.5); opacity: 0; }
  100% { transform: translateY(0) scale(1); opacity: 1; }
}
</style>
