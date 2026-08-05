<template>
<div class="guide-section">
        <h2>13.5. Year Picker</h2>

        
        <div class="variant-group">
          <h3>Input Wrapper</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPYearPickerInput&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPYearPickerInput v-model="yearModel" />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPYearPickerInput v-model="year" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Standard Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Single' }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <PPYearPicker 
              @year-selected="s => alertVal('Selected Year: ' + s.year)"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPYearPicker @year-selected="onSelect" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Range Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Range' }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <PPYearPicker 
              :config="{ selectionMode: 'Range' }"
              @range-selected="(start, end) => alertVal('Range: ' + (start ? start.year : '') + ' to ' + (end ? end.year : ''))"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPYearPicker :config="{ selectionMode: 'Range' }" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Year Picker Bottom Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPYearPickerSheet&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showYearPickerSheet = true">Open Year Sheet</PPButton>
            <PPYearPickerSheet 
              v-model="showYearPickerSheet"
              title="Select a Year"
              :showActionButtons="true"
              @confirm="(s) => { alertVal('Confirmed: ' + (s ? s.year : '')); showYearPickerSheet = false; }"
              @cancel="showYearPickerSheet = false"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPYearPickerSheet v-model="isOpen" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Year Picker Island Popup</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPYearPickerIsland&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showYearPickerIsland = true">Open Year Picker Island</PPButton>
            <PPYearPickerIsland 
              v-model="showYearPickerIsland"
              :showActionButtons="true"
              @confirm="s => { alertVal('Confirmed Year: ' + (s ? s.year : 'none')); showYearPickerIsland = false; }"
              @cancel="showYearPickerIsland = false"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPYearPickerIsland v-model="isOpen" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Year Picker Alert</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPYearPickerAlert&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showYearPickerAlert = true">Open Year Alert</PPButton>
            <PPYearPickerAlert 
              v-model="showYearPickerAlert"
              title="Select a Year"
              :showActionButtons="true"
              @confirm="(s) => { alertVal('Confirmed: ' + (s ? s.year : '')); showYearPickerAlert = false; }"
              @cancel="showYearPickerAlert = false"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPYearPickerAlert v-model="isOpen" /&gt;</code></pre>
        </div>
      
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-calendar-bg: /* value */;
  --pp-calendar-btn-cancel-text: /* value */;
  --pp-calendar-btn-confirm-bg: /* value */;
  --pp-calendar-btn-confirm-text: /* value */;
  --pp-calendar-radius: /* value */;
  --pp-calendar-range-bg: /* value */;
  --pp-calendar-selected-bg: /* value */;
  --pp-calendar-text: /* value */;
  --pp-color-primary: /* value */;
  --pp-island-expanded-height: /* value */;
  --pp-island-expanded-radius: /* value */;
  --pp-island-expanded-width: /* value */;
  --pp-primary: /* value */;
  --pp-primary-color: /* value */;
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
        &lt;h2&gt;13.5. Year Picker&lt;/h2&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Standard Selection&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Props:&lt;/strong&gt; &lt;code&gt;config={ selectionMode: 'Single' }&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;"&gt;
            &lt;PPYearPicker 
              @year-selected="s =&gt; alertVal('Selected Year: ' + s.year)"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPYearPicker @year-selected="onSelect" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Range Selection&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Props:&lt;/strong&gt; &lt;code&gt;config={ selectionMode: 'Range' }&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;"&gt;
            &lt;PPYearPicker 
              :config="{ selectionMode: 'Range' }"
              @range-selected="(start, end) =&gt; alertVal('Range: ' + (start ? start.year : '') + ' to ' + (end ? end.year : ''))"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPYearPicker :config="{ selectionMode: 'Range' }" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Year Picker Bottom Sheet&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Component:&lt;/strong&gt; &lt;code&gt;&amp;lt;PPYearPickerSheet&amp;gt;&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;"&gt;
            &lt;PPButton @click="showYearPickerSheet = true"&gt;Open Year Sheet&lt;/PPButton&gt;
            &lt;PPYearPickerSheet 
              v-model="showYearPickerSheet"
              title="Select a Year"
              :showActionButtons="true"
              @confirm="(s) =&gt; { alertVal('Confirmed: ' + (s ? s.year : '')); showYearPickerSheet = false; }"
              @cancel="showYearPickerSheet = false"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPYearPickerSheet v-model="isOpen" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Year Picker Island Popup&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Component:&lt;/strong&gt; &lt;code&gt;&amp;lt;PPYearPickerIsland&amp;gt;&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;"&gt;
            &lt;PPButton @click="showYearPickerIsland = true"&gt;Open Year Picker Island&lt;/PPButton&gt;
            &lt;PPYearPickerIsland 
              v-model="showYearPickerIsland"
              :showActionButtons="true"
              @confirm="s =&gt; { alertVal('Confirmed Year: ' + (s ? s.year : 'none')); showYearPickerIsland = false; }"
              @cancel="showYearPickerIsland = false"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPYearPickerIsland v-model="isOpen" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Year Picker Alert&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Component:&lt;/strong&gt; &lt;code&gt;&amp;lt;PPYearPickerAlert&amp;gt;&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;"&gt;
            &lt;PPButton @click="showYearPickerAlert = true"&gt;Open Year Alert&lt;/PPButton&gt;
            &lt;PPYearPickerAlert 
              v-model="showYearPickerAlert"
              title="Select a Year"
              :showActionButtons="true"
              @confirm="(s) =&gt; { alertVal('Confirmed: ' + (s ? s.year : '')); showYearPickerAlert = false; }"
              @cancel="showYearPickerAlert = false"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPYearPickerAlert v-model="isOpen" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
      
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-calendar-bg: /* value */;
  --pp-calendar-btn-cancel-text: /* value */;
  --pp-calendar-btn-confirm-bg: /* value */;
  --pp-calendar-btn-confirm-text: /* value */;
  --pp-calendar-radius: /* value */;
  --pp-calendar-range-bg: /* value */;
  --pp-calendar-selected-bg: /* value */;
  --pp-calendar-text: /* value */;
  --pp-color-primary: /* value */;
  --pp-island-expanded-height: /* value */;
  --pp-island-expanded-radius: /* value */;
  --pp-island-expanded-width: /* value */;
  --pp-primary: /* value */;
  --pp-primary-color: /* value */;
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
const yearModel = ref(null);

const showYearPickerSheet = ref(false);

const showYearPickerAlert = ref(false);

const showYearPickerIsland = ref(false);

const alertVal = (type: string) =&gt; console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem , PPYearPickerInput } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
const yearModel = ref(null);

const showYearPickerSheet = ref(false);

const showYearPickerAlert = ref(false);

const showYearPickerIsland = ref(false);

const alertVal = (type: string) => console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem , PPYearPickerInput } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
