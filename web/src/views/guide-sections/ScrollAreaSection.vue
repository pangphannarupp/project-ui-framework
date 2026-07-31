<template>
  <div class="guide-section">
    <h2>Scroll Area</h2>
    <p>A container that handles horizontal, vertical, or dual-axis scrolling with customized or hidden scrollbars.</p>

    <h3>Horizontal Scrolling (Hide Scrollbar)</h3>
    <div class="demo-box">
      <PPScrollArea direction="horizontal" hideScrollbar style="height: 120px;">
        <div style="display: flex; gap: 16px; padding: 16px;">
          <div v-for="i in 10" :key="i" style="width: 80px; height: 80px; background: white; border-radius: 12px; display: flex; flex-direction: column; align-items: center; justify-content: center; box-shadow: 0 2px 8px rgba(0,0,0,0.05); flex-shrink: 0;">
            <div style="font-size: 14px; color: #666;">{{ i }} PM</div>
            <div style="font-size: 24px; margin: 4px 0;">🌤️</div>
            <div style="font-size: 16px; font-weight: 600;">28°C</div>
          </div>
        </div>
      </PPScrollArea>
    </div>
    <div class="usage-block" style="margin-top: 16px;">
      <pre v-pre style="background: #1f2937; color: #f8f8f2; padding: 16px; border-radius: 8px; overflow-x: auto; font-size: 14px;"><code>&lt;PPScrollArea direction="horizontal" hideScrollbar&gt;
  &lt;div style="display: flex; gap: 16px;"&gt;
    &lt;!-- Your horizontal content items --&gt;
  &lt;/div&gt;
&lt;/PPScrollArea&gt;</code></pre>
    </div>

    <h3>Vertical Scrolling (Mac & Thin variants)</h3>
    <div style="display: flex; gap: 24px; flex-wrap: wrap;">
      
      <!-- Default Mac Style -->
      <div class="demo-box" style="flex: 1; height: 200px; min-width: 250px;">
        <h4 style="margin-top: 0; font-size: 14px;">scrollbar="mac"</h4>
        <PPScrollArea direction="vertical" scrollbar="mac" style="background: white; border-radius: 8px; border: 1px solid #e5e7eb;">
          <div style="padding: 16px;">
            <div v-for="i in 15" :key="i" style="padding: 12px; border-bottom: 1px solid #f3f4f6;">
              List Item {{ i }}
            </div>
          </div>
        </PPScrollArea>
      </div>

      <!-- Thin Style -->
      <div class="demo-box" style="flex: 1; height: 200px; min-width: 250px;">
        <h4 style="margin-top: 0; font-size: 14px;">scrollbar="thin"</h4>
        <PPScrollArea direction="vertical" scrollbar="thin" style="background: white; border-radius: 8px; border: 1px solid #e5e7eb;">
          <div style="padding: 16px;">
            <div v-for="i in 15" :key="i" style="padding: 12px; border-bottom: 1px solid #f3f4f6;">
              List Item {{ i }}
            </div>
          </div>
        </PPScrollArea>
      </div>
      
    </div>
    <div class="usage-block" style="margin-top: 16px;">
      <pre v-pre style="background: #1f2937; color: #f8f8f2; padding: 16px; border-radius: 8px; overflow-x: auto; font-size: 14px;"><code>&lt;PPScrollArea direction="vertical"&gt;
  &lt;!-- Your long vertical content --&gt;
  &lt;div v-for="i in 15" :key="i"&gt;List Item {{ i }}&lt;/div&gt;
&lt;/PPScrollArea&gt;</code></pre>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PPScrollArea } from '@phanna/ui-framework';
</script>

<style scoped>
.guide-section {
  display: flex;
  flex-direction: column;
  gap: 24px;
}
.demo-box {
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 24px;
  background: #f9fafb;
}
</style>
