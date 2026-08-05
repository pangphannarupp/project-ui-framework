<template>
<div class="guide-section">
        <h2>4. PPActionCard Colors</h2>
        <div style="background: #f4f5f8; padding: 20px; border-radius: 12px; display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
          
          <div class="variant-group">
            <h3>Pink Badge</h3>
            <PPActionCard title="Approval" subtitle="Pending" badgeCount="5" badgeColor="pink" />
            <pre class="code-block" v-pre><code>&lt;PPActionCard 
  title="Approval" 
  badgeColor="pink" 
/&gt;</code></pre>
          </div>

          <div class="variant-group">
            <h3>Orange Badge</h3>
            <PPActionCard title="Payment" subtitle="Due" badgeCount="2" badgeColor="orange" />
            <pre class="code-block" v-pre><code>&lt;PPActionCard 
  title="Payment" 
  badgeColor="orange" 
/&gt;</code></pre>
          </div>

          <div class="variant-group">
            <h3>Teal Badge</h3>
            <PPActionCard title="Transfer" subtitle="Done" badgeCount="1" badgeColor="teal" />
            <pre class="code-block" v-pre><code>&lt;PPActionCard 
  title="Transfer" 
  badgeColor="teal" 
/&gt;</code></pre>
          </div>

          <div class="variant-group">
            <h3>Blue Badge</h3>
            <PPActionCard title="Send" badgeColor="blue" />
            <pre class="code-block" v-pre><code>&lt;PPActionCard 
  title="Send" 
  badgeColor="blue" 
/&gt;</code></pre>
          </div>
        </div>
      
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-primary-variant: /* value */;
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
        &lt;h2&gt;4. PPActionCard Colors&lt;/h2&gt;
        &lt;div style="background: #f4f5f8; padding: 20px; border-radius: 12px; display: grid; grid-template-columns: 1fr 1fr; gap: 10px;"&gt;
          
          &lt;div class="variant-group"&gt;
            &lt;h3&gt;Pink Badge&lt;/h3&gt;
            &lt;PPActionCard title="Approval" subtitle="Pending" badgeCount="5" badgeColor="pink" /&gt;
            &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPActionCard 
  title="Approval" 
  badgeColor="pink" 
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
          &lt;/div&gt;

          &lt;div class="variant-group"&gt;
            &lt;h3&gt;Orange Badge&lt;/h3&gt;
            &lt;PPActionCard title="Payment" subtitle="Due" badgeCount="2" badgeColor="orange" /&gt;
            &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPActionCard 
  title="Payment" 
  badgeColor="orange" 
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
          &lt;/div&gt;

          &lt;div class="variant-group"&gt;
            &lt;h3&gt;Teal Badge&lt;/h3&gt;
            &lt;PPActionCard title="Transfer" subtitle="Done" badgeCount="1" badgeColor="teal" /&gt;
            &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPActionCard 
  title="Transfer" 
  badgeColor="teal" 
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
          &lt;/div&gt;

          &lt;div class="variant-group"&gt;
            &lt;h3&gt;Blue Badge&lt;/h3&gt;
            &lt;PPActionCard title="Send" badgeColor="blue" /&gt;
            &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPActionCard 
  title="Send" 
  badgeColor="blue" 
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
          &lt;/div&gt;
        &lt;/div&gt;
      
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-primary-variant: /* value */;
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
&lt;/div&gt;
&lt;/template&gt;

&lt;script setup lang="ts"&gt;
import { ref, computed } from 'vue';

import { PPActionCard } from '@phanna/ui-framework';
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { PPActionCard } from '@phanna/ui-framework';
</script>
