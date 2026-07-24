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
      <pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"><code>&lt;template&gt;
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
  </div>
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
