<template>
  <ion-page>
    <ion-header>
      <ion-toolbar color="primary">
        <ion-buttons slot="start">
          <ion-back-button default-href="/"></ion-back-button>
        </ion-buttons>
        <ion-title>Full Component Catalog</ion-title>
      </ion-toolbar>
    </ion-header>
    
    <ion-content class="ion-padding component-guide">
      <p class="guide-intro">
        This is the exhaustive visual catalog for <strong>@bizmob-core/ui-framework</strong>. Every single variant and state of all components is documented below with its copyable code.
      </p>

      <div class="search-bar">
        <BizInput 
          v-model="searchQuery" 
          placeholder="Search components (e.g. Button, Input, Pin)..." 
          clearable 
        />
      </div>

      <!-- ==============================
           Framework Usage Guide
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('framework vue react angular html vanilla setup install')">
        <h2>Framework Usage Guide</h2>
        <p class="custom-guide">
          This library can be used as standard Vue components OR as framework-agnostic Web Components.
        </p>
        
        <div class="variant-group">
          <h3>1. Vue 3 (Default)</h3>
          <p class="custom-guide">Import the plugin and install it in your main app instance.</p>
          <pre class="code-block"><code>import { createApp } from 'vue';
import App from './App.vue';
import UIFramework from '@bizmob-core/ui-framework';
import '@bizmob-core/ui-framework/style.css';

const app = createApp(App);
app.use(UIFramework);
app.mount('#app');</code></pre>
        </div>

        <div class="variant-group">
          <h3>2. React (Using Web Components)</h3>
          <p class="custom-guide">Import the Web Component bundle and register it.</p>
          <pre class="code-block"><code>import React from 'react';
import { registerWebComponents } from '@bizmob-core/ui-framework/web-components';
import '@bizmob-core/ui-framework/style.css';

// Register elements once
registerWebComponents();

export default function App() {
  return &lt;biz-button variant="primary"&gt;React Button&lt;/biz-button&gt;;
}</code></pre>
        </div>

        <div class="variant-group">
          <h3>3. Angular (Using Web Components)</h3>
          <p class="custom-guide">Register components in `main.ts` and add `CUSTOM_ELEMENTS_SCHEMA` to your module.</p>
          <pre class="code-block"><code>import { registerWebComponents } from '@bizmob-core/ui-framework/web-components';
// Register elements
registerWebComponents();

