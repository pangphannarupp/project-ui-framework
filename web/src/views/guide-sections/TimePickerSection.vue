<template>
<div class="guide-section">
        <h2>14. Time Picker</h2>

        
        <div class="variant-group">
          <h3>Input Wrapper</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPTimePickerInput&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPTimePickerInput v-model="timeModel" />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPTimePickerInput v-model="time" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Standard Time Picker</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPTimePicker&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden; padding: 16px;">
            <PPTimePicker 
              v-model="timeVal"
              @change="(v) => alertVal('Selected Time: ' + v)"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPTimePicker v-model="timeVal" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Time Picker Bottom Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPTimePickerSheet&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showTimePickerSheet = true">Open Time Sheet</PPButton>
            <PPTimePickerSheet 
              v-model="showTimePickerSheet"
              v-model:timeValue="timeSheetVal"
              title="Select a Time"
              :showActionButtons="true"
              @confirm="() => { alertVal('Confirmed Time: ' + timeSheetVal); showTimePickerSheet = false; }"
              @cancel="showTimePickerSheet = false"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPTimePickerSheet v-model="isOpen" v-model:timeValue="val" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Time Picker Island Popup</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPTimePickerIsland&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showTimePickerIsland = true">Open Time Picker Island</PPButton>
            <PPTimePickerIsland 
              v-model="showTimePickerIsland"
              v-model:timeValue="timeIslandVal"
              :showActionButtons="true"
              @confirm="() => { alertVal('Confirmed Time: ' + timeIslandVal); showTimePickerIsland = false; }"
              @cancel="showTimePickerIsland = false"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPTimePickerIsland v-model="isOpen" v-model:timeValue="val" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Time Picker Alert</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPTimePickerAlert&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showTimePickerAlert = true">Open Time Alert</PPButton>
            <PPTimePickerAlert 
              v-model="showTimePickerAlert"
              v-model:timeValue="timeAlertVal"
              title="Select a Time"
              @confirm="() => { alertVal('Confirmed Time: ' + timeAlertVal); showTimePickerAlert = false; }"
              @cancel="showTimePickerAlert = false"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPTimePickerAlert v-model="isOpen" v-model:timeValue="val" /&gt;</code></pre>
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
  --pp-island-bg: /* value */;
  --pp-island-color: /* value */;
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
        &lt;h2&gt;14. Time Picker&lt;/h2&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Standard Time Picker&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Component:&lt;/strong&gt; &lt;code&gt;&amp;lt;PPTimePicker&amp;gt;&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden; padding: 16px;"&gt;
            &lt;PPTimePicker 
              v-model="timeVal"
              @change="(v) =&gt; alertVal('Selected Time: ' + v)"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPTimePicker v-model="timeVal" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Time Picker Bottom Sheet&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Component:&lt;/strong&gt; &lt;code&gt;&amp;lt;PPTimePickerSheet&amp;gt;&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;"&gt;
            &lt;PPButton @click="showTimePickerSheet = true"&gt;Open Time Sheet&lt;/PPButton&gt;
            &lt;PPTimePickerSheet 
              v-model="showTimePickerSheet"
              v-model:timeValue="timeSheetVal"
              title="Select a Time"
              :showActionButtons="true"
              @confirm="() =&gt; { alertVal('Confirmed Time: ' + timeSheetVal); showTimePickerSheet = false; }"
              @cancel="showTimePickerSheet = false"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPTimePickerSheet v-model="isOpen" v-model:timeValue="val" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Time Picker Island Popup&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Component:&lt;/strong&gt; &lt;code&gt;&amp;lt;PPTimePickerIsland&amp;gt;&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;"&gt;
            &lt;PPButton @click="showTimePickerIsland = true"&gt;Open Time Picker Island&lt;/PPButton&gt;
            &lt;PPTimePickerIsland 
              v-model="showTimePickerIsland"
              v-model:timeValue="timeIslandVal"
              :showActionButtons="true"
              @confirm="() =&gt; { alertVal('Confirmed Time: ' + timeIslandVal); showTimePickerIsland = false; }"
              @cancel="showTimePickerIsland = false"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPTimePickerIsland v-model="isOpen" v-model:timeValue="val" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Time Picker Alert&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Component:&lt;/strong&gt; &lt;code&gt;&amp;lt;PPTimePickerAlert&amp;gt;&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;"&gt;
            &lt;PPButton @click="showTimePickerAlert = true"&gt;Open Time Alert&lt;/PPButton&gt;
            &lt;PPTimePickerAlert 
              v-model="showTimePickerAlert"
              v-model:timeValue="timeAlertVal"
              title="Select a Time"
              @confirm="() =&gt; { alertVal('Confirmed Time: ' + timeAlertVal); showTimePickerAlert = false; }"
              @cancel="showTimePickerAlert = false"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPTimePickerAlert v-model="isOpen" v-model:timeValue="val" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
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
  --pp-island-bg: /* value */;
  --pp-island-color: /* value */;
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
const timeModel = ref(null);

const timeVal = ref('13:45');

const timeSheetVal = ref('12:00');

const timeIslandVal = ref('12:00');

const showTimePickerSheet = ref(false);

const timeAlertVal = ref('09:30');

const showTimePickerAlert = ref(false);

const showTimePickerIsland = ref(false);

const alertVal = (type: string) =&gt; console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem , PPTimePickerInput } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
const timeModel = ref(null);

const timeVal = ref('13:45');

const timeSheetVal = ref('12:00');

const timeIslandVal = ref('12:00');

const showTimePickerSheet = ref(false);

const timeAlertVal = ref('09:30');

const showTimePickerAlert = ref(false);

const showTimePickerIsland = ref(false);

const alertVal = (type: string) => console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem , PPTimePickerInput } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
