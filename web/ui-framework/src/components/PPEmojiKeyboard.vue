<template>
  <div 
    class="pp-emoji-keyboard" 
    :class="[`${theme}-theme`, `variant-${variant}`]"
    :style="backgroundColor ? { backgroundColor } : {}"
  >
    <div class="emoji-categories">
      <button 
        v-for="cat in categories" 
        :key="cat.name"
        class="category-btn"
        :class="{ active: activeCategory === cat.name }"
        @click="activeCategory = cat.name"
      >
        {{ cat.icon }}
      </button>
    </div>

    <div class="emoji-grid-container">
      <div class="emoji-grid">
        <button 
          v-for="(emoji, idx) in currentEmojis" 
          :key="idx"
          class="emoji-btn"
          @click="emitPress(emoji)"
        >
          {{ emoji }}
        </button>
      </div>
    </div>
    
    <div class="emoji-action-row">
      <button class="action-btn" @click="$emit('back')">ABC</button>
      <button class="action-btn delete-btn" @click="$emit('delete')">
        <svg viewBox="0 0 24 24" width="24" height="24" fill="currentColor">
          <path d="M21 4H8l-7 8 7 8h13a2 2 0 002-2V6a2 2 0 00-2-2zm-2.5 12.5L16 14l-2.5 2.5-1.5-1.5 2.5-2.5-2.5-2.5 1.5-1.5 2.5 2.5 2.5-2.5 1.5 1.5-2.5 2.5 2.5 2.5-1.5 1.5z"></path>
        </svg>
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const emit = defineEmits<{
  (e: 'input', value: string): void;
  (e: 'delete'): void;
  (e: 'back'): void;
}>();

defineProps({
  theme: {
    type: String as () => 'light' | 'dark',
    default: 'light'
  },
  variant: {
    type: String as () => 'default' | 'flat' | 'glass',
    default: 'default'
  },
  backgroundColor: {
    type: String,
    default: ''
  }
});

const categories = [
  { name: 'Smileys', icon: '😀', emojis: ['😀','😃','😄','😁','😆','😅','😂','🤣','🥲','☺️','😊','😇','🙂','🙃','😉','😌','😍','🥰','😘','😗','😙','😚','😋','😛','😝','😜','🤪','🤨','🧐','🤓','😎','🥸','🤩','🥳','😏','😒','😞','😔','😟','😕','🙁','☹️','😣','😖','😫','😩','🥺','😢','😭','😤','😠','😡','🤬','🤯','😳','🥵','🥶','😱','😨','😰','😥','😓','🤗','🤔','🤭','🤫','🤥','😶','😐','😑','😬','🙄','😯','😦','😧','😮','😲','🥱','😴','🤤','😪','😵','🤐','🥴','🤢','🤮','🤧','😷','🤒','🤕'] },
  { name: 'Nature', icon: '🐻', emojis: ['🐶','🐱','🐭','🐹','🐰','🦊','🐻','🐼','🐻‍❄️','🐨','🐯','🦁','🐮','🐷','🐽','🐸','🐵','🙈','🙉','🙊','🐒','🐔','🐧','🐦','🐤','🐣','🐥','🦆','🦅','🦉','🦇','🐺','🐗','🐴','🦄','🐝','🪱','🐛','🦋','🐌','🐞','🐜','🪰','🪲','🪳','🦟','🦗','🕷','🕸','🦂','🐢','🐍','🦎','🦖','🦕','🐙','🦑','🦐','🦞','🦀','🐡','🐠','🐟','🐬','🐳','🐋','🦈','🦭','🐊','🐅','🐆','🦓','🦍','🦧','🦣','🐘','🦛','🦏','🐪','🐫','🦒','🦘','🦬','🐃','🐂','🐄','🐎','🐖','🐏','🐑','🦙','🐐','🦌','🐕','🐩','🦮','🐕‍🦺','🐈','🐈‍⬛','🪶','🐓','🦃','🦤','🦚','🦜','🦢','🦩','🕊','🐇','🦝','🦨','🦡','🦫','🦦','🦥','🐁','🐀','🐿','🦔','🐾','🐉','🐲'] },
  { name: 'Food', icon: '🍔', emojis: ['🍏','🍎','🍐','🍊','🍋','🍌','🍉','🍇','🍓','🫐','🍈','🍒','🍑','🥭','🍍','🥥','🥝','🍅','🍆','🥑','🥦','🥬','🥒','🌶','🫑','🌽','🥕','🫒','🧄','🧅','🥔','🍠','🥐','🥯','🍞','🥖','🥨','🧀','🥚','🍳','🧈','🥞','🧇','🥓','🥩','🍗','🍖','🦴','🌭','🍔','🍟','🍕','🫓','🥪','🥙','🧆','🌮','🌯','🫔','🥗','🥘','🫕','🥫','🍝','🍜','🍲','🍛','🍣','🍱','🥟','🦪','🍤','🍙','🍚','🍘','🍥','🥠','🥮','🍢','🍡','🍧','🍨','🍦','🥧','🧁','🍰','🎂','🍮','🍭','🍬','🍫','🍿','🍩','🍪','🌰','🥜','🍯','🥛','🍼','🫖','☕️','🍵','🧃','🥤','🧋','🍶','🍺','🍻','🥂','🍷','🥃','🍸','🍹','🧉','🍾','🧊','🥄','🍴','🍽','🥣','🥡','🥢','🧂'] }
];

