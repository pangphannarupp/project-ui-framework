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
      <pre class="code-block" v-pre><code>&lt;PPSpinWheel 
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
      <pre class="code-block" v-pre><code>&lt;PPSpinWheel variant="donut" :items="prizes" /&gt;</code></pre>
    </div>

    <div class="variant-group">
      <h3>Casino Variant</h3>
      <div class="component-demo" style="display: flex; flex-direction: column; align-items: center; padding: 40px; background-color: #f4f5f8; border-radius: 12px; gap: 24px;">
        <PPSpinWheel 
          :items="prizes"
          variant="casino"
        />
      </div>
      <pre class="code-block" v-pre><code>&lt;PPSpinWheel variant="casino" :items="prizes" /&gt;</code></pre>
    </div>
  
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  /* This component does not use CSS variables directly. */
  /* Use custom classes to override styles. */
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}</code></pre>
        </div>
</div>
<!-- FULL_SOURCE_CODE_START -->
    <div class="variant-group" style="margin-top: 40px;">
      <h3>Full Page Source Code</h3>
      <p class="custom-guide">Complete source code for this section.</p>
      <pre class="code-block" style="max-height: 500px; overflow-y: auto;" v-pre><code>&lt;template&gt;
  &lt;div class="guide-section"&gt;
    &lt;h2&gt;Spin the Wheel&lt;/h2&gt;
    &lt;p class="guide-desc"&gt;A fun and interactive spin the wheel component for gamification and lotteries.&lt;/p&gt;

    &lt;div class="variant-group"&gt;
      &lt;h3&gt;Basic Spin Wheel&lt;/h3&gt;
      &lt;div class="component-demo" style="display: flex; flex-direction: column; align-items: center; padding: 40px; background-color: #f4f5f8; border-radius: 12px; gap: 24px;"&gt;
        &lt;PPSpinWheel 
          ref="wheelRef"
          :items="prizes"
          :spinDuration="4000"
          :spins="5"
          @start="onSpinStart"
          @finish="onSpinFinish"
        /&gt;
        
        &lt;div style="display: flex; flex-direction: column; align-items: center; gap: 12px;"&gt;
          &lt;PPButton 
            variant="primary" 
            :disabled="isSpinning"
            @click="spinWheel"
          &gt;
            {{ isSpinning ? 'Spinning...' : 'Spin the Wheel!' }}
          &lt;/PPButton&gt;
          
          &lt;div v-if="resultText" style="margin-top: 16px; font-weight: bold; font-size: 18px; color: #007aff;"&gt;
            {{ resultText }}
          &lt;/div&gt;
        &lt;/div&gt;
      &lt;/div&gt;
      &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPSpinWheel 
  ref="wheelRef"
  :items="prizes"
  @finish="onSpinFinish"
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;div class="variant-group"&gt;
      &lt;h3&gt;Donut Variant&lt;/h3&gt;
      &lt;div class="component-demo" style="display: flex; flex-direction: column; align-items: center; padding: 40px; background-color: #f4f5f8; border-radius: 12px; gap: 24px;"&gt;
        &lt;PPSpinWheel 
          :items="prizes"
          variant="donut"
        /&gt;
      &lt;/div&gt;
      &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPSpinWheel variant="donut" :items="prizes" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;div class="variant-group"&gt;
      &lt;h3&gt;Casino Variant&lt;/h3&gt;
      &lt;div class="component-demo" style="display: flex; flex-direction: column; align-items: center; padding: 40px; background-color: #f4f5f8; border-radius: 12px; gap: 24px;"&gt;
        &lt;PPSpinWheel 
          :items="prizes"
          variant="casino"
        /&gt;
      &lt;/div&gt;
      &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPSpinWheel variant="casino" :items="prizes" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;
  
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  /* This component does not use CSS variables directly. */
  /* Use custom classes to override styles. */
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
&lt;/div&gt;
&lt;/template&gt;

&lt;script setup lang="ts"&gt;
import { ref } from 'vue';
import { PPSpinWheel, PPButton } from '@phanna/ui-framework';

const wheelRef = ref&lt;any&gt;(null);
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

const spinWheel = () =&gt; {
  if (isSpinning.value) return;
  
  // Randomly select a winning index
  const winnerIndex = Math.floor(Math.random() * prizes.length);
  
  resultText.value = '';
  wheelRef.value?.spinTo(winnerIndex);
};

const onSpinStart = () =&gt; {
  isSpinning.value = true;
};

const onSpinFinish = (item: any) =&gt; {
  isSpinning.value = false;
  if (item.value === 'try_again') {
    resultText.value = 'Oh no! Try Again!';
  } else {
    resultText.value = `🎉 You won: ${item.label}!`;
  }
};
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
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
