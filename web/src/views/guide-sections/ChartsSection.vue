<template>
<div class="guide-section">
        <h2>Charts & Graphs</h2>

        <div class="variant-group">
          <h3>Scatter & Bubble Chart</h3>
          <PPScatterChart 
            :data="[
              { x: 10, y: 20, r: 12, color: '#eb445a' },
              { x: 30, y: 70, r: 8, color: 'var(--pp-primary-light, #3880ff)' },
              { x: 50, y: 40, r: 20, color: '#2dd36f' },
              { x: 80, y: 90, r: 15, color: '#ffc409' },
              { x: 90, y: 10, r: 6, color: '#92949c' }
            ]"
            :maxX="100"
            :maxY="100"
          />
        </div>

        <div class="variant-group">
          <h3>Funnel Chart</h3>
          <PPFunnelChart 
            :data="[
              { label: 'Visitors', value: 10000 },
              { label: 'Signups', value: 5000 },
              { label: 'Cart Adds', value: 2500 },
              { label: 'Purchases', value: 500 }
            ]"
            :height="240"
          />
        </div>


        <div class="variant-group" style="display: flex; gap: 32px; justify-content: center; flex-wrap: wrap;">
          <div>
            <h3 style="text-align: center;">Progress Gauge</h3>
            <PPProgressGauge 
              :value="82"
              :max="100"
              :size="180"
              :thickness="14"
              :gradient="['#3dc2ff', 'var(--pp-primary-light, #3880ff)']"
              label="Performance"
              :format="(val) => val + '%'"
            />
          </div>
          <div>
            <h3 style="text-align: center;">Radar Chart</h3>
            <PPRadarChart 
              :size="180"
              :data="[80, 60, 90, 70, 85]"
              :labels="['Speed', 'Power', 'Agility', 'Stamina', 'Skill']"
              color="#eb445a"
            />
          </div>
        </div>

        
        <div class="variant-group">
          <h3>Line Chart (Gradients & Dashes)</h3>
          <PPLineChart 
            :data="[10, 30, 20, 50, 40, 80, 60]" 
            :labels="['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']"
            :gradient="['var(--pp-primary-light, #3880ff)', '#2dd36f']"
            :dashed="true"
            :showPoints="true"
            :dashedGrid="true"
            :strokeWidth="4"
          />
        </div>

        <div class="variant-group">
          <h3>Bar Chart (Thick Gradients)</h3>
          <PPBarChart 
            :data="[
              { label: 'Jan', value: 40, gradient: ['var(--pp-primary-light, #3880ff)', '#2dd36f'] },
              { label: 'Feb', value: 70, gradient: ['#ffc409', '#eb445a'] },
              { label: 'Mar', value: 25, gradient: ['#2dd36f', '#3dc2ff'] },
              { label: 'Apr', value: 90, gradient: ['#eb445a', '#92949c'] }
            ]"
            :barWidth="24"
            :barRadius="12"
          />
        </div>

        <div class="variant-group" style="display: flex; gap: 32px; justify-content: center; flex-wrap: wrap;">
          <div>
            <h3 style="text-align: center;">Donut Chart (Pill)</h3>
            <PPDonutChart 
              :size="140"
              :data="[
                { value: 45, color: 'var(--pp-primary-light, #3880ff)' },
                { value: 25, color: '#2dd36f' },
                { value: 30, color: '#ffc409' }
              ]"
              label="Total"
              value="100%"
              :rounded="true"
              :thickness="24"
            />
          </div>
          <div>
            <h3 style="text-align: center;">Pie Chart</h3>
            <PPPieChart 
              :size="140"
              :data="[
                { value: 40, color: '#eb445a' },
                { value: 60, color: 'var(--pp-primary-light, #3880ff)' }
              ]"
            />
          </div>
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
        &lt;h2&gt;Charts &amp; Graphs&lt;/h2&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Scatter &amp; Bubble Chart&lt;/h3&gt;
          &lt;PPScatterChart 
            :data="[
              { x: 10, y: 20, r: 12, color: '#eb445a' },
              { x: 30, y: 70, r: 8, color: 'var(--pp-primary-light, #3880ff)' },
              { x: 50, y: 40, r: 20, color: '#2dd36f' },
              { x: 80, y: 90, r: 15, color: '#ffc409' },
              { x: 90, y: 10, r: 6, color: '#92949c' }
            ]"
            :maxX="100"
            :maxY="100"
          /&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Funnel Chart&lt;/h3&gt;
          &lt;PPFunnelChart 
            :data="[
              { label: 'Visitors', value: 10000 },
              { label: 'Signups', value: 5000 },
              { label: 'Cart Adds', value: 2500 },
              { label: 'Purchases', value: 500 }
            ]"
            :height="240"
          /&gt;
        &lt;/div&gt;


        &lt;div class="variant-group" style="display: flex; gap: 32px; justify-content: center; flex-wrap: wrap;"&gt;
          &lt;div&gt;
            &lt;h3 style="text-align: center;"&gt;Progress Gauge&lt;/h3&gt;
            &lt;PPProgressGauge 
              :value="82"
              :max="100"
              :size="180"
              :thickness="14"
              :gradient="['#3dc2ff', 'var(--pp-primary-light, #3880ff)']"
              label="Performance"
              :format="(val) =&gt; val + '%'"
            /&gt;
          &lt;/div&gt;
          &lt;div&gt;
            &lt;h3 style="text-align: center;"&gt;Radar Chart&lt;/h3&gt;
            &lt;PPRadarChart 
              :size="180"
              :data="[80, 60, 90, 70, 85]"
              :labels="['Speed', 'Power', 'Agility', 'Stamina', 'Skill']"
              color="#eb445a"
            /&gt;
          &lt;/div&gt;
        &lt;/div&gt;

        
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Line Chart (Gradients &amp; Dashes)&lt;/h3&gt;
          &lt;PPLineChart 
            :data="[10, 30, 20, 50, 40, 80, 60]" 
            :labels="['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']"
            :gradient="['var(--pp-primary-light, #3880ff)', '#2dd36f']"
            :dashed="true"
            :showPoints="true"
            :dashedGrid="true"
            :strokeWidth="4"
          /&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Bar Chart (Thick Gradients)&lt;/h3&gt;
          &lt;PPBarChart 
            :data="[
              { label: 'Jan', value: 40, gradient: ['var(--pp-primary-light, #3880ff)', '#2dd36f'] },
              { label: 'Feb', value: 70, gradient: ['#ffc409', '#eb445a'] },
              { label: 'Mar', value: 25, gradient: ['#2dd36f', '#3dc2ff'] },
              { label: 'Apr', value: 90, gradient: ['#eb445a', '#92949c'] }
            ]"
            :barWidth="24"
            :barRadius="12"
          /&gt;
        &lt;/div&gt;

        &lt;div class="variant-group" style="display: flex; gap: 32px; justify-content: center; flex-wrap: wrap;"&gt;
          &lt;div&gt;
            &lt;h3 style="text-align: center;"&gt;Donut Chart (Pill)&lt;/h3&gt;
            &lt;PPDonutChart 
              :size="140"
              :data="[
                { value: 45, color: 'var(--pp-primary-light, #3880ff)' },
                { value: 25, color: '#2dd36f' },
                { value: 30, color: '#ffc409' }
              ]"
              label="Total"
              value="100%"
              :rounded="true"
              :thickness="24"
            /&gt;
          &lt;/div&gt;
          &lt;div&gt;
            &lt;h3 style="text-align: center;"&gt;Pie Chart&lt;/h3&gt;
            &lt;PPPieChart 
              :size="140"
              :data="[
                { value: 40, color: '#eb445a' },
                { value: 60, color: 'var(--pp-primary-light, #3880ff)' }
              ]"
            /&gt;
          &lt;/div&gt;
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
import { ref, computed } from 'vue';

import { PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart } from '@phanna/ui-framework';
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart } from '@phanna/ui-framework';
</script>
