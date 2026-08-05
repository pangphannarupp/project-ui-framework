<template>
<div class="guide-section">
        <h2>13. Month Picker</h2>

        <div class="variant-group">
          <h3>Input Wrapper</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPMonthPickerInput&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPMonthPickerInput v-model="monthModel" />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPMonthPickerInput v-model="month" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Standard Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Single' }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <PPMonthPicker 
              @month-selected="s => alertVal('Selected Month: ' + s.month + '/' + s.year)"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPMonthPicker @month-selected="onSelect" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Range Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Range' }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <PPMonthPicker 
              :config="{ selectionMode: 'Range' }"
              @range-selected="(start, end) => alertVal('Range: ' + (start ? start.month + '/' + start.year : '') + ' to ' + (end ? end.month + '/' + end.year : ''))"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPMonthPicker :config="{ selectionMode: 'Range' }" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Month Picker Bottom Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPMonthPickerSheet&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showMonthPickerSheet = true">Open Month Sheet</PPButton>
            <PPMonthPickerSheet 
              v-model="showMonthPickerSheet"
              title="Select a Month"
              :showActionButtons="true"
              @confirm="(s) => { alertVal('Confirmed: ' + (s ? s.month + '/' + s.year : '')); showMonthPickerSheet = false; }"
              @cancel="showMonthPickerSheet = false"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPMonthPickerSheet v-model="isOpen" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Month Picker Island Popup</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPMonthPickerIsland&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showMonthPickerIsland = true">Open Month Picker Island</PPButton>
            <PPMonthPickerIsland 
              v-model="showMonthPickerIsland"
              :showActionButtons="true"
              @confirm="s => { alertVal('Confirmed Month: ' + (s ? s.month + '/' + s.year : 'none')); showMonthPickerIsland = false; }"
              @cancel="showMonthPickerIsland = false"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPMonthPickerIsland v-model="isOpen" /&gt;</code></pre>
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
  --pp-calendar-cell-height: /* value */;
  --pp-calendar-day-disabled-opacity: /* value */;
  --pp-calendar-range-bg: /* value */;
  --pp-calendar-selected-bg: /* value */;
  --pp-calendar-selected-text: /* value */;
  --pp-calendar-text: /* value */;
  --pp-calendar-today-border: /* value */;
  --pp-calendar-wheel-active: /* value */;
  --pp-calendar-wheel-text: /* value */;
  --pp-color-primary: /* value */;
  --pp-danger-color: /* value */;
  --pp-island-expanded-height: /* value */;
  --pp-island-expanded-radius: /* value */;
  --pp-island-expanded-width: /* value */;
  --pp-primary: /* value */;
  --pp-primary-color: /* value */;
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
        &lt;h2&gt;13. Month Picker&lt;/h2&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Standard Selection&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Props:&lt;/strong&gt; &lt;code&gt;config={ selectionMode: 'Single' }&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;"&gt;
            &lt;PPMonthPicker 
              @month-selected="s =&gt; alertVal('Selected Month: ' + s.month + '/' + s.year)"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPMonthPicker @month-selected="onSelect" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Range Selection&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Props:&lt;/strong&gt; &lt;code&gt;config={ selectionMode: 'Range' }&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;"&gt;
            &lt;PPMonthPicker 
              :config="{ selectionMode: 'Range' }"
              @range-selected="(start, end) =&gt; alertVal('Range: ' + (start ? start.month + '/' + start.year : '') + ' to ' + (end ? end.month + '/' + end.year : ''))"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPMonthPicker :config="{ selectionMode: 'Range' }" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Month Picker Bottom Sheet&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Component:&lt;/strong&gt; &lt;code&gt;&amp;lt;PPMonthPickerSheet&amp;gt;&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;"&gt;
            &lt;PPButton @click="showMonthPickerSheet = true"&gt;Open Month Sheet&lt;/PPButton&gt;
            &lt;PPMonthPickerSheet 
              v-model="showMonthPickerSheet"
              title="Select a Month"
              :showActionButtons="true"
              @confirm="(s) =&gt; { alertVal('Confirmed: ' + (s ? s.month + '/' + s.year : '')); showMonthPickerSheet = false; }"
              @cancel="showMonthPickerSheet = false"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPMonthPickerSheet v-model="isOpen" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Month Picker Island Popup&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Component:&lt;/strong&gt; &lt;code&gt;&amp;lt;PPMonthPickerIsland&amp;gt;&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;"&gt;
            &lt;PPButton @click="showMonthPickerIsland = true"&gt;Open Month Picker Island&lt;/PPButton&gt;
            &lt;PPMonthPickerIsland 
              v-model="showMonthPickerIsland"
              :showActionButtons="true"
              @confirm="s =&gt; { alertVal('Confirmed Month: ' + (s ? s.month + '/' + s.year : 'none')); showMonthPickerIsland = false; }"
              @cancel="showMonthPickerIsland = false"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPMonthPickerIsland v-model="isOpen" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
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
  --pp-calendar-cell-height: /* value */;
  --pp-calendar-day-disabled-opacity: /* value */;
  --pp-calendar-range-bg: /* value */;
  --pp-calendar-selected-bg: /* value */;
  --pp-calendar-selected-text: /* value */;
  --pp-calendar-text: /* value */;
  --pp-calendar-today-border: /* value */;
  --pp-calendar-wheel-active: /* value */;
  --pp-calendar-wheel-text: /* value */;
  --pp-color-primary: /* value */;
  --pp-danger-color: /* value */;
  --pp-island-expanded-height: /* value */;
  --pp-island-expanded-radius: /* value */;
  --pp-island-expanded-width: /* value */;
  --pp-primary: /* value */;
  --pp-primary-color: /* value */;
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
const monthModel = ref(null);

const showMonthPickerSheet = ref(false);

const showMonthPickerIsland = ref(false);

const alertVal = (type: string) =&gt; console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem , PPMonthPickerInput } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
const monthModel = ref<{ year: number, month: number } | null>(null);
const showMonthPickerSheet = ref(false);

const showMonthPickerIsland = ref(false);

const alertVal = (type: string) => console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem , PPMonthPickerInput } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
