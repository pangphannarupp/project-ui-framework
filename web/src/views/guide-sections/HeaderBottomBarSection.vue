<template>
  <div class="component-section">
    <h2>Header & Bottom Bar</h2>
    <p>Flexible top and bottom navigation bars designed for application layouts, dashboards, and sticky action footers.</p>

    <!-- Header Bar Demos -->
    <div style="margin-top: 32px;">
      <h3>PPHeaderBar</h3>
      <p>A top navigation bar for searching, branding, or profile actions.</p>
      
      <div class="demo-grid">
        <div class="demo-box" style="padding: 0; background: #f1f5f9; overflow: hidden; border: 1px solid #e2e8f0; height: 200px;">
          <PPHeaderBar theme="light" height="64px">
            <template #left>
              <div style="font-weight: bold; font-size: 18px; color: #1e293b;">App Logo</div>
            </template>
            <template #center>
              <div style="width: 200px; height: 36px; background: #f1f5f9; border-radius: 18px; display: flex; align-items: center; padding: 0 16px; font-size: 14px; color: #64748b; border: 1px solid #cbd5e1;">Search...</div>
            </template>
            <template #right>
              <div style="display: flex; gap: 16px; align-items: center; color: #64748b;">
                <ion-icon :icon="notificationsOutline" style="font-size: 20px;" />
                <ion-icon :icon="personCircleOutline" style="font-size: 24px;" />
              </div>
            </template>
          </PPHeaderBar>
          <div style="padding: 24px; color: #64748b;">Light Theme (Default)</div>
        </div>

        <div class="demo-box" style="padding: 0; background: #1e293b; overflow: hidden; border: 1px solid #e2e8f0; height: 200px;">
          <PPHeaderBar theme="dark" height="64px" :bordered="false">
            <template #left>
              <ion-icon :icon="menuOutline" style="font-size: 24px;" />
            </template>
            <template #right>
              <div style="display: flex; align-items: center; gap: 8px;">
                <span style="font-size: 14px;">Jane Doe</span>
                <ion-icon :icon="personCircleOutline" style="font-size: 24px;" />
              </div>
            </template>
          </PPHeaderBar>
          <div style="padding: 24px; color: #f8fafc;">Dark Theme</div>
        </div>
      </div>
    </div>

    <!-- Bottom Bar Demos -->
    <div style="margin-top: 32px;">
      <h3>PPBottomBar</h3>
      <p>A footer bar ideal for action buttons or page footers.</p>
      
      <div class="demo-grid">
        <div class="demo-box" style="padding: 0; background: #f1f5f9; overflow: hidden; border: 1px solid #e2e8f0; display: flex; flex-direction: column; height: 200px;">
          <div style="flex: 1; padding: 24px; color: #64748b;">Page content goes here...</div>
          <PPBottomBar align="right">
            <PPButton variant="outline" color="secondary">Cancel</PPButton>
            <PPButton color="primary">Save Changes</PPButton>
          </PPBottomBar>
        </div>

        <div class="demo-box" style="padding: 0; background: #1e293b; overflow: hidden; border: 1px solid #e2e8f0; display: flex; flex-direction: column; height: 200px;">
          <div style="flex: 1; padding: 24px; color: #f8fafc;">Page content goes here...</div>
          <PPBottomBar align="space-between" theme="dark">
            <span style="font-size: 13px; color: #94a3b8;">v1.2.4</span>
            <div style="display: flex; gap: 12px;">
              <span style="font-size: 13px; color: #94a3b8; cursor: pointer;">Help</span>
              <span style="font-size: 13px; color: #94a3b8; cursor: pointer;">Privacy</span>
            </div>
          </PPBottomBar>
        </div>
      </div>
    </div>

    <!-- Usage Section -->
    <div style="margin-top: 40px;">
      <h3>Usage Example</h3>
      <pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;" v-pre><code>&lt;template&gt;
  &lt;PPHeaderBar theme="light"&gt;
    &lt;template #left&gt;Logo&lt;/template&gt;
    &lt;template #right&gt;User Profile&lt;/template&gt;
  &lt;/PPHeaderBar&gt;

  &lt;PPBottomBar align="right"&gt;
    &lt;PPButton variant="outline"&gt;Cancel&lt;/PPButton&gt;
    &lt;PPButton color="primary"&gt;Save&lt;/PPButton&gt;
  &lt;/PPBottomBar&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { PPHeaderBar, PPBottomBar, PPButton } from '@phanna/ui-framework';
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
    &lt;h2&gt;Header &amp; Bottom Bar&lt;/h2&gt;
    &lt;p&gt;Flexible top and bottom navigation bars designed for application layouts, dashboards, and sticky action footers.&lt;/p&gt;

    &lt;!-- Header Bar Demos --&gt;
    &lt;div style="margin-top: 32px;"&gt;
      &lt;h3&gt;PPHeaderBar&lt;/h3&gt;
      &lt;p&gt;A top navigation bar for searching, branding, or profile actions.&lt;/p&gt;
      
      &lt;div class="demo-grid"&gt;
        &lt;div class="demo-box" style="padding: 0; background: #f1f5f9; overflow: hidden; border: 1px solid #e2e8f0; height: 200px;"&gt;
          &lt;PPHeaderBar theme="light" height="64px"&gt;
            &lt;template #left&gt;
              &lt;div style="font-weight: bold; font-size: 18px; color: #1e293b;"&gt;App Logo&lt;/div&gt;
            &lt;/template&gt;
            &lt;template #center&gt;
              &lt;div style="width: 200px; height: 36px; background: #f1f5f9; border-radius: 18px; display: flex; align-items: center; padding: 0 16px; font-size: 14px; color: #64748b; border: 1px solid #cbd5e1;"&gt;Search...&lt;/div&gt;
            &lt;/template&gt;
            &lt;template #right&gt;
              &lt;div style="display: flex; gap: 16px; align-items: center; color: #64748b;"&gt;
                &lt;ion-icon :icon="notificationsOutline" style="font-size: 20px;" /&gt;
                &lt;ion-icon :icon="personCircleOutline" style="font-size: 24px;" /&gt;
              &lt;/div&gt;
            &lt;/template&gt;
          &lt;/PPHeaderBar&gt;
          &lt;div style="padding: 24px; color: #64748b;"&gt;Light Theme (Default)&lt;/div&gt;
        &lt;/div&gt;

        &lt;div class="demo-box" style="padding: 0; background: #1e293b; overflow: hidden; border: 1px solid #e2e8f0; height: 200px;"&gt;
          &lt;PPHeaderBar theme="dark" height="64px" :bordered="false"&gt;
            &lt;template #left&gt;
              &lt;ion-icon :icon="menuOutline" style="font-size: 24px;" /&gt;
            &lt;/template&gt;
            &lt;template #right&gt;
              &lt;div style="display: flex; align-items: center; gap: 8px;"&gt;
                &lt;span style="font-size: 14px;"&gt;Jane Doe&lt;/span&gt;
                &lt;ion-icon :icon="personCircleOutline" style="font-size: 24px;" /&gt;
              &lt;/div&gt;
            &lt;/template&gt;
          &lt;/PPHeaderBar&gt;
          &lt;div style="padding: 24px; color: #f8fafc;"&gt;Dark Theme&lt;/div&gt;
        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- Bottom Bar Demos --&gt;
    &lt;div style="margin-top: 32px;"&gt;
      &lt;h3&gt;PPBottomBar&lt;/h3&gt;
      &lt;p&gt;A footer bar ideal for action buttons or page footers.&lt;/p&gt;
      
      &lt;div class="demo-grid"&gt;
        &lt;div class="demo-box" style="padding: 0; background: #f1f5f9; overflow: hidden; border: 1px solid #e2e8f0; display: flex; flex-direction: column; height: 200px;"&gt;
          &lt;div style="flex: 1; padding: 24px; color: #64748b;"&gt;Page content goes here...&lt;/div&gt;
          &lt;PPBottomBar align="right"&gt;
            &lt;PPButton variant="outline" color="secondary"&gt;Cancel&lt;/PPButton&gt;
            &lt;PPButton color="primary"&gt;Save Changes&lt;/PPButton&gt;
          &lt;/PPBottomBar&gt;
        &lt;/div&gt;

        &lt;div class="demo-box" style="padding: 0; background: #1e293b; overflow: hidden; border: 1px solid #e2e8f0; display: flex; flex-direction: column; height: 200px;"&gt;
          &lt;div style="flex: 1; padding: 24px; color: #f8fafc;"&gt;Page content goes here...&lt;/div&gt;
          &lt;PPBottomBar align="space-between" theme="dark"&gt;
            &lt;span style="font-size: 13px; color: #94a3b8;"&gt;v1.2.4&lt;/span&gt;
            &lt;div style="display: flex; gap: 12px;"&gt;
              &lt;span style="font-size: 13px; color: #94a3b8; cursor: pointer;"&gt;Help&lt;/span&gt;
              &lt;span style="font-size: 13px; color: #94a3b8; cursor: pointer;"&gt;Privacy&lt;/span&gt;
            &lt;/div&gt;
          &lt;/PPBottomBar&gt;
        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- Usage Section --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Usage Example&lt;/h3&gt;
      &lt;pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPHeaderBar theme="light"&amp;gt;
    &amp;lt;template #left&amp;gt;Logo&amp;lt;/template&amp;gt;
    &amp;lt;template #right&amp;gt;User Profile&amp;lt;/template&amp;gt;
  &amp;lt;/PPHeaderBar&amp;gt;

  &amp;lt;PPBottomBar align="right"&amp;gt;
    &amp;lt;PPButton variant="outline"&amp;gt;Cancel&amp;lt;/PPButton&amp;gt;
    &amp;lt;PPButton color="primary"&amp;gt;Save&amp;lt;/PPButton&amp;gt;
  &amp;lt;/PPBottomBar&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { PPHeaderBar, PPBottomBar, PPButton } from '@phanna/ui-framework';
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
import { notificationsOutline, personCircleOutline, menuOutline } from 'ionicons/icons';
import { PPHeaderBar, PPBottomBar, PPButton } from '@phanna/ui-framework';
import { IonIcon } from '@ionic/vue';
&lt;/script&gt;

&lt;style scoped&gt;
.demo-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 24px;
  margin-top: 16px;
}
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { notificationsOutline, personCircleOutline, menuOutline } from 'ionicons/icons';
import { PPHeaderBar, PPBottomBar, PPButton } from '@phanna/ui-framework';
import { IonIcon } from '@ionic/vue';
</script>

<style scoped>
.demo-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 24px;
  margin-top: 16px;
}
</style>