const activeCategory = ref(categories[0].name);

const currentEmojis = computed(() => {
  const cat = categories.find(c => c.name === activeCategory.value);
  return cat ? cat.emojis : [];
});

const emitPress = (emoji: string) => {
  emit('input', emoji);
};
</script>

<style scoped>
.pp-emoji-keyboard {
  width: 100%;
  display: flex;
  flex-direction: column;
  padding: 8px 0 0 0;
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  user-select: none;
  height: 280px; /* fixed height for keyboard */
}

.pp-emoji-keyboard.light-theme {
  background-color: var(--pp-keyboard-bg, #d1d4d9);
}

.pp-emoji-keyboard.dark-theme {
  background-color: #1e1e1e;
}

/* Glass Variant */
.pp-emoji-keyboard.variant-glass {
  background-color: rgba(30, 30, 30, 0.4) !important;
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
}
.pp-emoji-keyboard.light-theme.variant-glass {
  background-color: rgba(209, 212, 217, 0.4) !important;
}

.emoji-categories {
  display: flex;
  justify-content: space-around;
  padding: 4px 8px 8px 8px;
  border-bottom: 1px solid rgba(128,128,128,0.2);
}

.category-btn {
  background: transparent;
  border: none;
  font-size: 20px;
  padding: 8px;
  border-radius: 8px;
  cursor: pointer;
  opacity: 0.5;
  transition: opacity 0.2s, background-color 0.2s;
}

.category-btn.active {
  opacity: 1;
  background-color: rgba(128,128,128,0.2);
}

.emoji-grid-container {
  flex: 1;
  overflow-y: auto;
  padding: 8px;
}

.emoji-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(40px, 1fr));
  gap: 4px;
}

.emoji-btn {
  background: transparent;
  border: none;
  font-size: 28px;
  display: flex;
  align-items: center;
  justify-content: center;
  height: 44px;
  border-radius: 8px;
  cursor: pointer;
  transition: background-color 0.1s;
}

.emoji-btn:active {
  background-color: rgba(128,128,128,0.2);
}

.emoji-action-row {
  display: flex;
  justify-content: space-between;
  padding: 8px 16px 24px 16px;
  background-color: rgba(128,128,128,0.1);
}

.action-btn {
  background-color: rgba(128,128,128,0.2);
  border: none;
  border-radius: 20px;
  padding: 8px 24px;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
}

.light-theme .action-btn {
  color: #000;
}

.dark-theme .action-btn {
  color: #fff;
}
</style>
