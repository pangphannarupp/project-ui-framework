<template>
<div class="guide-section">
        <p class="guide-desc">A flexible container for hiding and showing content panels.</p>

        <div class="variant-group">
          <h3>Standard Mode (Multiple Open)</h3>
          <p class="custom-guide">Multiple panels can be expanded simultaneously.</p>
          <div class="component-demo">
            <PPCollapse v-model="collapseModel1">
              <PPCollapseItem name="1" title="Panel 1">
                Content for Panel 1. This can contain text, forms, or any other components.
              </PPCollapseItem>
              <PPCollapseItem name="2" title="Panel 2">
                Content for Panel 2.
              </PPCollapseItem>
              <PPCollapseItem name="3" title="Panel 3 (Disabled)" disabled>
                You shouldn't see this.
              </PPCollapseItem>
            </PPCollapse>
            <p style="margin-top: 16px; font-size: 12px; color: #666;">Active panels: {{ collapseModel1 }}</p>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPCollapse v-model="collapseModel1"&gt;
  &lt;PPCollapseItem name="1" title="Panel 1"&gt;
    Content for Panel 1. This can contain text, forms, or any other components.
  &lt;/PPCollapseItem&gt;
  &lt;PPCollapseItem name="2" title="Panel 2"&gt;
    Content for Panel 2.
  &lt;/PPCollapseItem&gt;
  &lt;PPCollapseItem name="3" title="Panel 3 (Disabled)" disabled&gt;
    You shouldn't see this.
  &lt;/PPCollapseItem&gt;
&lt;/PPCollapse&gt;</code></pre>
        </div>

        <div class="variant-group" style="margin-top: 32px;">
          <h3>Accordion Mode (Single Open)</h3>
          <p class="custom-guide">Only one panel can be open at a time.</p>
          <div class="component-demo">
            <PPCollapse v-model="collapseModel2" accordion>
              <PPCollapseItem name="A" title="Section A">
                Content for Section A.
              </PPCollapseItem>
              <PPCollapseItem name="B">
                <template #title>
                  <strong style="color: var(--pp-primary-color);">Custom Header B</strong>
                </template>
                Content for Section B.
              </PPCollapseItem>
              <PPCollapseItem name="C" title="Section C">
                Content for Section C.
              </PPCollapseItem>
            </PPCollapse>
            <p style="margin-top: 16px; font-size: 12px; color: #666;">Active panel: {{ collapseModel2 }}</p>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPCollapse v-model="collapseModel2" accordion&gt;...&lt;/PPCollapse&gt;</code></pre>
        </div>

        <div class="variant-group" style="margin-top: 32px;">
          <h3>Variants</h3>
          <p class="custom-guide">Change the visual style using the <code>variant</code> prop.</p>
          
          <h4 style="margin-top: 16px;">Flush Variant</h4>
          <p class="guide-desc">No outer borders or background.</p>
          <div class="component-demo">
            <PPCollapse variant="flush">
              <PPCollapseItem name="1" title="Flush Panel 1">Content inside flush panel.</PPCollapseItem>
              <PPCollapseItem name="2" title="Flush Panel 2">Content inside flush panel.</PPCollapseItem>
            </PPCollapse>
          </div>
          
          <h4 style="margin-top: 24px;">Separated Variant</h4>
          <p class="guide-desc">Each panel acts as an individual card.</p>
          <div class="component-demo">
            <PPCollapse variant="separated">
              <PPCollapseItem name="1" title="Separated Panel 1">Content inside separated panel.</PPCollapseItem>
              <PPCollapseItem name="2" title="Separated Panel 2">Content inside separated panel.</PPCollapseItem>
            </PPCollapse>
          </div>
          
          <h4 style="margin-top: 24px;">Filled Variant</h4>
          <p class="guide-desc">Light colored background for headers.</p>
          <div class="component-demo">
            <PPCollapse variant="filled">
              <PPCollapseItem name="1" title="Filled Panel 1">Content inside filled panel with a white background.</PPCollapseItem>
              <PPCollapseItem name="2" title="Filled Panel 2">Content inside filled panel with a white background.</PPCollapseItem>
            </PPCollapse>
          </div>
        </div>
      
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-bg-color: /* value */;
  --pp-border-color: /* value */;
  --pp-icon-color: /* value */;
  --pp-text-color: /* value */;
  --pp-text-disabled-color: /* value */;
  --pp-text-secondary: /* value */;
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
        &lt;p class="guide-desc"&gt;A flexible container for hiding and showing content panels.&lt;/p&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Standard Mode (Multiple Open)&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;Multiple panels can be expanded simultaneously.&lt;/p&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPCollapse v-model="collapseModel1"&gt;
              &lt;PPCollapseItem name="1" title="Panel 1"&gt;
                Content for Panel 1. This can contain text, forms, or any other components.
              &lt;/PPCollapseItem&gt;
              &lt;PPCollapseItem name="2" title="Panel 2"&gt;
                Content for Panel 2.
              &lt;/PPCollapseItem&gt;
              &lt;PPCollapseItem name="3" title="Panel 3 (Disabled)" disabled&gt;
                You shouldn't see this.
              &lt;/PPCollapseItem&gt;
            &lt;/PPCollapse&gt;
            &lt;p style="margin-top: 16px; font-size: 12px; color: #666;"&gt;Active panels: {{ collapseModel1 }}&lt;/p&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPCollapse v-model="collapseModel1"&amp;gt;
  &amp;lt;PPCollapseItem name="1" title="Panel 1"&amp;gt;
    Content for Panel 1. This can contain text, forms, or any other components.
  &amp;lt;/PPCollapseItem&amp;gt;
  &amp;lt;PPCollapseItem name="2" title="Panel 2"&amp;gt;
    Content for Panel 2.
  &amp;lt;/PPCollapseItem&amp;gt;
  &amp;lt;PPCollapseItem name="3" title="Panel 3 (Disabled)" disabled&amp;gt;
    You shouldn't see this.
  &amp;lt;/PPCollapseItem&amp;gt;
