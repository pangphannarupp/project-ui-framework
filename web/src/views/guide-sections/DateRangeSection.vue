<template>
<div class="guide-section">
        <h2>PPDateRangePicker</h2>
        <p class="guide-desc">A date range picker for desktop with presets and a double-month calendar view.</p>
        
        <div class="variant-group">
          <h3>Input Wrapper</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPDateRangePickerInput&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPDateRangePickerInput v-model="dateRangeModel" />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPDateRangePickerInput v-model="dateRange" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Desktop Usage</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPDateRangePicker&gt;</code></p>
          <div class="component-demo">
            <PPDateRangePicker 
              v-model="dateRangeVal"
              @apply="onDateRangeApply"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPDateRangePicker v-model="dateRange" /&gt;</code></pre>
        </div>
        <div class="variant-group">
          <h3>Hide Header Controls</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPDateRangePicker&gt;</code> with <code>hide-header-picker</code> and <code>hide-nav-buttons</code></p>
          <div class="component-demo">
            <PPDateRangePicker 
              v-model="dateRangeVal2"
              :hide-header-picker="true"
              :hide-nav-buttons="true"
              @apply="onDateRangeApply"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPDateRangePicker v-model="dateRange" :hide-header-picker="true" :hide-nav-buttons="true" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Alert Overlay</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPDateRangePickerAlert&gt;</code></p>
          <div class="component-demo">
            <PPButton @click="showDateRangePickerAlert = true" variant="primary">Open Date Range Picker Alert</PPButton>
            <PPDateRangePickerAlert 
              v-model="showDateRangePickerAlert"
              :initialValue="dateRangeVal"
              @confirm="onDateRangeApply"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPDateRangePickerAlert v-model="isOpen" :initialValue="dateRange" @confirm="onConfirm" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Bottom Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPDateRangePickerSheet&gt;</code></p>
          <div class="component-demo">
            <PPButton @click="showDateRangePickerSheet = true" variant="primary">Open Date Range Picker Sheet</PPButton>
            <PPDateRangePickerSheet 
              v-model:visible="showDateRangePickerSheet"
              v-model="dateRangeVal"
              @apply="onDateRangeApply"
            />
            
            <div style="margin-top: 16px; padding: 12px; background: #f3f4f6; border-radius: 8px;">
              <strong>Selected Range:</strong> 
              <pre v-pre>{{ JSON.stringify(dateRangeVal, null, 2) }}</pre>
            </div>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPDateRangePickerSheet v-model:visible="isOpen" v-model="dateRange" @apply="onApply" /&gt;</code></pre>
        </div>
      
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
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
        &lt;h2&gt;PPDateRangePicker&lt;/h2&gt;
        &lt;p class="guide-desc"&gt;A date range picker for desktop with presets and a double-month calendar view.&lt;/p&gt;
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Desktop Usage&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Component:&lt;/strong&gt; &lt;code&gt;&amp;lt;PPDateRangePicker&amp;gt;&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPDateRangePicker 
              v-model="dateRangeVal"
              @apply="onDateRangeApply"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPDateRangePicker v-model="dateRange" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Hide Header Controls&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Component:&lt;/strong&gt; &lt;code&gt;&amp;lt;PPDateRangePicker&amp;gt;&lt;/code&gt; with &lt;code&gt;hide-header-picker&lt;/code&gt; and &lt;code&gt;hide-nav-buttons&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPDateRangePicker 
              v-model="dateRangeVal2"
              :hide-header-picker="true"
              :hide-nav-buttons="true"
              @apply="onDateRangeApply"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPDateRangePicker v-model="dateRange" :hide-header-picker="true" :hide-nav-buttons="true" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Alert Overlay&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Component:&lt;/strong&gt; &lt;code&gt;&amp;lt;PPDateRangePickerAlert&amp;gt;&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPButton @click="showDateRangePickerAlert = true" variant="primary"&gt;Open Date Range Picker Alert&lt;/PPButton&gt;
            &lt;PPDateRangePickerAlert 
              v-model="showDateRangePickerAlert"
              :initialValue="dateRangeVal"
              @confirm="onDateRangeApply"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPDateRangePickerAlert v-model="isOpen" :initialValue="dateRange" @confirm="onConfirm" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Bottom Sheet&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Component:&lt;/strong&gt; &lt;code&gt;&amp;lt;PPDateRangePickerSheet&amp;gt;&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPButton @click="showDateRangePickerSheet = true" variant="primary"&gt;Open Date Range Picker Sheet&lt;/PPButton&gt;
            &lt;PPDateRangePickerSheet 
              v-model:visible="showDateRangePickerSheet"
              v-model="dateRangeVal"
              @apply="onDateRangeApply"
            /&gt;
            
            &lt;div style="margin-top: 16px; padding: 12px; background: #f3f4f6; border-radius: 8px;"&gt;
              &lt;strong&gt;Selected Range:&lt;/strong&gt; 
              &lt;pre&gt;{{ JSON.stringify(dateRangeVal, null, 2) }}&lt;/pre&gt;
            &lt;/div&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPDateRangePickerSheet v-model:visible="isOpen" v-model="dateRange" @apply="onApply" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
      
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
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
const dateRangeModel = ref(null);

const showDateRangePickerSheet = ref(false);

const showDateRangePickerAlert = ref(false);

const dateRangeVal = ref({ start: null, end: null, presetId: undefined });
const dateRangeVal2 = ref({ start: null, end: null, presetId: undefined });

const onDateRangeApply = (val: any) =&gt; {
  console.log('Date range applied:', val);
};



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPDateRangePicker, PPDateRangePickerAlert, PPDateRangePickerSheet, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem , PPDateRangePickerInput } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
const dateRangeModel = ref(null);

const showDateRangePickerSheet = ref(false);

const showDateRangePickerAlert = ref(false);

const dateRangeVal = ref({ start: null, end: null, presetId: undefined });
const dateRangeVal2 = ref({ start: null, end: null, presetId: undefined });

const onDateRangeApply = (val: any) => {
  console.log('Date range applied:', val);
};



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPDateRangePicker, PPDateRangePickerAlert, PPDateRangePickerSheet, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem , PPDateRangePickerInput } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
