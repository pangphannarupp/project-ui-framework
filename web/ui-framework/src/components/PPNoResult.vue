<template>
  <div class="pp-no-result">
    <div class="no-result-graphic">
      <slot name="graphic">
        <!-- Default graphic matching the design -->
        <svg viewBox="0 0 120 120" width="120" height="120" fill="none" xmlns="http://www.w3.org/2000/svg">
          <!-- Grey Circle with Question Mark -->
          <circle cx="50" cy="50" r="30" fill="#9e9e9e" />
          <path d="M43 40C43 36.134 46.134 33 50 33C53.866 33 57 36.134 57 40C57 42.5 54 44.5 51.5 46.5C50.5 47.3 50 48.5 50 50V52" stroke="white" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
          <circle cx="50" cy="62" r="4" fill="white" />
          
          <!-- Magnifying Glass Overlay -->
          <g transform="translate(15, 15)">
            <circle cx="55" cy="55" r="22" fill="#d8d8d8" fill-opacity="0.9" stroke="#606775" stroke-width="5" />
            <line x1="70" y1="70" x2="85" y2="85" stroke="#606775" stroke-width="6" stroke-linecap="round" />
            <!-- Little highlight on glass -->
            <path d="M40 55 A 15 15 0 0 1 55 40" stroke="white" stroke-width="3" stroke-linecap="round" fill="none" opacity="0.6" />
          </g>
        </svg>
      </slot>
    </div>
    <div class="no-result-text">
      <h3 class="no-result-title">{{ title }}</h3>
      <p class="no-result-subtitle" v-if="subtitle">{{ subtitle }}</p>
    </div>
    <div class="no-result-action" v-if="$slots.action">
      <slot name="action"></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps({
  title: {
    type: String,
    default: 'No results found'
  },
  subtitle: {
    type: String,
    default: 'Try changing your search or filter.'
  }
});
</script>

<style scoped>
.pp-no-result {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 40px 20px;
  text-align: center;
}

.no-result-graphic {
  margin-bottom: 24px;
}

.no-result-title {
  font-size: 18px;
  font-weight: 700;
  color: #333333;
  margin: 0 0 8px 0;
}

.no-result-subtitle {
  font-size: 14px;
  color: #777777;
  margin: 0;
  line-height: 1.4;
}

.no-result-action {
  margin-top: 24px;
}
</style>