&amp;lt;/PPCollapse&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group" style="margin-top: 32px;"&gt;
          &lt;h3&gt;Accordion Mode (Single Open)&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;Only one panel can be open at a time.&lt;/p&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPCollapse v-model="collapseModel2" accordion&gt;
              &lt;PPCollapseItem name="A" title="Section A"&gt;
                Content for Section A.
              &lt;/PPCollapseItem&gt;
              &lt;PPCollapseItem name="B"&gt;
                &lt;template #title&gt;
                  &lt;strong style="color: var(--pp-primary-color);"&gt;Custom Header B&lt;/strong&gt;
                &lt;/template&gt;
                Content for Section B.
              &lt;/PPCollapseItem&gt;
              &lt;PPCollapseItem name="C" title="Section C"&gt;
                Content for Section C.
              &lt;/PPCollapseItem&gt;
            &lt;/PPCollapse&gt;
            &lt;p style="margin-top: 16px; font-size: 12px; color: #666;"&gt;Active panel: {{ collapseModel2 }}&lt;/p&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPCollapse v-model="collapseModel2" accordion&amp;gt;...&amp;lt;/PPCollapse&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group" style="margin-top: 32px;"&gt;
          &lt;h3&gt;Variants&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;Change the visual style using the &lt;code&gt;variant&lt;/code&gt; prop.&lt;/p&gt;
          
          &lt;h4 style="margin-top: 16px;"&gt;Flush Variant&lt;/h4&gt;
          &lt;p class="guide-desc"&gt;No outer borders or background.&lt;/p&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPCollapse variant="flush"&gt;
              &lt;PPCollapseItem name="1" title="Flush Panel 1"&gt;Content inside flush panel.&lt;/PPCollapseItem&gt;
              &lt;PPCollapseItem name="2" title="Flush Panel 2"&gt;Content inside flush panel.&lt;/PPCollapseItem&gt;
            &lt;/PPCollapse&gt;
          &lt;/div&gt;
          
          &lt;h4 style="margin-top: 24px;"&gt;Separated Variant&lt;/h4&gt;
          &lt;p class="guide-desc"&gt;Each panel acts as an individual card.&lt;/p&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPCollapse variant="separated"&gt;
              &lt;PPCollapseItem name="1" title="Separated Panel 1"&gt;Content inside separated panel.&lt;/PPCollapseItem&gt;
              &lt;PPCollapseItem name="2" title="Separated Panel 2"&gt;Content inside separated panel.&lt;/PPCollapseItem&gt;
            &lt;/PPCollapse&gt;
          &lt;/div&gt;
          
          &lt;h4 style="margin-top: 24px;"&gt;Filled Variant&lt;/h4&gt;
          &lt;p class="guide-desc"&gt;Light colored background for headers.&lt;/p&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPCollapse variant="filled"&gt;
              &lt;PPCollapseItem name="1" title="Filled Panel 1"&gt;Content inside filled panel with a white background.&lt;/PPCollapseItem&gt;
              &lt;PPCollapseItem name="2" title="Filled Panel 2"&gt;Content inside filled panel with a white background.&lt;/PPCollapseItem&gt;
            &lt;/PPCollapse&gt;
          &lt;/div&gt;
        &lt;/div&gt;
      
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-bg-color: /* value */;
  --pp-border-color: /* value */;
  --pp-icon-color: /* value */;
  --pp-text-color: /* value */;
  --pp-text-disabled-color: /* value */;
  --pp-text-secondary: /* value */;
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

const collapseModel1 = ref(['1']);

const collapseModel2 = ref('A');



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const collapseModel1 = ref(['1']);

const collapseModel2 = ref('A');



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
