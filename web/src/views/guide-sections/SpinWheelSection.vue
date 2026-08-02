<template>
  <div class="guide-section">
    <h2>Spin the Wheel</h2>
    <p class="guide-desc">A fun and interactive spin the wheel component for gamification and lotteries.</p>

    <div class="variant-group">
      <h3>Basic Spin Wheel</h3>
      <div class="component-demo" style="display: flex; flex-direction: column; align-items: center; padding: 40px; background-color: #f4f5f8; border-radius: 12px; gap: 24px;">
        <PPSpinWheel 
          ref="wheelRef"
          :items="prizes"
          :spinDuration="4000"
          :spins="5"
          @start="onSpinStart"
          @finish="onSpinFinish"
        />
        
        <div style="display: flex; flex-direction: column; align-items: center; gap: 12px;">
          <PPButton 
            variant="primary" 
            :disabled="isSpinning"
            @click="spinWheel"
          >
            {{ isSpinning ? 'Spinning...' : 'Spin the Wheel!' }}
          </PPButton>
          
          <div v-if="resultText" style="margin-top: 16px; font-weight: bold; font-size: 18px; color: #007aff;">
            {{ resultText }}
          </div>
        </div>
      </div>
      <pre class="code-block"><code>&lt;PPSpinWheel 
  ref="wheelRef"
  :items="prizes"
  @finish="onSpinFinish"
/&gt;</code></pre>
    </div>

    <div class="variant-group">
      <h3>Donut Variant</h3>
      <div class="component-demo" style="display: flex; flex-direction: column; align-items: center; padding: 40px; background-color: #f4f5f8; border-radius: 12px; gap: 24px;">
        <PPSpinWheel 
          :items="prizes"
          variant="donut"
        />
      </div>
      <pre class="code-block"><code>&lt;PPSpinWheel variant="donut" :items="prizes" /&gt;</code></pre>
    </div>

    <div class="variant-group">
      <h3>Casino Variant</h3>
      <div class="component-demo" style="display: flex; flex-direction: column; align-items: center; padding: 40px; background-color: #f4f5f8; border-radius: 12px; gap: 24px;">
        <PPSpinWheel 
          :items="prizes"
          variant="casino"
        />
      </div>
      <pre class="code-block"><code>&lt;PPSpinWheel variant="casino" :items="prizes" /&gt;</code></pre>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPSpinWheel, PPButton } from '@phanna/ui-framework';

const wheelRef = ref<any>(null);
const isSpinning = ref(false);
const resultText = ref('');

const prizes = [
  { label: '$10 Voucher', value: '10_voucher', color: '#FF3B30' },
  { label: 'Free Coffee', value: 'free_coffee', color: '#FF9500' },
  { label: 'Try Again', value: 'try_again', color: '#8E8E93' },
  { label: '50% Off', value: '50_off', color: '#4CD964' },
  { label: 'Free Pastry', value: 'free_pastry', color: '#5AC8FA' },
  { label: '$5 Cashback', value: '5_cashback', color: '#007AFF' },
  { label: 'Try Again', value: 'try_again', color: '#8E8E93' },
  { label: 'Mystery Box', value: 'mystery_box', color: '#AF52DE' }
];

const spinWheel = () => {
  if (isSpinning.value) return;
  
  // Randomly select a winning index
  const winnerIndex = Math.floor(Math.random() * prizes.length);
  
  resultText.value = '';
  wheelRef.value?.spinTo(winnerIndex);
};

const onSpinStart = () => {
  isSpinning.value = true;
};

const onSpinFinish = (item: any) => {
  isSpinning.value = false;
  if (item.value === 'try_again') {
    resultText.value = 'Oh no! Try Again!';
  } else {
    resultText.value = `🎉 You won: ${item.label}!`;
  }
};
</script>
