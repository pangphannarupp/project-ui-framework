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
      <pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;" v-pre><code>&lt;template&gt;
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
    &lt;h2&gt;Sidebar Navigation&lt;/h2&gt;
    &lt;p&gt;A highly customizable sidebar navigation component with support for multiple themes, variants, nested items, and collapsible states.&lt;/p&gt;

    &lt;!-- Variants --&gt;
    &lt;div class="demo-grid"&gt;
      &lt;!-- Dark Indicator --&gt;
      &lt;div class="demo-box" style="height: 600px; padding: 0; border: 1px solid #e2e8f0;"&gt;
        &lt;PPSidebarNavigation
          v-model="active1"
          :items="menuItems"
          theme="dark"
          variant="indicator"
        &gt;
          &lt;template #header&gt;
            &lt;div style="font-size: 18px; font-weight: bold; color: white;"&gt;Dark Indicator&lt;/div&gt;
          &lt;/template&gt;
        &lt;/PPSidebarNavigation&gt;
      &lt;/div&gt;

      &lt;!-- Light Pill --&gt;
      &lt;div class="demo-box" style="height: 600px; padding: 0; background: #f1f5f9; border: 1px solid #e2e8f0;"&gt;
        &lt;PPSidebarNavigation
          v-model="active2"
          :items="menuItems"
          theme="light"
          variant="pill"
        &gt;
          &lt;template #header&gt;
            &lt;div style="font-size: 18px; font-weight: bold; color: #1e293b;"&gt;Light Pill&lt;/div&gt;
          &lt;/template&gt;
        &lt;/PPSidebarNavigation&gt;
      &lt;/div&gt;
      
      &lt;!-- Collapsed --&gt;
      &lt;div class="demo-box" style="height: 600px; padding: 0; border: 1px solid #e2e8f0;"&gt;
        &lt;PPSidebarNavigation
          v-model="active3"
          :items="menuItems"
          theme="dark"
          variant="indicator"
          :collapsed="true"
        &gt;
          &lt;template #header&gt;
            &lt;div style="font-size: 18px; font-weight: bold; color: white;"&gt;A&lt;/div&gt;
          &lt;/template&gt;
        &lt;/PPSidebarNavigation&gt;
      &lt;/div&gt;
      &lt;!-- M3 Rail --&gt;
      &lt;div class="demo-box" style="height: 600px; padding: 0; border: 1px solid #e2e8f0;"&gt;
        &lt;PPSidebarNavigation
          v-model="active4"
          :items="menuItems"
          theme="light"
          variant="m3-rail"
        &gt;
          &lt;template #header&gt;
            &lt;div style="font-size: 18px; font-weight: bold; color: #1e293b;"&gt;M3&lt;/div&gt;
          &lt;/template&gt;
        &lt;/PPSidebarNavigation&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- Usage Section --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Usage Example&lt;/h3&gt;
      &lt;pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPSidebarNavigation
    v-model="activeTab"
    :items="sidebarMenu"
    theme="dark"
    variant="pill"
    :collapsed="isCollapsed"
  &amp;gt;
    &amp;lt;template #header&amp;gt;
      &amp;lt;h2&amp;gt;Logo&amp;lt;/h2&amp;gt;
    &amp;lt;/template&amp;gt;
  &amp;lt;/PPSidebarNavigation&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
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
&lt;/script&gt;

&lt;style scoped&gt;
.demo-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 24px;
  margin-top: 24px;
}
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
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
