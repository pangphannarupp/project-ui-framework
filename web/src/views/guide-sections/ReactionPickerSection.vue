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
      
      <pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;" v-pre><code>&lt;template&gt;
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
  &lt;div class="component-section"&gt;
    &lt;h2&gt;Facebook-like Reactions (Stickers)&lt;/h2&gt;
    &lt;p&gt;A fun, animated reaction picker component that mimics the famous Facebook "Like" button behavior. Perfect for social feeds or interactive feedback.&lt;/p&gt;

    &lt;div style="margin-top: 32px; margin-bottom: 64px;"&gt;
      &lt;div class="demo-box" style="display: flex; gap: 40px; align-items: center; justify-content: center; height: 150px; background: #f8fafc; border-radius: 12px; border: 1px dashed #cbd5e1;"&gt;
        
        &lt;div&gt;
          &lt;p style="font-size: 13px; color: #64748b; margin-bottom: 8px; text-align: center;"&gt;Hover over the button!&lt;/p&gt;
          &lt;PPReactionPicker v-model="reaction1" @change="onChange" /&gt;
        &lt;/div&gt;

        &lt;div&gt;
          &lt;p style="font-size: 13px; color: #64748b; margin-bottom: 8px; text-align: center;"&gt;Already selected state&lt;/p&gt;
          &lt;PPReactionPicker v-model="reaction2" /&gt;
        &lt;/div&gt;

      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- Usage Section --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Usage Example&lt;/h3&gt;
      
      &lt;pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;!-- Basic Usage --&amp;gt;
  &amp;lt;PPReactionPicker v-model="selectedReaction" /&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { ref } from 'vue';
import { PPReactionPicker } from '@phanna/ui-framework';

// Will hold 'like', 'love', 'haha', 'wow', 'sad', 'angry' or null
const selectedReaction = ref(null);
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
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
import { PPReactionPicker } from '@phanna/ui-framework';

const reaction1 = ref&lt;string | null&gt;(null);
const reaction2 = ref&lt;string | null&gt;('love');

const onChange = (val: string | null) =&gt; {
  console.log('Selected reaction:', val);
};
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
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