// In your app.module.ts:
import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
@NgModule({
  schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class AppModule { }</code></pre>
        </div>

        <div class="variant-group">
          <h3>4. Plain HTML / Vanilla JS</h3>
          <p class="custom-guide">Load the script as a module and use the tags directly.</p>
          <pre class="code-block"><code>&lt;html&gt;
&lt;head&gt;
  &lt;link rel="stylesheet" href="path/to/ui-framework/dist/style.css"&gt;
  &lt;script type="module"&gt;
    import { registerWebComponents } from './path/to/wc/ui-framework-wc.es.js';
    registerWebComponents();
  &lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
  &lt;biz-button variant="primary"&gt;Native Button&lt;/biz-button&gt;
&lt;/body&gt;
&lt;/html&gt;</code></pre>
        </div>
      </div>

      <!-- ==============================
           Custom CSS & Theming Guide
      ================================ -->
      <div class="guide-section custom-css-guide" v-show="matchesSearch('css theme')">
        <h2>Custom CSS & Theming Guide</h2>
        <p class="custom-guide">
          The UI Framework uses **CSS Variables** so you can easily override the default branding without needing `!important` or complex CSS selectors.
        </p>
        <p class="custom-guide">
          You can override these globally in your `App.vue` or locally using the `style` attribute.
        </p>
        
        <h3>Available Variables</h3>
        <ul class="css-var-list">
          <li><code>--biz-primary-color</code>: The main brand color (default: var(--biz-primary, #003399))</li>
          <li><code>--biz-danger-color</code>: The error/danger color (default: #ff4d4f)</li>
          <li><code>--biz-segment-bg</code>: Background for segment toggle (default: #ffffff)</li>
          <li><code>--biz-segment-btn-active-bg</code>: Active tab background (default: var(--biz-primary-variant, #1a2a5e))</li>
          <li><code>--biz-bottom-sheet-bg</code>: Background for bottom sheet (default: #ffffff)</li>
          <li><code>--biz-bottom-sheet-radius</code>: Border radius for bottom sheet (default: 24px)</li>
        </ul>

        <h3>Example: Customizing BizSegment</h3>
        <div class="component-demo" style="background: #e6f0ff; padding: 20px; border-radius: 12px;">
          <BizSegment v-model="cssSegmentVal" style="--biz-segment-bg: transparent; --biz-segment-border-color: #0066cc; --biz-segment-btn-active-bg: #0066cc;">
            <BizSegmentButton value="opt1">Dark Tab</BizSegmentButton>
            <BizSegmentButton value="opt2">Tab 2</BizSegmentButton>
          </BizSegment>
        </div>
        <pre class="code-block"><code>&lt;!-- Override variables inline using the style attribute --&gt;
&lt;BizSegment 
  v-model="val" 
  style="--biz-segment-bg: transparent; --biz-segment-btn-active-bg: #0066cc;"
&gt;
  &lt;BizSegmentButton value="opt1"&gt;Dark Tab&lt;/BizSegmentButton&gt;
  &lt;BizSegmentButton value="opt2"&gt;Tab 2&lt;/BizSegmentButton&gt;
&lt;/BizSegment&gt;</code></pre>
      </div>

      <!-- ==============================
           Sliders
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizslider range pin step dual knobs slider')">
        <h2>Sliders</h2>
        <p class="guide-desc">A highly customizable slider component supporting single values, ranges, steps, and pins.</p>

        <div class="variant-group">
          <h3>Standard & Range</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 24px;">
            <BizSlider v-model="sliderVal1" label="Standard" :showValue="true" />
            <BizSlider v-model="sliderVal2" label="Dual Knobs (Range)" :dualKnobs="true" :showValue="true" />
          </div>
        </div>

        <div class="variant-group">
          <h3>Snaps, Pins & Icons</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 24px;">
            <BizSlider v-model="sliderVal3" label="Stepped with Pins" :min="0" :max="100" :step="10" :snaps="true" :pin="true" :ticks="true" />
            <BizSlider v-model="sliderVal1" :startIcon="volumeLowOutline" :endIcon="volumeHighOutline" color="secondary" />
            <BizSlider v-model="sliderVal1" label="Disabled Slider" :disabled="true" />
          </div>
        </div>
        <div class="variant-group">
          <h3>Material 3 Style</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 24px;">
            <BizSlider v-model="sliderVal1" label="M3 Thick Track Slider" variant="m3" :showValue="true" />
            <BizSlider v-model="sliderVal2" label="M3 Range Slider" variant="m3" :dualKnobs="true" :showValue="true" />
          </div>
        </div>
      </div>

      <!-- ==============================
           Switches
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizswitch switch toggle ios m3 material')">
        <h2>Switches</h2>
        <p class="guide-desc">A toggle switch component supporting multiple platform styles and Material Design 3.</p>

        <div class="variant-group">
          <h3>Standard Styles</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;">
            <BizSwitch v-model="switchVal1" label="Standard Toggle" />
            <BizSwitch v-model="switchVal1" label="iOS Mode Toggle" mode="ios" color="secondary" />
            <BizSwitch v-model="switchVal2" label="Disabled Toggle" :disabled="true" />
          </div>
        </div>

        <div class="variant-group">
          <h3>Material 3 & Icon Styles</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;">
            <BizSwitch v-model="switchVal3" label="Material 3 Toggle" variant="m3" />
            <BizSwitch v-model="switchVal3" label="Icon Toggle" variant="icon" color="success" />
          </div>
        </div>
      </div>

      <!-- ==============================
           1. BizButton
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizbutton button')">
        <h2>1. BizButton Variants</h2>
        
        <div class="variant-group">
          <h3>Primary</h3>
          <div class="component-demo">
            <BizButton variant="primary" block>Primary Button</BizButton>
          </div>
          <pre class="code-block"><code>&lt;BizButton variant="primary" block&gt;Primary&lt;/BizButton&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Secondary</h3>
          <div class="component-demo">
            <BizButton variant="secondary" block>Secondary Button</BizButton>
          </div>
          <pre class="code-block"><code>&lt;BizButton variant="secondary" block&gt;Secondary&lt;/BizButton&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Danger</h3>
          <div class="component-demo">
            <BizButton block>Show Error Notification</BizButton>
          </div>
          <pre class="code-block"><code>&lt;BizButton variant="danger" block&gt;Danger&lt;/BizButton&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Outline</h3>
          <div class="component-demo">
            <BizButton variant="outline" block>Outline Button</BizButton>
          </div>
          <pre class="code-block"><code>&lt;BizButton variant="outline" block&gt;Outline&lt;/BizButton&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Disabled State</h3>
          <div class="component-demo">
            <BizButton variant="primary" block disabled>Disabled Button</BizButton>
          </div>
          <pre class="code-block"><code>&lt;BizButton variant="primary" block disabled&gt;Disabled&lt;/BizButton&gt;</code></pre>
        </div>
      </div>

      <!-- ==============================
           1.5 BizButtonGroup
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizbuttongroup group buttons horizontal vertical')">
        <h2>1.5 Button Group</h2>

        <div class="variant-group">
          <h3>Horizontal Group</h3>
          <div class="component-demo">
            <BizButtonGroup>
              <BizButton variant="outline">Left</BizButton>
              <BizButton variant="outline">Middle</BizButton>
              <BizButton variant="outline">Right</BizButton>
            </BizButtonGroup>
          </div>
          <pre class="code-block"><code>&lt;BizButtonGroup&gt;
  &lt;BizButton variant="outline"&gt;Left&lt;/BizButton&gt;
  &lt;BizButton variant="outline"&gt;Middle&lt;/BizButton&gt;
  &lt;BizButton variant="outline"&gt;Right&lt;/BizButton&gt;
&lt;/BizButtonGroup&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Vertical Group</h3>
          <div class="component-demo">
            <BizButtonGroup vertical>
              <BizButton variant="outline" block>Top</BizButton>
              <BizButton variant="outline" block>Middle</BizButton>
              <BizButton variant="outline" block>Bottom</BizButton>
            </BizButtonGroup>
          </div>
          <pre class="code-block"><code>&lt;BizButtonGroup vertical&gt;
  ...
&lt;/BizButtonGroup&gt;</code></pre>
        </div>
      </div>

      <!-- ==============================
           1.6 BizToggleButton
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('biztogglebutton toggle button icon active')">
        <h2>1.6 Toggle Button</h2>

        <div class="variant-group">
          <h3>Toggle Button Variants</h3>
          <div class="component-demo" style="display: flex; gap: 8px;">
            <BizToggleButton v-model="toggleVal1" variant="solid">Solid</BizToggleButton>
            <BizToggleButton v-model="toggleVal2" variant="outline">Outline</BizToggleButton>
            <BizToggleButton v-model="toggleVal3" variant="text">Text</BizToggleButton>
          </div>
          <pre class="code-block"><code>&lt;BizToggleButton v-model="active" variant="outline"&gt;Toggle&lt;/BizToggleButton&gt;</code></pre>
        </div>
      </div>

      <!-- ==============================
           2. BizInfoCard
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizinfocard info card warning')">
        <h2>2. BizInfoCard Variants</h2>
        
        <div class="variant-group">
          <h3>Warning Type</h3>
          <div class="component-demo">
            <BizInfoCard type="warning">This is a warning alert!</BizInfoCard>
          </div>
          <pre class="code-block"><code>&lt;BizInfoCard type="warning"&gt;This is a warning alert!&lt;/BizInfoCard&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Info Type (Default)</h3>
          <div class="component-demo">
            <BizInfoCard type="info">This is a general information card.</BizInfoCard>
          </div>
          <pre class="code-block"><code>&lt;BizInfoCard type="info"&gt;This is a general info card.&lt;/BizInfoCard&gt;</code></pre>
        </div>
      </div>

      <!-- ==============================
           3. BizAccountCard
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizaccountcard account card deposit loan')">
        <h2>3. BizAccountCard Variants</h2>
        
        <div class="variant-group">
          <h3>Deposit Account</h3>
          <div class="component-demo">
            <BizAccountCard type="deposit" :count="6" :balance="12000000.00" currency="$" v-model:isHidden="hideDeposit" />
          </div>
          <pre class="code-block"><code>&lt;BizAccountCard 
  type="deposit" 
  :count="6" 
  :balance="12000000.00" 
  currency="$" 
  v-model:isHidden="hideState" 
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Loan Account</h3>
          <div class="component-demo">
            <BizAccountCard type="loan" :count="4" :balance="450000.00" currency="$" v-model:isHidden="hideLoan" />
          </div>
          <pre class="code-block"><code>&lt;BizAccountCard 
  type="loan" 
  :count="4" 
  :balance="450000.00" 
  currency="$" 
  v-model:isHidden="hideState" 
/&gt;</code></pre>
        </div>
      </div>

      <!-- ==============================
           4. BizActionCard (Grid Colors)
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizactioncard action card')">
        <h2>4. BizActionCard Colors</h2>
        <div style="background: #f4f5f8; padding: 20px; border-radius: 12px; display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
          
          <div class="variant-group">
            <h3>Pink Badge</h3>
            <BizActionCard title="Approval" subtitle="Pending" badgeCount="5" badgeColor="pink" />
            <pre class="code-block"><code>&lt;BizActionCard 
  title="Approval" 
  badgeColor="pink" 
/&gt;</code></pre>
          </div>

          <div class="variant-group">
            <h3>Orange Badge</h3>
            <BizActionCard title="Payment" subtitle="Due" badgeCount="2" badgeColor="orange" />
            <pre class="code-block"><code>&lt;BizActionCard 
  title="Payment" 
  badgeColor="orange" 
/&gt;</code></pre>
          </div>

          <div class="variant-group">
            <h3>Teal Badge</h3>
            <BizActionCard title="Transfer" subtitle="Done" badgeCount="1" badgeColor="teal" />
            <pre class="code-block"><code>&lt;BizActionCard 
  title="Transfer" 
  badgeColor="teal" 
/&gt;</code></pre>
          </div>

          <div class="variant-group">
            <h3>Blue Badge</h3>
            <BizActionCard title="Send" badgeColor="blue" />
            <pre class="code-block"><code>&lt;BizActionCard 
  title="Send" 
  badgeColor="blue" 
/&gt;</code></pre>
          </div>
        </div>
      </div>

      <!-- ==============================
           5. BizIconButton
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('biziconbutton icon button')">
        <h2>5. BizIconButton Variants</h2>
        
        <div class="variant-group" style="background: #f4f5f8; padding: 16px; border-radius: 8px;">
          <h3>Danger</h3>
          <div class="component-demo">
            <BizIconButton color="danger">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle></svg>
            </BizIconButton>
          </div>
          <pre class="code-block"><code>&lt;BizIconButton color="danger"&gt;...&lt;/BizIconButton&gt;</code></pre>
        </div>

        <div class="variant-group" style="background: var(--biz-primary, #003399); padding: 16px; border-radius: 8px; color: white;">
          <h3 style="color: white;">White (on dark backgrounds)</h3>
          <div class="component-demo">
            <BizIconButton color="white" badge>
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path></svg>
            </BizIconButton>
          </div>
          <pre class="code-block"><code>&lt;BizIconButton color="white" badge&gt;...&lt;/BizIconButton&gt;</code></pre>
        </div>

        <div class="variant-group" style="background: #f4f5f8; padding: 16px; border-radius: 8px;">
          <h3>Primary</h3>
          <div class="component-demo">
            <BizIconButton color="primary">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect></svg>
            </BizIconButton>
          </div>
          <pre class="code-block"><code>&lt;BizIconButton color="primary"&gt;...&lt;/BizIconButton&gt;</code></pre>
        </div>
      </div>

      <!-- ==============================
           10. Checkboxes
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizcheckbox checkbox form input group')">
        <h2>10. Checkboxes</h2>

        <div class="variant-group">
          <h3>Standard Checkbox</h3>
          <div class="component-demo">
            <BizCheckbox v-model="hideDeposit" label="Hide deposit amounts" />
          </div>
          <pre class="code-block"><code>&lt;BizCheckbox 
  v-model="isChecked" 
  label="Hide deposit amounts" 
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Checkbox Group</h3>
          <p class="custom-guide">Group multiple checkboxes bound to an array.</p>
          <div class="component-demo">
            <BizCheckboxGroup v-model="selectedFeatures" vertical>
              <BizCheckbox value="transfer" label="Transfers" />
              <BizCheckbox value="payment" label="Bill Payments" />
              <BizCheckbox value="topup" label="Mobile Topup" />
            </BizCheckboxGroup>
            <p style="margin-top: 10px; font-size: 14px;">Selected: {{ selectedFeatures }}</p>
          </div>
          <pre class="code-block"><code>&lt;BizCheckboxGroup v-model="features" vertical&gt;
  &lt;BizCheckbox value="transfer" label="Transfers" /&gt;
  &lt;BizCheckbox value="payment" label="Payments" /&gt;
&lt;/BizCheckboxGroup&gt;</code></pre>
        </div>
      </div>

      <!-- ==============================
           New Components Demos (FAB, Spinner, Radio, Rating)
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizfab floating action button speed dial')">
        <h2>Floating Action Button (FAB)</h2>
        <div class="variant-group" style="min-height: 200px; position: relative;">
          <h3>Standard FAB & Speed Dial</h3>
          <div class="component-demo">
            <BizFab position="bottom-right">
              <template #list>
                <BizFabList side="top">
                  <BizFabAction color="primary" @click="alertVal('Action 1')">1</BizFabAction>
                  <BizFabAction color="danger" @click="alertVal('Action 2')">2</BizFabAction>
                </BizFabList>
              </template>
            </BizFab>
            
            <BizFab position="bottom-left" color="secondary" extended>
              Extended FAB
            </BizFab>
          </div>
        </div>
      </div>

      <div class="guide-section" v-show="matchesSearch('biznumberspinner number spinner increment decrement')">
        <h2>Number Spinner</h2>
        <div class="variant-group">
          <h3>Min 0, Max 10, Step 1</h3>
          <div class="component-demo">
            <BizNumberSpinner v-model="spinnerVal" :min="0" :max="10" :step="1" />
            <p style="margin-top: 10px;">Value: {{ spinnerVal }}</p>
          </div>
        </div>
      </div>

      <div class="guide-section" v-show="matchesSearch('bizradio bizradiogroup radio button group')">
        <h2>Radio & Radio Group</h2>
        <div class="variant-group">
          <h3>Radio Group</h3>
          <div class="component-demo">
            <BizRadioGroup v-model="radioVal">
              <BizRadio value="option1" label="Option 1" />
              <BizRadio value="option2" label="Option 2" />
              <BizRadio value="option3" label="Option 3" />
            </BizRadioGroup>
            <p style="margin-top: 10px;">Selected: {{ radioVal }}</p>
          </div>
        </div>
      </div>

      <div class="guide-section" v-show="matchesSearch('bizrating rating stars')">
        <h2>Rating</h2>
        <div class="variant-group">
          <h3>Interactive & Readonly Rating</h3>
          <div class="component-demo">
            <BizRating v-model="ratingVal" :max="5" />
            <p style="margin-top: 10px;">Rating: {{ ratingVal }}</p>
            <br>
            <BizRating :modelValue="4" :max="5" readonly />
          </div>
        </div>
      </div>

      <!-- ==============================
           Material 3 Bottom Nav
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizbottomnav navigation bar material menu')">
        <h2>Material 3 Navigation Bar</h2>
        <p class="guide-desc">A modern bottom navigation bar following Material Design 3 guidelines.</p>

        <div class="variant-group">
          <h3>Interactive Demo</h3>
          <div class="component-demo">
            <BizBottomNav 
              v-model="navVal"
              :items="[
                { label: 'Home', value: 'home', icon: homeOutline, activeIcon: home },
                { label: 'History', value: 'history', icon: documentTextOutline, activeIcon: documentText },
                { label: 'Messages', value: 'messages', icon: chatbubbleOutline, activeIcon: chatbubble },
                { label: 'Profile', value: 'profile', icon: personOutline, activeIcon: person }
              ]"
            />
          </div>
          <pre class="code-block"><code>&lt;BizBottomNav 
  v-model="currentTab"
  :items="navItems"
/&gt;</code></pre>
        </div>
      </div>

      <!-- ==============================
           Liquid Glass Tab Bar
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('liquid glass tab bar menu ios animated tabs')">
        <h2>Liquid Glass Tab Bar (iOS) & Animated Tabs</h2>
        <p class="guide-desc">A custom floating tab bar with an iOS-style liquid glass (frosted) effect that animates between tab content.</p>

        <div class="variant-group">
          <h3>Interactive Demo</h3>
          <div class="component-demo" style="position: relative; height: 300px; background: url('https://images.unsplash.com/photo-1579546929518-9e396f3cc809?q=80&w=1000&auto=format&fit=crop') center/cover; border-radius: 12px; overflow: hidden;">
            <BizAnimatedTabs v-model="animatedTabVal" :tabs="animatedTabs">
              <template #tab-0>
                <div style="padding: 24px; color: white;">
                  <h3 style="color: white; font-size: 24px;">Welcome Home</h3>
                  <p>Slide transition applies smoothly across tabs.</p>
                </div>
              </template>
              <template #tab-1>
                <div style="padding: 24px; color: white;">
                  <h3 style="color: white; font-size: 24px;">Transaction History</h3>
                  <p>All your recent transactions appear here.</p>
                </div>
              </template>
              <template #tab-2>
                <div style="padding: 24px; color: white;">
                  <h3 style="color: white; font-size: 24px;">Your Profile</h3>
                  <p>Manage your account settings.</p>
                </div>
              </template>
            </BizAnimatedTabs>
          </div>
          <pre class="code-block"><code>&lt;BizAnimatedTabs v-model="activeTab" :tabs="tabs"&gt;
  &lt;template #tab-0&gt;Content 1&lt;/template&gt;
  &lt;template #tab-1&gt;Content 2&lt;/template&gt;
&lt;/BizAnimatedTabs&gt;</code></pre>
        </div>
      </div>

      <!-- ==============================
           Hide App Bar
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizhideappbar hide scroll appbar header')">
        <h2>Hide on Scroll App Bar</h2>
        <p class="guide-desc">A header that seamlessly hides when scrolling down, and reveals when scrolling up.</p>

        <div class="variant-group">
          <h3>Interactive Demo</h3>
          <div class="component-demo" style="height: 400px; padding: 0;">
            <BizHideAppBar :headerHeight="56">
              <template #header>
                <div style="height: 100%; display: flex; align-items: center; padding: 0 16px; background: var(--biz-primary-light, #3880ff); color: white;">
                  <h2 style="margin: 0; font-size: 18px;">My Hidden Header</h2>
                </div>
              </template>
              
              <div style="padding: 16px; display: flex; flex-direction: column; gap: 16px;">
                <div v-for="i in 20" :key="i" style="padding: 16px; background: #fff; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05);">
                  Scroll me up and down! Item {{ i }}
                </div>
              </div>
            </BizHideAppBar>
          </div>
          <pre class="code-block"><code>&lt;BizHideAppBar :headerHeight="56"&gt;
  &lt;template #header&gt;
    &lt;div&gt;My Header&lt;/div&gt;
  &lt;/template&gt;

  &lt;!-- Scrollable content --&gt;
  &lt;div&gt;...&lt;/div&gt;
&lt;/BizHideAppBar&gt;</code></pre>
        </div>
      </div>

      <div class="guide-section" v-show="matchesSearch('bizcollapsingtoolbar collapsing appbar header')">
        <h2>Collapsing Appbar</h2>
        <div class="variant-group">
          <h3>Scroll to Collapse</h3>
          <p class="custom-guide">A Material Design style collapsing toolbar. Scroll the content below to see it shrink!</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;">
            <BizCollapsingToolbar title="Profile" :expandedHeight="200" :collapsedHeight="56">
              <template #background>
                <img src="https://images.unsplash.com/photo-1579546929518-9e396f3cc809?q=80&w=1000&auto=format&fit=crop" alt="bg" />
              </template>
              <template #start>
                <BizIconButton color="white"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></BizIconButton>
              </template>
              
              <template #profile>
                <img src="https://i.pravatar.cc/150?img=68" alt="Profile" style="width: 32px; height: 32px; border-radius: 50%; border: 2px solid white; object-fit: cover; box-shadow: 0 2px 4px rgba(0,0,0,0.2);" />
              </template>
              
              <div style="padding: 24px;">
                <p v-for="i in 10" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;">
                  Scrollable content block {{ i }}. Keep scrolling to see the header collapse.
                </p>
              </div>
            </BizCollapsingToolbar>
          </div>
        </div>
        
        <div class="variant-group">
          <h3>Standard Header (No Profile)</h3>
          <p class="custom-guide">Without a profile picture, the title scales and aligns correctly by itself. Here it moves to the center when collapsed.</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;">
            <BizCollapsingToolbar title="Dashboard" :expandedHeight="200" :collapsedHeight="56" centerTitleOnCollapse>
              <template #background>
                <img src="https://images.unsplash.com/photo-1550684848-fac1c5b4e853?q=80&w=1000&auto=format&fit=crop" alt="bg" />
              </template>
              <template #start>
                <BizIconButton color="white"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></BizIconButton>
              </template>
              
              <div style="padding: 24px;">
                <p v-for="i in 10" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;">
                  Scrollable content block {{ i }}. Keep scrolling to see the header collapse.
                </p>
              </div>
            </BizCollapsingToolbar>
          </div>
        </div>
      </div>

      <div class="guide-section" v-show="matchesSearch('bizpulltorefresh pull to refresh swipe down list')">
        <h2>Pull to Refresh</h2>
        <div class="variant-group">
          <h3>Interactive Refresher</h3>
          <p class="custom-guide">Drag the list down inside this container to trigger a refresh!</p>
          <div class="component-demo" style="height: 300px; padding: 0; border-radius: 12px; overflow: hidden; position: relative; border: 1px solid #ddd;">
            <BizPullToRefresh @refresh="handleRefresh">
              <div style="padding: 16px;">
                <div v-for="i in 15" :key="i" style="padding: 16px; border-bottom: 1px solid #eee; background: white;">
                  Item {{ i }} in the scrollable list
                </div>
              </div>
            </BizPullToRefresh>
          </div>
        </div>
      </div>

      <div class="guide-section" v-show="matchesSearch('bizimagetransition transition animate image detail list')">
        <h2>Image Transition (List to Detail)</h2>
        <div class="variant-group">
          <h3>Seamless Fullscreen Expansion</h3>
          <p class="custom-guide">Tap the thumbnail to see it expand perfectly into a full-screen detail view!</p>
          <div class="component-demo" style="display: flex; gap: 16px; align-items: center;">
            <div style="width: 60px; height: 60px; border-radius: 50%; overflow: hidden;">
              <BizImageTransition>
                <template #image>
                  <img 
                    src="https://images.unsplash.com/photo-1579546929518-9e396f3cc809?q=80&w=1000&auto=format&fit=crop" 
                    alt="Thumbnail"
                  />
                </template>
                <template #detail>
                  <div style="padding: 24px; color: #333;">
                    <h2 style="margin-top: 0; font-size: 28px;">Jane Doe</h2>
                    <p style="font-size: 16px; line-height: 1.5; color: #666;">
                      This image expanded beautifully without needing a route transition! 
                      Click the back button in the top left corner to collapse it right back into the list.
                    </p>
                  </div>
                </template>
              </BizImageTransition>
            </div>
            <div>
              <strong style="display: block; font-size: 16px;">Jane Doe</strong>
              <span style="color: #666; font-size: 14px;">Tap image to view profile</span>
            </div>
          </div>
        </div>
      </div>

      <div class="guide-section" v-show="matchesSearch('bizswipeitem swipe actions list')">
        <h2>Swipe Actions (List Items)</h2>
        <div class="variant-group">
          <h3>Swipe Left & Right</h3>
          <p class="custom-guide">Swipe horizontally to reveal actions. Supports rubber-banding physics.</p>
          <div class="component-demo" style="padding: 0; background: transparent; border-radius: 12px; overflow: hidden; border: 1px solid #eee;">
            <BizSwipeItem style="border-bottom: 1px solid #eee;">
              <template #left>
                <div style="background: #28ba62;" @click="alertVal('Pinned!')">
                  Pin
                </div>
              </template>
              <template #right>
                <div style="background: #ffc409; color: #333;" @click="alertVal('Edited!')">
                  Edit
                </div>
                <div style="background: #eb445a;" @click="alertVal('Deleted!')">
                  Delete
                </div>
              </template>
              <div style="padding: 16px; background: white;">
                <h4 style="margin: 0; color: #333;">Swipe me both ways</h4>
                <p style="margin: 4px 0 0; color: #666; font-size: 14px;">I have actions on both sides!</p>
              </div>
            </BizSwipeItem>
            
            <BizSwipeItem>
              <template #right>
                <div style="background: #eb445a;" @click="alertVal('Deleted!')">
                  Delete
                </div>
              </template>
              <div style="padding: 16px; background: white;">
                <h4 style="margin: 0; color: #333;">Swipe me left only</h4>
                <p style="margin: 4px 0 0; color: #666; font-size: 14px;">Only a delete button on the right.</p>
              </div>
            </BizSwipeItem>
          </div>
        </div>
      </div>

      <div class="guide-section" v-show="matchesSearch('bizedBoxChart bizLineChart bizDonutChart bizPieChart bizRadarChart bizProgressGauge bizScatterChart bizFunnelChart chart graph')">
        <h2>Charts & Graphs</h2>

        <div class="variant-group">
          <h3>Scatter & Bubble Chart</h3>
          <BizScatterChart 
            :data="[
              { x: 10, y: 20, r: 12, color: '#eb445a' },
              { x: 30, y: 70, r: 8, color: 'var(--biz-primary-light, #3880ff)' },
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
          <BizFunnelChart 
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
            <BizProgressGauge 
              :value="82"
              :max="100"
              :size="180"
              :thickness="14"
              :gradient="['#3dc2ff', 'var(--biz-primary-light, #3880ff)']"
              label="Performance"
              :format="(val) => val + '%'"
            />
          </div>
          <div>
            <h3 style="text-align: center;">Radar Chart</h3>
            <BizRadarChart 
              :size="180"
              :data="[80, 60, 90, 70, 85]"
              :labels="['Speed', 'Power', 'Agility', 'Stamina', 'Skill']"
              color="#eb445a"
            />
          </div>
        </div>

        
        <div class="variant-group">
          <h3>Line Chart (Gradients & Dashes)</h3>
          <BizLineChart 
            :data="[10, 30, 20, 50, 40, 80, 60]" 
            :labels="['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']"
            :gradient="['var(--biz-primary-light, #3880ff)', '#2dd36f']"
            :dashed="true"
            :showPoints="true"
            :dashedGrid="true"
            :strokeWidth="4"
          />
        </div>

        <div class="variant-group">
          <h3>Bar Chart (Thick Gradients)</h3>
          <BizBarChart 
            :data="[
              { label: 'Jan', value: 40, gradient: ['var(--biz-primary-light, #3880ff)', '#2dd36f'] },
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
            <BizDonutChart 
              :size="140"
              :data="[
                { value: 45, color: 'var(--biz-primary-light, #3880ff)' },
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
            <BizPieChart 
              :size="140"
              :data="[
                { value: 40, color: '#eb445a' },
                { value: 60, color: 'var(--biz-primary-light, #3880ff)' }
              ]"
            />
          </div>
        </div>
      </div>

      <!-- ==============================
           6. BizInput Forms
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizinput biztextfield bizselect biztransferlist bizphoneinput bizotpinput bizfileupload file upload form phone otp password text field input select dropdown transfer list')">
        <h2>6. Form Inputs</h2>
        
        <div class="variant-group">
          <h3>BizTextField Styles</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;">
            <BizTextField v-model="textVal" label="Outlined (Default)" placeholder="Enter text" clearable />
            <BizTextField v-model="textVal" variant="filled" label="Filled" placeholder="Enter text" clearable />
            <BizTextField v-model="textVal" variant="underlined" label="Underlined" placeholder="Enter text" clearable />
          </div>
          <pre class="code-block"><code>&lt;BizTextField variant="outlined|filled|underlined" label="..." clearable /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizSelect Styles</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;">
            <BizSelect v-model="selectVal" label="Outlined (Default)" :options="[{label: 'Option 1', value: 1}, {label: 'Option 2', value: 2}]" placeholder="Select an option" />
            <BizSelect v-model="selectVal" variant="filled" label="Filled" :options="[{label: 'Option A', value: 'a'}, {label: 'Option B', value: 'b'}]" placeholder="Choose..." />
            <BizSelect v-model="selectVal" variant="underlined" label="Underlined" :options="[{label: 'Yes', value: 'yes'}, {label: 'No', value: 'no'}]" placeholder="Pick one" />
          </div>
          <pre class="code-block"><code>&lt;BizSelect variant="outlined|filled|underlined" label="..." :options="[...]" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizTransferList Styles</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 32px;">
            <BizTransferList v-model="transferVal" variant="outlined" :data="transferOptions" :titles="['Available (Outlined)', 'Selected (Outlined)']" />
            <BizTransferList v-model="transferVal" variant="filled" :data="transferOptions" :titles="['Available (Filled)', 'Selected (Filled)']" />
            <BizTransferList v-model="transferVal" variant="underlined" :data="transferOptions" :titles="['Available (Underlined)', 'Selected (Underlined)']" />
          </div>
          <pre class="code-block"><code>&lt;BizTransferList v-model="selectedKeys" variant="outlined" :data="options" :titles="['Source', 'Target']" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Standard Text Input</h3>
          <div class="component-demo">
            <BizInput v-model="textVal" label="Username" placeholder="Enter name" clearable />
          </div>
          <pre class="code-block"><code>&lt;BizInput v-model="text" label="Username" clearable /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Password Input (with icon)</h3>
          <div class="component-demo">
            <BizInput v-model="textVal" label="Password" type="password" placeholder="Enter pass" clearable>
              <template #iconLeft>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
              </template>
            </BizInput>
          </div>
          <pre class="code-block"><code>&lt;BizInput type="password"&gt;
  &lt;template #iconLeft&gt;...&lt;/template&gt;
&lt;/BizInput&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Phone Input</h3>
          <div class="component-demo">
            <BizPhoneInput v-model="phoneVal" label="Phone Number" placeholder="12 *** *66" />
          </div>
          <pre class="code-block"><code>&lt;BizPhoneInput v-model="phone" countryCode="+855" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>File Upload</h3>
          <div class="component-demo">
            <BizFileUpload 
              multiple 
              accept=".pdf,image/*" 
              :maxSize="5 * 1024 * 1024"
              :files="uploadedFiles"
              @select="handleFileUpload"
              @remove="handleFileRemove"
              @retry="handleFileRetry"
            />
          </div>
          <pre class="code-block"><code>&lt;BizFileUpload multiple accept=".pdf,image/*" :files="files" @select="..." /&gt;</code></pre>
        </div>
        

        <div class="variant-group">
          <h3>OTP Input (6-digit)</h3>
          <div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px;">
            <BizOtpInput v-model="otpVal" :length="6" />
          </div>
          <pre class="code-block"><code>&lt;BizOtpInput v-model="otp" :length="6" /&gt;</code></pre>
        </div>
      </div>

      <!-- ==============================
           7. Other Structural Components
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizsegment bizcompanyselector bizuserprofile bizbottomsheet bizbottomnav segment company user profile bottom sheet nav structure')">
        <h2>7. Structural Components</h2>

        <div class="variant-group">
          <h3>BizSegment (Toggle)</h3>
          <div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px;">
            <BizSegment v-model="segmentVal" style="--biz-segment-bg: white;">
              <BizSegmentButton value="opt1">Option 1</BizSegmentButton>
              <BizSegmentButton value="opt2">Option 2</BizSegmentButton>
            </BizSegment>
          </div>
          <pre class="code-block"><code>&lt;BizSegment v-model="val"&gt;
  &lt;BizSegmentButton value="1"&gt;Tab 1&lt;/BizSegmentButton&gt;
&lt;/BizSegment&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizAnimatedSegment</h3>
          <p class="custom-guide">Wraps BizSegment to provide smooth animated transitions between content sections.</p>
          <div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px; height: 180px;">
            <BizAnimatedSegment v-model="animatedSegmentVal" :segments="animatedSegments">
              <template #segment-opt1>
                <div style="padding: 16px; background: white; border-radius: 8px; margin-top: 16px; box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
                  <h4 style="margin-top:0;">Option 1 Content</h4>
                  <p style="margin-bottom:0;">This content slides in smoothly!</p>
                </div>
              </template>
              <template #segment-opt2>
                <div style="padding: 16px; background: white; border-radius: 8px; margin-top: 16px; box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
                  <h4 style="margin-top:0;">Option 2 Content</h4>
                  <p style="margin-bottom:0;">Here is some different content.</p>
                </div>
              </template>
              <template #segment-opt3>
                <div style="padding: 16px; background: white; border-radius: 8px; margin-top: 16px; box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
                  <h4 style="margin-top:0;">Option 3 Content</h4>
                  <p style="margin-bottom:0;">And even more content.</p>
                </div>
              </template>
            </BizAnimatedSegment>
          </div>
          <pre class="code-block"><code>&lt;BizAnimatedSegment v-model="val" :segments="segments"&gt;
  &lt;template #segment-opt1&gt;...&lt;/template&gt;
&lt;/BizAnimatedSegment&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizCompanySelector</h3>
          <div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px;">
            <BizCompanySelector companyName="CHOKCHEY FINANCE PLC" companyType="Individual" />
          </div>
          <pre class="code-block"><code>&lt;BizCompanySelector 
  companyName="CHOKCHEY" 
  companyType="Individual" 
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizUserProfile</h3>
          <div class="component-demo" style="background: var(--biz-primary, #003399); padding: 20px; border-radius: 12px;">
            <BizUserProfile userName="SOM MONYROTTANA" role="Master User" :isVerified="true" />
          </div>
          <pre class="code-block"><code>&lt;BizUserProfile 
  userName="Name" 
  role="Master User" 
  :isVerified="true" 
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizBottomSheet (Action Menu)</h3>
          <p class="custom-guide" style="margin-bottom: 8px;"><strong>Props:</strong> <code>title</code>, <code>modelValue</code> (controls visibility)</p>
          <div class="component-demo">
            <BizButton variant="secondary" @click="showBottomSheet = true">Open Standard Bottom Sheet</BizButton>
            
            <!-- We render the sheet locally for the demo -->
            <BizBottomSheet v-model="showBottomSheet" title="Select Action">
              <div style="padding: 16px; text-align: center;">
                <p>This is the content inside the bottom sheet.</p>
                <BizButton variant="primary" block @click="showBottomSheet = false">Close</BizButton>
              </div>
            </BizBottomSheet>
          </div>
          <pre class="code-block"><code>&lt;BizBottomSheet v-model="isOpen" title="Select Action"&gt;...&lt;/BizBottomSheet&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizBiometricSheet</h3>
          <p class="custom-guide" style="margin-bottom: 8px;"><strong>Props:</strong> <code>type</code> ('both', 'face', 'fingerprint')</p>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 8px;">
            <BizButton variant="outline" @click="showBioBoth = true">Open Biometric (Both)</BizButton>
            <BizButton variant="outline" @click="showBioFace = true">Open Biometric (Face ID)</BizButton>
            <BizButton variant="outline" @click="showBioFinger = true">Open Biometric (Fingerprint ID)</BizButton>
            
            <BizBiometricSheet v-model="showBioBoth" type="both" @setup="alertVal" />
            <BizBiometricSheet v-model="showBioFace" type="face" @setup="alertVal" />
            <BizBiometricSheet v-model="showBioFinger" type="fingerprint" @setup="alertVal" />
          </div>
          <pre class="code-block"><code>&lt;BizBiometricSheet 
  v-model="isOpen" 
  type="both" 
  @setup="handleSetup" 
/&gt;</code></pre>
        </div>


      </div>

      <!-- ==============================
           8. PIN Security Components
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizpindots bizkeypad pin dots security keypad number')">
        <h2>8. PIN Security Components</h2>

        <div class="variant-group">
          <h3>BizPinDots</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>length</code>, <code>value</code>, <code>error</code>, <code>errorText</code>, <code>success</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; padding: 40px; border-radius: 12px; display: flex; flex-direction: column; gap: 20px;">
            <BizPinDots :length="6" value="123" />
            <BizPinDots :length="6" value="12345" :error="true" />
            <BizPinDots :length="6" value="123456" :success="true" />
          </div>
          <pre class="code-block"><code>&lt;BizPinDots :length="6" value="123" /&gt;
&lt;BizPinDots :length="6" value="123" :error="true" /&gt;
&lt;BizPinDots :length="6" value="123456" :success="true" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizKeypad</h3>
          <p class="custom-guide"><strong>Events:</strong> <code>@press</code> (emits value string or 'backspace')</p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <!-- Render keypad live -->
            <BizKeypad @press="handlePress" />
            <div style="padding: 16px; text-align: center; color: #666;">
              Last Pressed: <strong>{{ keypadDemoVal }}</strong>
            </div>
          </div>
          <pre class="code-block"><code>&lt;BizKeypad @press="handlePress" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Secure Keypad</h3>
          <p class="custom-guide">A randomized secure keypad with a shield icon. The numbers shuffle every time the component mounts to prevent shoulder-surfing!</p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <div style="padding: 16px; text-align: center; color: #666; font-size: 18px;">
              Secure PIN: <strong>{{ secureKeypadVal || 'Enter PIN' }}</strong>
            </div>
            <BizSecureKeypad @press="handleSecureKeypadPress" />
          </div>
          <pre class="code-block"><code>&lt;BizSecureKeypad @press="handleSecureKeypadPress" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Secure Virtual Keyboard</h3>
          <p class="custom-guide">A full randomized QWERTY-style secure keyboard (dark theme).</p>
          <div class="component-section" id="biz-secure-keyboard">
            <h2>BizSecureKeyboard</h2>
            <p>A full randomized QWERTY keyboard with custom layouts.</p>
            <div class="demo-container bg-dark" style="position: relative; overflow: visible;">
              <div class="mb-4" style="color: white;">
                <div class="text-sm text-gray-400">English Input</div>
                <div class="text-xl tracking-widest font-mono">{{ keypadDemoVal || 'Tap to type' }}</div>
              </div>
              <BizSecureKeyboard @press="handleKeyboardPress" />
            </div>
          </div>

          <!-- Secure Khmer Keyboard -->
          <div class="component-section" id="biz-khmer-keyboard">
            <h2>BizKhmerKeyboard</h2>
            <p>A full randomized Khmer (NiDA) keyboard with custom layouts.</p>
            <div class="demo-container bg-dark" style="position: relative; overflow: visible;">
              <div class="mb-4" style="color: white;">
                <div class="text-sm text-gray-400">Khmer Input</div>
                <div class="text-xl tracking-widest font-mono">{{ khmerDemoVal || 'Tap to type' }}</div>
              </div>
              <BizKhmerKeyboard @press="handleKhmerPress" />
            </div>
          </div>
        </div>

      </div>

      <!-- ==============================
           9. Feedback & Action Sheets
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('biztoast bizconfirmsheet bizreceiveamountsheet feedback alert sheet bottomsheet amount')">
        <h2>9. Feedback & Action Sheets</h2>

        <div class="variant-group">
          <h3>BizToast</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>modelValue</code>, <code>message</code>, <code>duration</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; padding: 20px; border-radius: 12px; display: flex; flex-direction: column; gap: 12px;">
            <BizButton @click="showToast = true">Trigger Toast</BizButton>
            <BizToast v-model="showToast" message="User has been deleted." />
          </div>
          <pre class="code-block"><code>&lt;BizToast v-model="showToast" message="User has been deleted." /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizConfirmSheet</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>modelValue</code>, <code>title</code>, <code>subtitle</code>, <code>confirmText</code>, <code>cancelText</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; padding: 20px; border-radius: 12px; display: flex; flex-direction: column; gap: 12px;">
            <BizButton @click="showConfirmSheet = true">Trigger Confirm Sheet</BizButton>
            <BizConfirmSheet 
              v-model="showConfirmSheet" 
              title="Delete User?"
              subtitle="This action cannot be undone."
              confirmText="Delete"
              cancelText="Cancel"
            />
          </div>
          <pre class="code-block"><code>&lt;BizConfirmSheet 
  v-model="showConfirmSheet" 
  title="Delete User?"
  subtitle="This action cannot be undone."
  confirmText="Delete"
  cancelText="Cancel"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizReceiveAmountSheet</h3>
          <p class="custom-guide"><strong>Events:</strong> <code>@confirm</code> (emits payload with currency and amount)</p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; padding: 20px; border-radius: 12px; display: flex; flex-direction: column; gap: 12px;">
            <BizButton @click="showReceiveAmount = true">Trigger Receive Amount Sheet</BizButton>
            <BizReceiveAmountSheet 
              v-model="showReceiveAmount" 
              @confirm="val => alertVal(`Received ${val.currency} ${val.amount}`)"
            />
          </div>
          <pre class="code-block"><code>&lt;BizReceiveAmountSheet 
  v-model="showReceiveAmount" 
  @confirm="handleConfirm" 
/&gt;</code></pre>
        </div>

      </div>

      <!-- ==============================
           10. Account Saving Cards
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizaccountsavingcard bizreceivingaccountsheet account saving sheet')">
        <h2>10. Account Saving Cards & Sheets</h2>

        <div class="variant-group">
          <h3>BizAccountSavingCard</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>accountName</code>, <code>accountNumber</code>, <code>balance</code>, <code>currency</code>, <code>type</code>, <code>selected</code></p>
          <div class="component-demo" style="background: #e5e5ea; padding: 20px; border-radius: 12px; display: flex; flex-direction: column; gap: 12px;">
            <BizAccountSavingCard 
              accountName="CHANT TY'S Savings"
              accountNumber="1-120-14354545-8"
              :balance="12000000.00"
              currency="USD"
              type="Savings"
              :selected="true"
            />
            <BizAccountSavingCard 
              accountName="CHANT TY'S Savings"
              accountNumber="1-120-14354545-8"
              :balance="420000"
              currency="KHR"
              type="Current"
              :selected="false"
            />
          </div>
          <pre class="code-block"><code>&lt;BizAccountSavingCard 
  accountName="CHANT TY'S Savings"
  accountNumber="1-120-14354545-8"
  :balance="12000000.00"
  currency="USD"
  type="Savings"
  :selected="true"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizReceivingAccountSheet</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>modelValue</code>, <code>accounts</code>, <code>selectedAccountId</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; padding: 20px; border-radius: 12px; display: flex; flex-direction: column; gap: 12px;">
            <BizButton @click="showReceivingAccount = true">Select Receiving Account</BizButton>
            <BizReceivingAccountSheet 
              v-model="showReceivingAccount"
              :accounts="demoAccounts"
              :selectedAccountId="selectedReceivingAccount"
              @select="acc => { selectedReceivingAccount = acc.id; alertVal(`Selected ${acc.name}`) }"
            />
          </div>
          <pre class="code-block"><code>&lt;BizReceivingAccountSheet 
  v-model="showReceivingAccount"
  :accounts="demoAccounts"
  :selectedAccountId="selectedReceivingAccount"
  @select="onSelectAccount"
/&gt;</code></pre>
        </div>

      </div>

      <!-- ==============================
           11. BizKhmerCalendar
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizkhmercalendar khmer calendar date picker')">
        <h2>11. Khmer Calendar</h2>

        <div class="variant-group">
          <h3>Standard Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Single' }</code> (default)</p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <BizKhmerCalendar 
              @date-selected="s => alertVal('Selected Date: ' + s.date.toLocaleDateString() + '\nKhmer Date: ' + s.fullText)"
            />
          </div>
          <pre class="code-block"><code>&lt;BizKhmerCalendar @date-selected="onSelect" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Range Selection & Limits</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Range', minDate: ..., maxDate: ... }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <BizKhmerCalendar 
              :config="{ 
                selectionMode: 'Range', 
                minDate: new Date(new Date().getFullYear(), new Date().getMonth(), 1), 
                maxDate: new Date(new Date().getFullYear(), new Date().getMonth() + 1, 0) 
              }"
              @range-selected="(start, end) => alertVal('Range: ' + (start ? start.date.toLocaleDateString() : '') + ' to ' + (end ? end.date.toLocaleDateString() : ''))"
            />
          </div>
          <pre class="code-block"><code>&lt;BizKhmerCalendar :config="{ selectionMode: 'Range', minDate, maxDate }" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Week Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Week' }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <BizKhmerCalendar 
              :config="{ selectionMode: 'Week' }"
              @range-selected="(start, end) => alertVal('Week: ' + (start ? start.date.toLocaleDateString() : '') + ' to ' + (end ? end.date.toLocaleDateString() : ''))"
            />
          </div>
          <pre class="code-block"><code>&lt;BizKhmerCalendar :config="{ selectionMode: 'Week' }" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Calendar Bottom Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizKhmerCalendarSheet&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <BizButton @click="showCalendarSheet = true">Open Calendar Sheet</BizButton>
            <BizKhmerCalendarSheet 
              v-model="showCalendarSheet"
              title="Select a Date"
              :showActionButtons="true"
              @confirm="(d) => { alertVal('Confirmed: ' + (d ? d.date.toLocaleDateString() : '')); showCalendarSheet = false; }"
              @cancel="showCalendarSheet = false"
            />
          </div>
          <pre class="code-block"><code>&lt;BizKhmerCalendarSheet v-model="isOpen" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Calendar Alert Popup</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizKhmerCalendarAlert&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <BizButton @click="showAlertCalendar = true">Open Calendar Alert</BizButton>
            <BizKhmerCalendarAlert 
              v-model="showAlertCalendar"
              title="Select a Date"
              :showActionButtons="true"
              @confirm="(d) => { alertVal('Confirmed: ' + (d ? d.date.toLocaleDateString() : '')); showAlertCalendar = false; }"
              @cancel="showAlertCalendar = false"
            />
          </div>
          <pre class="code-block"><code>&lt;BizKhmerCalendarAlert v-model="isOpen" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Direct TS Utility Access (KhmerDate.ts)</h3>
          <p class="custom-guide">You can import the raw <code>KhmerDate.ts</code> file directly from the framework's dist folder. This allows developers to read or modify the unminified business logic directly in their own build process!</p>
          <div class="component-demo" style="background: #f4f6f9; padding: 20px; border-radius: 12px; font-size: 16px;">
            <strong>Today is:</strong> {{ khmerDateDemo }}
          </div>
          <pre class="code-block" v-pre><code>import { KhmerDate } from '@bizmob-core/ui-framework/dist/KhmerDate';

const khmerDate = new KhmerDate();
const dateObj = khmerDate.toLunar();
console.log(`${dateObj.lunarDay} ខែ${dateObj.lunarMonth} ឆ្នាំ${dateObj.zodiacYear}`);</code></pre>
        </div>

        <div class="variant-group">
          <h3>Customizing KhmerDate.ts in Your Project Scope</h3>
          <div class="guide-intro" style="background: #fff8e1; border-left-color: #fbbc05;">
            <strong>Best Practice:</strong> Modifying files directly inside <code>node_modules</code> is an anti-pattern because your changes will be erased during the next package installation. Since the framework provides the unminified <code>KhmerDate.ts</code>, you can easily copy it into your own project and apply specific business logic.
          </div>
          
          <ol class="custom-guide" style="padding-left: 20px; margin-bottom: 24px;">
            <li style="margin-bottom: 12px;">
              <strong>Locate the source file:</strong> Find the unminified TypeScript file at <code>node_modules/@bizmob-core/ui-framework/dist/KhmerDate.ts</code>.
            </li>
            <li style="margin-bottom: 12px;">
              <strong>Copy to your project:</strong> Copy the file into a utility directory in your local source code (e.g., <code>src/utils/KhmerDate.ts</code>).
            </li>
            <li style="margin-bottom: 12px;">
              <strong>Apply customizations:</strong> Edit your local copy to modify date calculations, override string formats, or inject your custom business logic.
            </li>
            <li style="margin-bottom: 12px;">
              <strong>Update imports:</strong> Point your application's imports to your newly customized local file.
            </li>
          </ol>

          <pre class="code-block" v-pre><code>// ❌ Instead of importing from the framework:
// import { KhmerDate } from '@bizmob-core/ui-framework/dist/KhmerDate';

// ✅ Import your locally customized version:
import { KhmerDate } from '@/utils/KhmerDate';

const khmerDate = new KhmerDate();
const dateObj = khmerDate.toLunar();
// Now executes YOUR specific business logic!</code></pre>
        </div>
      </div>

      <!-- ==============================
           12. BizCalendar
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizcalendar standard calendar date picker')">
        <h2>12. Standard Calendar</h2>

        <div class="variant-group">
          <h3>Standard Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Single' }</code> (default)</p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <BizCalendar 
              @date-selected="s => alertVal('Selected Date: ' + s.date.toLocaleDateString())"
            />
          </div>
          <pre class="code-block"><code>&lt;BizCalendar @date-selected="onSelect" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Range Selection & Limits</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Range', minDate: ..., maxDate: ... }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <BizCalendar 
              :config="{ 
                selectionMode: 'Range', 
                minDate: new Date(new Date().getFullYear(), new Date().getMonth(), 1), 
                maxDate: new Date(new Date().getFullYear(), new Date().getMonth() + 1, 0) 
              }"
              @range-selected="(start, end) => alertVal('Range: ' + (start ? start.date.toLocaleDateString() : '') + ' to ' + (end ? end.date.toLocaleDateString() : ''))"
            />
          </div>
          <pre class="code-block"><code>&lt;BizCalendar :config="{ selectionMode: 'Range', minDate, maxDate }" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Calendar Bottom Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizCalendarSheet&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <BizButton @click="showStdCalendarSheet = true">Open Calendar Sheet</BizButton>
            <BizCalendarSheet 
              v-model="showStdCalendarSheet"
              title="Select a Date"
              :showActionButtons="true"
              @confirm="(d) => { alertVal('Confirmed: ' + (d ? d.date.toLocaleDateString() : '')); showStdCalendarSheet = false; }"
              @cancel="showStdCalendarSheet = false"
            />
          </div>
          <pre class="code-block"><code>&lt;BizCalendarSheet v-model="isOpen" /&gt;</code></pre>
        </div>
      </div>

      <!-- ==============================
           13. BizMonthPicker
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizmonthpicker month picker')">
        <h2>13. Month Picker</h2>

        <div class="variant-group">
          <h3>Standard Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Single' }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <BizMonthPicker 
              @month-selected="s => alertVal('Selected Month: ' + s.month + '/' + s.year)"
            />
          </div>
          <pre class="code-block"><code>&lt;BizMonthPicker @month-selected="onSelect" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Range Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Range' }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <BizMonthPicker 
              :config="{ selectionMode: 'Range' }"
              @range-selected="(start, end) => alertVal('Range: ' + (start ? start.month + '/' + start.year : '') + ' to ' + (end ? end.month + '/' + end.year : ''))"
            />
          </div>
          <pre class="code-block"><code>&lt;BizMonthPicker :config="{ selectionMode: 'Range' }" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Month Picker Bottom Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizMonthPickerSheet&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <BizButton @click="showMonthPickerSheet = true">Open Month Sheet</BizButton>
            <BizMonthPickerSheet 
              v-model="showMonthPickerSheet"
              title="Select a Month"
              :showActionButtons="true"
              @confirm="(s) => { alertVal('Confirmed: ' + (s ? s.month + '/' + s.year : '')); showMonthPickerSheet = false; }"
              @cancel="showMonthPickerSheet = false"
            />
          </div>
          <pre class="code-block"><code>&lt;BizMonthPickerSheet v-model="isOpen" /&gt;</code></pre>
        </div>
      </div>

      <!-- ==============================
           13.5. BizYearPicker
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizyearpicker year picker')">
        <h2>13.5. Year Picker</h2>

        <div class="variant-group">
          <h3>Standard Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Single' }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <BizYearPicker 
              @year-selected="s => alertVal('Selected Year: ' + s.year)"
            />
          </div>
          <pre class="code-block"><code>&lt;BizYearPicker @year-selected="onSelect" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Range Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Range' }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <BizYearPicker 
              :config="{ selectionMode: 'Range' }"
              @range-selected="(start, end) => alertVal('Range: ' + (start ? start.year : '') + ' to ' + (end ? end.year : ''))"
            />
          </div>
          <pre class="code-block"><code>&lt;BizYearPicker :config="{ selectionMode: 'Range' }" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Year Picker Bottom Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizYearPickerSheet&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <BizButton @click="showYearPickerSheet = true">Open Year Sheet</BizButton>
            <BizYearPickerSheet 
              v-model="showYearPickerSheet"
              title="Select a Year"
              :showActionButtons="true"
              @confirm="(s) => { alertVal('Confirmed: ' + (s ? s.year : '')); showYearPickerSheet = false; }"
              @cancel="showYearPickerSheet = false"
            />
          </div>
          <pre class="code-block"><code>&lt;BizYearPickerSheet v-model="isOpen" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Year Picker Alert</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizYearPickerAlert&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <BizButton @click="showYearPickerAlert = true">Open Year Alert</BizButton>
            <BizYearPickerAlert 
              v-model="showYearPickerAlert"
              title="Select a Year"
              :showActionButtons="true"
              @confirm="(s) => { alertVal('Confirmed: ' + (s ? s.year : '')); showYearPickerAlert = false; }"
              @cancel="showYearPickerAlert = false"
            />
          </div>
          <pre class="code-block"><code>&lt;BizYearPickerAlert v-model="isOpen" /&gt;</code></pre>
        </div>
      </div>

      <!-- ==============================
           14. BizTimePicker
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('biztimepicker time picker sheet alert')">
        <h2>14. Time Picker</h2>

        <div class="variant-group">
          <h3>Standard Time Picker</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizTimePicker&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden; padding: 16px;">
            <BizTimePicker 
              v-model="timeVal"
              @change="(v) => alertVal('Selected Time: ' + v)"
            />
          </div>
          <pre class="code-block"><code>&lt;BizTimePicker v-model="timeVal" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Time Picker Bottom Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizTimePickerSheet&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <BizButton @click="showTimePickerSheet = true">Open Time Sheet</BizButton>
            <BizTimePickerSheet 
              v-model="showTimePickerSheet"
              v-model:timeValue="timeSheetVal"
              title="Select a Time"
              :showActionButtons="true"
              @confirm="() => { alertVal('Confirmed Time: ' + timeSheetVal); showTimePickerSheet = false; }"
              @cancel="showTimePickerSheet = false"
            />
          </div>
          <pre class="code-block"><code>&lt;BizTimePickerSheet v-model="isOpen" v-model:timeValue="val" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Time Picker Alert</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizTimePickerAlert&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <BizButton @click="showTimePickerAlert = true">Open Time Alert</BizButton>
            <BizTimePickerAlert 
              v-model="showTimePickerAlert"
              v-model:timeValue="timeAlertVal"
              title="Select a Time"
              @confirm="() => { alertVal('Confirmed Time: ' + timeAlertVal); showTimePickerAlert = false; }"
              @cancel="showTimePickerAlert = false"
            />
          </div>
          <pre class="code-block"><code>&lt;BizTimePickerAlert v-model="isOpen" v-model:timeValue="val" /&gt;</code></pre>
        </div>
      </div>

      <!-- ==============================
           15. BizAccountReorderList
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizaccountreorderlist account list drag drop')">
        <h2>14. Account Reorder List</h2>

        <div class="variant-group">
          <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
            <h3>Interactive Reorder List</h3>
            <BizButton size="small" @click="isReorderMode = !isReorderMode">
              {{ isReorderMode ? 'Done' : 'Sort by' }}
            </BizButton>
          </div>
          <p class="custom-guide">Toggle Sort mode to see drag handles. Drag to reorder.</p>
          <div class="component-demo" style="background: #f4f6f9; padding: 20px; border-radius: 12px;">
            <BizAccountReorderList 
              :accounts="demoAccounts"
              :isReorderMode="isReorderMode"
              @update:accounts="newAccs => demoAccounts = newAccs"
              @action-click="acc => alertVal('Action clicked for ' + acc.accountName)"
            >
              <template #item="{ item, isReorderMode: reorderMode, onUpdateHidden, dragListeners }">
                <BizAccountListCard 
                  :accountName="item.accountName || item.name"
                  :accountNumber="item.accountNumber || item.number"
                  :balance="item.balance"
                  :currency="item.currency"
                  :type="item.type"
                  :isHidden="item.isHidden"
                  @update:isHidden="val => onUpdateHidden(val)"
                  @action-click="() => alertVal('Action clicked for ' + (item.accountName || item.name))"
                  @click="() => !reorderMode && alertVal('Item clicked for ' + (item.accountName || item.name))"
                >
                  <template #action>
                    <div 
                      v-if="reorderMode" 
                      style="color: #999; cursor: grab; padding: 0; display: flex; align-items: center; justify-content: center;"
                      v-on="dragListeners"
                    >
                      <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="4" y1="12" x2="20" y2="12"></line>
                        <line x1="4" y1="6" x2="20" y2="6"></line>
                        <line x1="4" y1="18" x2="20" y2="18"></line>
                      </svg>
                    </div>
                    <button v-else style="background: transparent; border: none; color: #999; padding: 0; cursor: pointer; display: flex; align-items: center; justify-content: center;" @click.stop="alertVal('Action clicked for ' + (item.accountName || item.name))">
                      <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="5" r="1"></circle>
                        <circle cx="12" cy="12" r="1"></circle>
                        <circle cx="12" cy="19" r="1"></circle>
                      </svg>
                    </button>
                  </template>
                </BizAccountListCard>
              </template>
            </BizAccountReorderList>
          </div>
          <pre class="code-block"><code>&lt;BizAccountReorderList 
  :accounts="accounts" 
  :isReorderMode="isReorderMode" 
  @update:accounts="newAccs => accounts = newAccs" 
&gt;
  &lt;template #item="{ item, dragListeners, isReorderMode }"&gt;
    &lt;BizAccountListCard 
      :accountName="item.name"
      :balance="item.balance"
      &lt;!-- ... --&gt;
    &gt;
      &lt;template #action&gt;
        &lt;div v-if="isReorderMode" v-on="dragListeners"&gt;Drag Me&lt;/div&gt;
      &lt;/template&gt;
    &lt;/BizAccountListCard&gt;
  &lt;/template&gt;
&lt;/BizAccountReorderList&gt;</code></pre>
        </div>

        <div class="variant-group">
          <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
            <h3>Fully Custom Template</h3>
            <BizButton size="small" @click="isReorderMode = !isReorderMode">
              {{ isReorderMode ? 'Done' : 'Sort by' }}
            </BizButton>
          </div>
          <p class="custom-guide">You can completely replace the internal cards with your own custom HTML while retaining the drag-to-reorder logic.</p>
          <div class="component-demo" style="background: #f4f6f9; padding: 20px; border-radius: 12px;">
            <BizAccountReorderList 
              :accounts="demoAccounts"
              :isReorderMode="isReorderMode"
              @update:accounts="newAccs => demoAccounts = newAccs"
            >
              <template #item="{ item, dragListeners, isReorderMode: reorderMode }">
                <div style="background: white; border-radius: 8px; padding: 16px; margin-bottom: 8px; display: flex; align-items: center; justify-content: space-between; box-shadow: 0 2px 4px rgba(0,0,0,0.05);">
                  <div>
                    <strong style="display: block; font-size: 16px; color: #333;">Custom: {{ item.accountName || item.name }}</strong>
                    <span style="color: #666; font-size: 14px;">Balance: {{ item.currency }}{{ item.balance }}</span>
                  </div>
                  <div 
                    v-if="reorderMode" 
                    style="background: #eef2f6; padding: 8px; border-radius: 4px; cursor: grab; color: #555;"
                    v-on="dragListeners"
                  >
                    Hold to Drag
                  </div>
                  <BizButton v-else size="small" variant="outline" @click="alertVal('Action on custom card')">Action</BizButton>
                </div>
              </template>
            </BizAccountReorderList>
          </div>
          <pre class="code-block" v-pre><code>&lt;BizAccountReorderList 
  :accounts="accounts" 
  :isReorderMode="isReorderMode"
&gt;
  &lt;template #item="{ item, dragListeners, isReorderMode }"&gt;
    &lt;div class="my-custom-card"&gt;
      &lt;h4&gt;{{ item.name }}&lt;/h4&gt;
      &lt;p&gt;{{ item.balance }}&lt;/p&gt;
      &lt;div v-if="isReorderMode" v-on="dragListeners"&gt;
        Hold to Drag
      &lt;/div&gt;
    &lt;/div&gt;
  &lt;/template&gt;
&lt;/BizAccountReorderList&gt;</code></pre>
        </div>
      </div>

      <!-- ==============================
           15. BizAutocomplete
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizautocomplete search filter dropdown input')">
        <h2>15. Autocomplete</h2>

        <div class="variant-group">
          <h3>Searchable Dropdown</h3>
          <p class="custom-guide">Type to filter from a list of predefined options.</p>
          <div class="component-demo">
            <BizAutocomplete 
              v-model="autoVal"
              label="Select Country"
              placeholder="Start typing (e.g., Cam...)"
              :options="countryOptions"
              @item-select="val => alertVal('Selected ' + JSON.stringify(val))"
            />
          </div>
          <pre class="code-block"><code>&lt;BizAutocomplete 
  v-model="value"
  label="Select Country"
  placeholder="Start typing..."
  :options="countryOptions"
/></code></pre>
        </div>
      </div>

      <!-- ==============================
           16. Skeleton Loading
      ================================ -->
      <div class="guide-section" v-show="matchesSearch('bizscrollsegment biznotificationitem scroll notification segment list item')">
        <h2>Notifications & Scrolling</h2>

        <div class="variant-group">
          <h3>BizScrollSegment</h3>
          <div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px; max-width: 400px;">
            <BizScrollSegment>
              <BizScrollSegmentButton :isActive="true">All (20)</BizScrollSegmentButton>
              <BizScrollSegmentButton>Unread (5)</BizScrollSegmentButton>
              <BizScrollSegmentButton>Payments (2)</BizScrollSegmentButton>
              <BizScrollSegmentButton>Announcements (13)</BizScrollSegmentButton>
              <BizScrollSegmentButton>Security (0)</BizScrollSegmentButton>
            </BizScrollSegment>
          </div>
          <pre class="code-block"><code>&lt;BizScrollSegment&gt;
  &lt;BizScrollSegmentButton :isActive="true"&gt;All (20)&lt;/BizScrollSegmentButton&gt;
  &lt;BizScrollSegmentButton&gt;Unread (5)&lt;/BizScrollSegmentButton&gt;
&lt;/BizScrollSegment&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizNotificationItem</h3>
          <div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px;">
            <div style="background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.05); max-width: 400px;">
              <BizNotificationItem 
                title="PPCBank" 
                description="Set up smartPay now, easy transfer, and payment anytime, anywhere. Scan KHQR..." 
                timestamp="29 SEP, 2026 7:41:42 PM" 
                :unread="true"
              >
                <template #icon>
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 5L6 9H2v6h4l5 4V5z"/><path d="M19.07 4.93a10 10 0 0 1 0 14.14M15.54 8.46a5 5 0 0 1 0 7.07"/></svg>
                </template>
              </BizNotificationItem>

              <BizNotificationItem 
                title="Account" 
                description="242.50 USD is deposited into 00100 001 0005517." 
                timestamp="02 SEP, 2026 8:12:12 AM"
              >
                <template #icon>
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="5" width="20" height="14" rx="2"/><path d="M12 12h.01"/><path d="M16 12h.01"/><path d="M8 12h.01"/></svg>
                </template>
              </BizNotificationItem>
            </div>
          </div>
        </div>
      </div>

      <div class="guide-section" v-show="matchesSearch('bizskeleton bizskeletonitem bizskeletonlist bizskeletondetail loading skeleton text')">
        <h2>16. Skeleton Loading</h2>
        <p class="guide-desc">Beautiful loading placeholders for list and detail views.</p>

        <div class="variant-group">
          <h3>List Skeleton</h3>
          <BizSkeletonList :count="3" :avatar="true" />
        </div>

        <div class="variant-group" style="margin-top: 32px;">
          <h3>Custom Template Skeleton</h3>
          <p class="custom-guide">Use <code>&lt;BizSkeleton&gt;</code> to create your own loading layouts</p>
          <BizSkeleton :loading="true">
            <template #template>
              <div style="display: flex; gap: 16px; align-items: center;">
                <BizSkeletonItem variant="circle" />
                <div style="flex: 1; display: flex; flex-direction: column; gap: 8px;">
                  <BizSkeletonItem variant="text" width="60%" />
                  <BizSkeletonItem variant="text" width="80%" />
                  <BizSkeletonItem variant="text" width="40%" />
                </div>
              </div>
            </template>
          </BizSkeleton>
        </div>

        <div class="variant-group" style="margin-top: 32px;">
          <h3>Detail Skeleton</h3>
          <BizSkeletonDetail :paragraphs="2" />
        </div>
      </div>

      <div class="no-results" v-if="noResults">
        <p>No components match your search query.</p>
      </div>

    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import LiquidGlassTabBar from '@/components/LiquidGlassTabBar.vue';
import BizAnimatedTabs from '@/components/BizAnimatedTabs.vue';
import BizAnimatedSegment from '@/components/BizAnimatedSegment.vue';

const handleSecureKeypadPress = (v: string) => {
  if (v === 'backspace') {
    secureKeypadVal.value = secureKeypadVal.value.slice(0, -1);
  } else {
    secureKeypadVal.value += v;
  }
};

const handleSecureKeyboardPress = (v: string) => {
  if (v === 'backspace') {
    secureKeyboardVal.value = secureKeyboardVal.value.slice(0, -1);
  } else if (v === 'enter' || v === 'emoji') {
    // ignored in this demo
  } else {
    secureKeyboardVal.value += v;
  }
};

const khmerDemoVal = ref('');

const handleKeyboardPress = (v: string) => {
  if (v === 'backspace') {
    keypadDemoVal.value = keypadDemoVal.value.slice(0, -1);
  } else if (v === 'enter') {
    console.log('Enter pressed');
  } else {
    keypadDemoVal.value += v;
  }
};

const handleKhmerPress = (v: string) => {
  if (v === 'backspace') {
    khmerDemoVal.value = khmerDemoVal.value.slice(0, -1);
  } else if (v === 'enter') {
    console.log('Enter pressed');
  } else {
    khmerDemoVal.value += v;
  }
};
import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';
import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline } from 'ionicons/icons';
import { 
  BizButton, BizButtonGroup, BizImageTransition, BizSwipeItem, BizSlider, BizSwitch, BizBarChart, BizLineChart, BizDonutChart, BizPieChart, BizRadarChart, BizProgressGauge, BizScatterChart, BizFunnelChart, BizSkeleton, BizSkeletonItem, BizSkeletonList, BizSkeletonDetail, BizHideAppBar, BizBottomNav, BizFab, BizFabList, BizFabAction, BizNumberSpinner, BizRadio, BizRadioGroup, BizRating, BizCollapsingToolbar, BizPullToRefresh, BizInput, BizTextField, BizSelect, BizTransferList, BizToggleButton, BizCheckbox, BizCheckboxGroup, BizPhoneInput, BizOtpInput, 
  BizInfoCard, BizActionCard, BizAccountCard, 
  BizSegment, BizSegmentButton, BizCompanySelector, BizScrollSegment, BizScrollSegmentButton, BizNotificationItem,
  BizPinDots, BizKeypad, BizSecureKeypad, BizSecureKeyboard, BizKhmerKeyboard, BizToast, BizConfirmSheet, BizReceiveAmountSheet,
  BizAccountSavingCard, BizReceivingAccountSheet, BizKhmerCalendar, BizKhmerCalendarSheet, BizKhmerCalendarAlert,
  BizCalendar, BizCalendarSheet, BizCalendarAlert, BizFileUpload,
  BizMonthPicker, BizMonthPickerSheet, BizMonthPickerAlert,
  BizYearPicker, BizYearPickerSheet, BizYearPickerAlert,
  BizTimePicker, BizTimePickerSheet, BizTimePickerAlert,
  BizAutocomplete,
  BizAccountListCard, BizAccountReorderList
} from '@bizmob-core/ui-framework';
import { KhmerDate } from '@bizmob-core/ui-framework/dist/KhmerDate';

const textVal = ref('');
const selectVal = ref('');
const khmerDateDemo = computed(() => {
  const khmerDate = new KhmerDate();
  const dateObj = khmerDate.toLunar();
  return `${dateObj.lunarDay} ខែ${dateObj.lunarMonth} ឆ្នាំ${dateObj.zodiacYear} ${dateObj.stem} ព.ស. ${dateObj.lunarYear}`;
});
const transferVal = ref([2, 3]);
const transferOptions = ref([
  { key: 1, label: 'Option A' },
  { key: 2, label: 'Option B' },
  { key: 3, label: 'Option C' },
  { key: 4, label: 'Option D (Disabled)', disabled: true },
  { key: 5, label: 'Option E' },
]);
const toggleVal1 = ref(false);
const toggleVal2 = ref(true);
const toggleVal3 = ref(false);
const keypadVal = ref('');
const secureKeypadVal = ref('');
const secureKeyboardVal = ref('');
const autoVal = ref('');
const countryOptions = ref([
  { label: 'Cambodia', value: 'KH' },
  { label: 'Cameroon', value: 'CM' },
  { label: 'Canada', value: 'CA' },
  { label: 'United States', value: 'US' },
  { label: 'United Kingdom', value: 'UK' },
  { label: 'Thailand', value: 'TH' },
  { label: 'Vietnam', value: 'VN' }
]);
const handleRefresh = (complete: () => void) => {
  setTimeout(() => {
    alertVal('Refresh Complete!');
    complete();
  }, 1500);
};

const phoneVal = ref('');
const otpVal = ref('');

const uploadedFiles = ref<any[]>([]);

const handleFileUpload = (newFiles: any[]) => {
  newFiles.forEach(file => {
    const id = Date.now().toString() + Math.random().toString();
    const newFileObj = {
      id,
      name: file.name,
      size: file.size,
      progress: 0,
      status: 'uploading',
      file
    };
    uploadedFiles.value.push(newFileObj);
    
    // Simulate upload progress
    const interval = setInterval(() => {
      const fileRef = uploadedFiles.value.find((f: any) => f.id === id);
      if (!fileRef) {
        clearInterval(interval);
        return;
      }
      fileRef.progress += Math.random() * 20 + 5;
      if (fileRef.progress >= 100) {
        fileRef.progress = 100;
        fileRef.status = Math.random() > 0.8 ? 'error' : 'success';
        if (fileRef.status === 'error') fileRef.errorMessage = 'Network timeout';
        clearInterval(interval);
      }
    }, 500);
  });
};

const handleFileRemove = (id: string | number) => {
  uploadedFiles.value = uploadedFiles.value.filter(f => f.id !== id);
};

const handleFileRetry = (id: string | number) => {
  const fileRef = uploadedFiles.value.find(f => f.id === id);
  if (fileRef) {
    fileRef.status = 'uploading';
    fileRef.progress = 0;
    
    const interval = setInterval(() => {
      const fRef = uploadedFiles.value.find((f: any) => f.id === id);
      if (!fRef) {
        clearInterval(interval);
        return;
      }
      fRef.progress += Math.random() * 20 + 5;
      if (fRef.progress >= 100) {
        fRef.progress = 100;
        fRef.status = 'success';
        clearInterval(interval);
      }
    }, 500);
  }
};
const navVal = ref('home');
const hideDeposit = ref(false);
const selectedFeatures = ref(['payment']);
const timeVal = ref('13:45');
const timeSheetVal = ref('12:00');
const showTimePickerSheet = ref(false);
const timeAlertVal = ref('09:30');
const showTimePickerAlert = ref(false);

const animatedTabVal = ref(0);
const animatedTabs = ref([
  { label: 'Home', icon: homeOutline },
  { label: 'History', icon: documentTextOutline },
  { label: 'Profile', icon: personOutline }
]);

const animatedSegmentVal = ref('opt1');
const animatedSegments = ref([
  { label: 'Option 1', value: 'opt1' },
  { label: 'Option 2', value: 'opt2' },
  { label: 'Option 3', value: 'opt3' }
]);
const spinnerVal = ref(5);
const radioVal = ref('option1');
const ratingVal = ref(3);
const sliderVal1 = ref(50);
const sliderVal2 = ref({ lower: 20, upper: 80 });
const sliderVal3 = ref(30);
const switchVal1 = ref(false);
const switchVal2 = ref(true);
const switchVal3 = ref(false);
const hideLoan = ref(true);
const segmentVal = ref('opt1');
const cssSegmentVal = ref('opt1');
const showBottomSheet = ref(false);
const showBioBoth = ref(false);
const showBioFace = ref(false);
const showBioFinger = ref(false);
const keypadDemoVal = ref('None');
const handlePress = (v: string) => {
  keypadDemoVal.value = v;
};
const showToast = ref(false);
const showConfirmSheet = ref(false);
const showReceiveAmount = ref(false);
const showReceivingAccount = ref(false);
const showCalendarSheet = ref(false);
const showAlertCalendar = ref(false);
const showStdCalendarSheet = ref(false);
const showStdAlertCalendar = ref(false);
const showMonthPickerSheet = ref(false);
const showYearPickerSheet = ref(false);
const showYearPickerAlert = ref(false);
const selectedReceivingAccount = ref('acc1');
const demoAccounts = ref([
  { id: 'acc1', name: "Chan Ty' Saving", number: "1-120-14335454-8", balance: 12000000.00, currency: "USD" as const, type: "Savings", isHidden: false },
  { id: 'acc2', name: "Chan Ty' Saving", number: "1-120-14335455-9", balance: 50000.50, currency: "USD" as const, type: "Savings", isHidden: false },
  { id: 'acc3', name: "Chan Ty' Saving", number: "1-120-14335456-0", balance: 40000000, currency: "KHR" as const, type: "Savings", isHidden: true },
]);
const isReorderMode = ref(false);
const alertVal = (type: string) => alert('Setup: ' + type);

// Search functionality
const searchQuery = ref('');

const matchesSearch = (keywords: string) => {
  if (!searchQuery.value) return true;
  
  const query = searchQuery.value.toLowerCase().trim();
  const searchTerms = query.split(' ');
  
  // Return true if EVERY search term is found somewhere in the keywords string
  return searchTerms.every(term => keywords.toLowerCase().includes(term));
};

const noResults = computed(() => {
  if (!searchQuery.value) return false;
  
  // List all keyword groups checking if ANY match
  const allKeywords = [
    'css theme', 
    'bizbutton button', 
    'bizinfocard info card warning', 
    'bizaccountcard account card deposit loan', 
    'bizactioncard action card', 
    'biziconbutton icon button', 
    'bizinput bizphoneinput bizotpinput form phone otp password text input', 
    'bizsegment bizcompanyselector bizuserprofile bizbottomsheet bizbottomnav segment company user profile bottom sheet nav structure bizscrollsegment biznotificationitem scroll notification list item',
    'bizpindots bizkeypad pin dots security keypad number',
    'bizkhmercalendar khmer calendar date picker'
  ];
  
  return !allKeywords.some(keywords => matchesSearch(keywords));
});
</script>

<style scoped>
.component-guide {
  --background: #ffffff;
}

.guide-intro {
  font-size: 15px;
  color: #444;
  line-height: 1.6;
  margin-bottom: 24px;
  padding: 16px;
  background: #e6f0ff;
  border-radius: 12px;
  border-left: 4px solid #0066cc;
}

.search-bar {
  margin-bottom: 32px;
  position: sticky;
  top: -10px;
  z-index: 100;
  background: white;
  padding: 10px 0;
  box-shadow: 0 10px 10px -10px rgba(0,0,0,0.1);
}

.guide-section {
  margin-bottom: 48px;
}

.guide-section h2 {
  font-size: 20px;
  color: var(--biz-primary-variant, #1a2a5e);
  margin: 0 0 16px 0;
  border-bottom: 2px solid #0066cc;
  padding-bottom: 8px;
}

.variant-group {
  margin-bottom: 32px;
}

.variant-group h3 {
  font-size: 14px;
  color: #666;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin: 0 0 12px 0;
}

.custom-guide {
  font-size: 14px;
  color: #555;
  margin: 0 0 16px 0;
  line-height: 1.5;
}

.custom-guide code {
  background: #f4f5f8;
  padding: 2px 6px;
  border-radius: 4px;
  font-family: monospace;
  color: #0066cc;
}

.css-var-list {
  list-style: none;
  padding: 0;
  margin: 0 0 24px 0;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.css-var-list li {
  font-size: 14px;
  color: #555;
  background: #f8f9fa;
  padding: 8px 12px;
  border-radius: 6px;
  border-left: 3px solid #0066cc;
}

.css-var-list code {
  color: #d93025;
  font-family: monospace;
  font-weight: 600;
  margin-right: 4px;
}

.component-demo {
  margin-bottom: 12px;
}

.code-block {
  background: #1e1e1e;
  color: #d4d4d4;
  padding: 12px 16px;
  border-radius: 8px;
  overflow-x: auto;
  font-family: 'Courier New', Courier, monospace;
  font-size: 13px;
  line-height: 1.5;
  margin: 0;
}
.code-block code {
  white-space: pre;
}

.no-results {
  text-align: center;
  padding: 40px 20px;
  color: #888;
  background: #f8f9fa;
  border-radius: 12px;
}
</style>
