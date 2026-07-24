<template>
  <div class="component-section">
    <h2>Facebook-like Reactions (Stickers)</h2>
    <p>A fun, animated reaction picker component that mimics the famous Facebook "Like" button behavior. Perfect for social feeds or interactive feedback.</p>

    <div style="margin-top: 32px; margin-bottom: 64px;">
      <div class="demo-box" style="display: flex; gap: 40px; align-items: center; justify-content: center; height: 150px; background: #f8fafc; border-radius: 12px; border: 1px dashed #cbd5e1;">
        
        <div>
          <p style="font-size: 13px; color: #64748b; margin-bottom: 8px; text-align: center;">Hover over the button!</p>
          <PPReactionPicker v-model="reaction1" @change="onChange" />
        </div>

        <div>
          <p style="font-size: 13px; color: #64748b; margin-bottom: 8px; text-align: center;">Already selected state</p>
          <PPReactionPicker v-model="reaction2" />
        </div>

      </div>
    </div>

    <!-- Usage Section -->
    <div style="margin-top: 40px;">
      <h3>Usage Example</h3>
      
      <pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"><code>&lt;template&gt;
  &lt;!-- Basic Usage --&gt;
  &lt;PPReactionPicker v-model="selectedReaction" /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { ref } from 'vue';
import { PPReactionPicker } from '@phanna/ui-framework';

// Will hold 'like', 'love', 'haha', 'wow', 'sad', 'angry' or null
const selectedReaction = ref(null);
&lt;/script&gt;</code></pre>
    </div>

  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPReactionPicker } from '@phanna/ui-framework';

const reaction1 = ref<string | null>(null);
const reaction2 = ref<string | null>('love');

const onChange = (val: string | null) => {
  console.log('Selected reaction:', val);
};
</script>
