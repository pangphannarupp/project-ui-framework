<template>
  <div class="pp-onboard">
    <div class="pp-onboard-content" ref="scrollContainer" @scroll="onScroll">
      <div 
        class="pp-onboard-step" 
        v-for="(step, index) in steps" 
        :key="index"
      >
        <div class="step-image-container">
          <img v-if="step.image" :src="step.image" :alt="step.title" class="step-image" />
          <ion-icon v-else-if="step.icon" :icon="step.icon" class="step-icon"></ion-icon>
        </div>
        <div class="step-text-container">
          <h2 class="step-title">{{ step.title }}</h2>
          <p class="step-description">{{ step.description }}</p>
        </div>
      </div>
    </div>
    
    <div class="pp-onboard-footer">
      <div class="pp-onboard-pagination">
        <div 
          v-for="(_, index) in steps" 
          :key="'dot-' + index"
          class="pagination-dot"
          :class="{ 'is-active': currentStep === index }"
          @click="scrollToStep(index)"
        ></div>
      </div>
      
      <div class="pp-onboard-actions">
        <button 
          v-if="skippable && currentStep < steps.length - 1" 
          class="pp-onboard-btn is-skip" 
          @click="$emit('skip')"
        >
          Skip
        </button>
        <div v-else class="btn-spacer"></div>
        
        <button 
          v-if="currentStep < steps.length - 1" 
          class="pp-onboard-btn is-next" 
          @click="scrollToStep(currentStep + 1)"
        >
          Next
        </button>
        
        <button 
          v-else 
          class="pp-onboard-btn is-done" 
          @click="$emit('complete')"
        >
          {{ doneText }}
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { IonIcon } from '@ionic/vue';

interface OnboardStep {
  title: string;
  description: string;
  image?: string;
  icon?: string;
}

const props = defineProps({
  steps: {
    type: Array as () => OnboardStep[],
    required: true,
    default: () => []
  },
  skippable: {
    type: Boolean,
    default: true
  },
  doneText: {
    type: String,
    default: 'Get Started'
  }
});

defineEmits(['skip', 'complete']);

const scrollContainer = ref<HTMLElement | null>(null);
const currentStep = ref(0);

const onScroll = () => {
  if (!scrollContainer.value) return;
  const container = scrollContainer.value;
  // Calculate which step is mostly visible
  const scrollLeft = container.scrollLeft;
  const width = container.clientWidth;
  if (width > 0) {
    const index = Math.round(scrollLeft / width);
    if (index !== currentStep.value && index >= 0 && index < props.steps.length) {
      currentStep.value = index;
    }
  }
};

const scrollToStep = (index: number) => {
  if (!scrollContainer.value) return;
  const container = scrollContainer.value;
  const width = container.clientWidth;
  container.scrollTo({
    left: width * index,
    behavior: 'smooth'
  });
  currentStep.value = index;
};
</script>

<style scoped>
.pp-onboard {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 100%;
  background: white;
  position: relative;
  overflow: hidden;
}

.pp-onboard-content {
  flex: 1;
  display: flex;
  overflow-x: auto;
  overflow-y: hidden;
  scroll-snap-type: x mandatory;
  scroll-behavior: smooth;
  scrollbar-width: none; /* Firefox */
}
.pp-onboard-content::-webkit-scrollbar {
  display: none; /* Chrome, Safari */
}

.pp-onboard-step {
  flex: 0 0 100%;
  width: 100%;
  height: 100%;
  scroll-snap-align: start;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 40px 24px;
  box-sizing: border-box;
}

.step-image-container {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  max-width: 400px;
  margin-bottom: 40px;
}

.step-image {
  width: 100%;
  height: auto;
  object-fit: contain;
  max-height: 40vh;
}

.step-icon {
  font-size: 160px;
  color: #3880ff;
}

.step-text-container {
  text-align: center;
  margin-bottom: 60px; /* Space for footer */
}

.step-title {
  font-size: 28px;
  font-weight: 700;
  color: #1a1a1a;
  margin: 0 0 16px 0;
  line-height: 1.2;
}

.step-description {
  font-size: 16px;
  color: #666666;
  margin: 0;
  line-height: 1.5;
}

.pp-onboard-footer {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 24px;
  background: linear-gradient(to top, rgba(255,255,255,1) 60%, rgba(255,255,255,0));
  display: flex;
  flex-direction: column;
  align-items: center;
}

.pp-onboard-pagination {
  display: flex;
  gap: 8px;
  margin-bottom: 24px;
}

.pagination-dot {
  width: 8px;
  height: 8px;
  border-radius: 4px;
  background-color: #e0e0e0;
  cursor: pointer;
  transition: all 0.3s ease;
}

.pagination-dot.is-active {
  width: 24px;
  background-color: #3880ff;
}

.pp-onboard-actions {
  display: flex;
  width: 100%;
  justify-content: space-between;
  align-items: center;
}

.pp-onboard-btn {
  background: none;
  border: none;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  padding: 12px 24px;
  border-radius: 24px;
  transition: all 0.2s;
}

.pp-onboard-btn.is-skip {
  color: #999;
  padding-left: 0;
}
.pp-onboard-btn.is-skip:hover {
  color: #666;
}

.btn-spacer {
  flex: 1;
}

.pp-onboard-btn.is-next,
.pp-onboard-btn.is-done {
  background-color: #3880ff;
  color: white;
  margin-left: auto;
  box-shadow: 0 4px 12px rgba(56, 128, 255, 0.3);
}

.pp-onboard-btn.is-next:hover,
.pp-onboard-btn.is-done:hover {
  background-color: #2b65cc;
  box-shadow: 0 4px 16px rgba(56, 128, 255, 0.4);
}
</style>
