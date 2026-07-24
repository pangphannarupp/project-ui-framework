<template>
  <div class="guide-section">
    <h2>Onboarding</h2>
    <p>A step-by-step swipeable interface for introducing users to the application.</p>

    <h3>Standard Onboarding</h3>
    <div class="demo-box onboard-demo">
      <PPOnboard 
        :steps="onboardSteps" 
        @skip="handleSkip"
        @complete="handleComplete"
      />
    </div>
    
    <pre class="code-block" style="margin-top: 24px;"><code>&lt;PPOnboard 
  :steps="[
    { title: 'Welcome', description: 'Start your journey', icon: globeOutline },
    { title: 'Secure', description: 'Your data is safe', icon: lockClosedOutline }
  ]"
  @skip="onSkip"
  @complete="onComplete"
/&gt;</code></pre>
  </div>
</template>

<script setup lang="ts">
import { PPOnboard } from '@phanna/ui-framework';
import { rocketOutline, colorPaletteOutline, flashOutline } from 'ionicons/icons';

const onboardSteps = [
  {
    title: 'Welcome to UI Framework',
    description: 'Build modern applications with our comprehensive suite of components.',
    icon: rocketOutline
  },
  {
    title: 'Beautiful Design',
    description: 'Every component is carefully crafted to look great right out of the box.',
    icon: colorPaletteOutline
  },
  {
    title: 'Fast & Responsive',
    description: 'Optimized for performance across all devices and screen sizes.',
    icon: flashOutline
  }
];

const handleSkip = () => {
  console.log('User skipped onboarding');
};

const handleComplete = () => {
  console.log('User completed onboarding');
};
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; overflow: hidden; background: #f9fafb; }
.onboard-demo { height: 600px; max-width: 400px; margin: 0 auto; position: relative; }
</style>
