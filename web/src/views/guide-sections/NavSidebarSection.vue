<template>
  <div class="component-section">
    <h2>Sidebar Navigation</h2>
    <p>A highly customizable sidebar navigation component with support for multiple themes, variants, nested items, and collapsible states.</p>

    <!-- Variants -->
    <div class="demo-grid">
      <!-- Dark Indicator -->
      <div class="demo-box" style="height: 600px; padding: 0; border: 1px solid #e2e8f0;">
        <PPSidebarNavigation
          v-model="active1"
          :items="menuItems"
          theme="dark"
          variant="indicator"
        >
          <template #header>
            <div style="font-size: 18px; font-weight: bold; color: white;">Dark Indicator</div>
          </template>
        </PPSidebarNavigation>
      </div>

      <!-- Light Pill -->
      <div class="demo-box" style="height: 600px; padding: 0; background: #f1f5f9; border: 1px solid #e2e8f0;">
        <PPSidebarNavigation
          v-model="active2"
          :items="menuItems"
          theme="light"
          variant="pill"
        >
          <template #header>
            <div style="font-size: 18px; font-weight: bold; color: #1e293b;">Light Pill</div>
          </template>
        </PPSidebarNavigation>
      </div>
      
      <!-- Collapsed -->
      <div class="demo-box" style="height: 600px; padding: 0; border: 1px solid #e2e8f0;">
        <PPSidebarNavigation
          v-model="active3"
          :items="menuItems"
          theme="dark"
          variant="indicator"
          :collapsed="true"
        >
          <template #header>
            <div style="font-size: 18px; font-weight: bold; color: white;">A</div>
          </template>
        </PPSidebarNavigation>
      </div>
      <!-- M3 Rail -->
      <div class="demo-box" style="height: 600px; padding: 0; border: 1px solid #e2e8f0;">
        <PPSidebarNavigation
          v-model="active4"
          :items="menuItems"
          theme="light"
          variant="m3-rail"
        >
          <template #header>
            <div style="font-size: 18px; font-weight: bold; color: #1e293b;">M3</div>
          </template>
        </PPSidebarNavigation>
      </div>
    </div>

    <!-- Usage Section -->
    <div style="margin-top: 40px;">
      <h3>Usage Example</h3>
      <pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"><code>&lt;template&gt;
  &lt;PPSidebarNavigation
    v-model="activeTab"
    :items="sidebarMenu"
    theme="dark"
    variant="pill"
    :collapsed="isCollapsed"
  &gt;
    &lt;template #header&gt;
      &lt;h2&gt;Logo&lt;/h2&gt;
    &lt;/template&gt;
  &lt;/PPSidebarNavigation&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { ref } from 'vue';
import { homeOutline, settingsOutline } from 'ionicons/icons';
import { PPSidebarNavigation } from '@phanna/ui-framework';

const activeTab = ref('home');
const isCollapsed = ref(false);

const sidebarMenu = [
  {
    groupLabel: 'Main',
    items: [
      { id: 'home', label: 'Dashboard', icon: homeOutline },
      { id: 'settings', label: 'Settings', icon: settingsOutline }
    ]
  }
];
&lt;/script&gt;</code></pre>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { homeOutline, settingsOutline, peopleOutline, documentTextOutline } from 'ionicons/icons';
import { PPSidebarNavigation } from '@phanna/ui-framework';

const active1 = ref('home');
const active2 = ref('home');
const active3 = ref('home');
const active4 = ref('home');

const menuItems = [
  {
    groupLabel: 'Main',
    items: [
      { id: 'home', label: 'Dashboard', icon: homeOutline },
      { id: 'users', label: 'Users', icon: peopleOutline },
    ]
  },
  {
    groupLabel: 'Management',
    items: [
      { 
        id: 'docs', 
        label: 'Documents', 
        icon: documentTextOutline,
        children: [
          { id: 'invoices', label: 'Invoices' },
          { id: 'reports', label: 'Reports' }
        ]
      },
      { id: 'settings', label: 'Settings', icon: settingsOutline }
    ]
  }
];
</script>

<style scoped>
.demo-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 24px;
  margin-top: 24px;
}
</style>
