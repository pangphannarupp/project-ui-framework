<template>
<div class="guide-section">
        <h2>12. Standard Calendar</h2>

        <div class="variant-group">
          <h3>Standard Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Single' }</code> (default)</p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <PPCalendar 
              @date-selected="s => alertVal('Selected Date: ' + s.date.toLocaleDateString())"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPCalendar @date-selected="onSelect" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Range Selection & Limits</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Range', minDate: ..., maxDate: ... }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <PPCalendar 
              :config="{ 
                selectionMode: 'Range', 
                minDate: new Date(new Date().getFullYear(), new Date().getMonth(), 1), 
                maxDate: new Date(new Date().getFullYear(), new Date().getMonth() + 1, 0) 
              }"
              @range-selected="(start, end) => alertVal('Range: ' + (start ? start.date.toLocaleDateString() : '') + ' to ' + (end ? end.date.toLocaleDateString() : ''))"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPCalendar :config="{ selectionMode: 'Range', minDate, maxDate }" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Week Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Week' }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <PPCalendar 
              :config="{ selectionMode: 'Week' }"
              @range-selected="(start, end) => alertVal('Week: ' + (start ? start.date.toLocaleDateString() : '') + ' to ' + (end ? end.date.toLocaleDateString() : ''))"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPCalendar :config="{ selectionMode: 'Week' }" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Hide Header Controls</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>hideHeaderPicker</code>, <code>hideNavButtons</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <PPCalendar 
              :hide-header-picker="true"
              :hide-nav-buttons="true"
              @date-selected="s => alertVal('Selected Date: ' + s.date.toLocaleDateString())"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPCalendar :hide-header-picker="true" :hide-nav-buttons="true" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Calendar Bottom Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPCalendarSheet&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showStdCalendarSheet = true">Open Calendar Sheet</PPButton>
            <PPCalendarSheet 
              v-model="showStdCalendarSheet"
              title="Select a Date"
              :showActionButtons="true"
              @confirm="(d) => { alertVal('Confirmed: ' + (d ? d.date.toLocaleDateString() : '')); showStdCalendarSheet = false; }"
              @cancel="showStdCalendarSheet = false"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPCalendarSheet v-model="isOpen" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Calendar Island Popup</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPCalendarIsland&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showStdCalendarIsland = true">Open Calendar Island</PPButton>
            <PPCalendarIsland 
              v-model="showStdCalendarIsland"
              title="Select a Date"
              :showActionButtons="true"
              @confirm="(d) => { alertVal('Confirmed: ' + (d ? d.date.toLocaleDateString() : '')); showStdCalendarIsland = false; }"
              @cancel="showStdCalendarIsland = false"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPCalendarIsland v-model="isOpen" /&gt;</code></pre>
        </div>
      
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-calendar-bg: /* value */;
  --pp-calendar-cell-height: /* value */;
  --pp-calendar-day-disabled-opacity: /* value */;
  --pp-calendar-range-bg: /* value */;
  --pp-calendar-selected-bg: /* value */;
  --pp-calendar-selected-text: /* value */;
  --pp-calendar-special-color: /* value */;
  --pp-calendar-subtitle-color: /* value */;
  --pp-calendar-subtitle-text: /* value */;
  --pp-calendar-sunday-color: /* value */;
  --pp-calendar-text: /* value */;
  --pp-calendar-today-border: /* value */;
  --pp-calendar-wheel-active: /* value */;
  --pp-calendar-wheel-text: /* value */;
  --pp-danger-color: /* value */;
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
        &lt;h2&gt;12. Standard Calendar&lt;/h2&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Standard Selection&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Props:&lt;/strong&gt; &lt;code&gt;config={ selectionMode: 'Single' }&lt;/code&gt; (default)&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;"&gt;
            &lt;PPCalendar 
              @date-selected="s =&gt; alertVal('Selected Date: ' + s.date.toLocaleDateString())"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPCalendar @date-selected="onSelect" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Range Selection &amp; Limits&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Props:&lt;/strong&gt; &lt;code&gt;config={ selectionMode: 'Range', minDate: ..., maxDate: ... }&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;"&gt;
            &lt;PPCalendar 
              :config="{ 
                selectionMode: 'Range', 
                minDate: new Date(new Date().getFullYear(), new Date().getMonth(), 1), 
                maxDate: new Date(new Date().getFullYear(), new Date().getMonth() + 1, 0) 
              }"
              @range-selected="(start, end) =&gt; alertVal('Range: ' + (start ? start.date.toLocaleDateString() : '') + ' to ' + (end ? end.date.toLocaleDateString() : ''))"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPCalendar :config="{ selectionMode: 'Range', minDate, maxDate }" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Week Selection&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Props:&lt;/strong&gt; &lt;code&gt;config={ selectionMode: 'Week' }&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;"&gt;
            &lt;PPCalendar 
              :config="{ selectionMode: 'Week' }"
              @range-selected="(start, end) =&gt; alertVal('Week: ' + (start ? start.date.toLocaleDateString() : '') + ' to ' + (end ? end.date.toLocaleDateString() : ''))"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPCalendar :config="{ selectionMode: 'Week' }" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Hide Header Controls&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Props:&lt;/strong&gt; &lt;code&gt;hideHeaderPicker&lt;/code&gt;, &lt;code&gt;hideNavButtons&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;"&gt;
            &lt;PPCalendar 
              :hide-header-picker="true"
              :hide-nav-buttons="true"
              @date-selected="s =&gt; alertVal('Selected Date: ' + s.date.toLocaleDateString())"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPCalendar :hide-header-picker="true" :hide-nav-buttons="true" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Calendar Bottom Sheet&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Component:&lt;/strong&gt; &lt;code&gt;&amp;lt;PPCalendarSheet&amp;gt;&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;"&gt;
            &lt;PPButton @click="showStdCalendarSheet = true"&gt;Open Calendar Sheet&lt;/PPButton&gt;
            &lt;PPCalendarSheet 
              v-model="showStdCalendarSheet"
              title="Select a Date"
              :showActionButtons="true"
              @confirm="(d) =&gt; { alertVal('Confirmed: ' + (d ? d.date.toLocaleDateString() : '')); showStdCalendarSheet = false; }"
              @cancel="showStdCalendarSheet = false"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPCalendarSheet v-model="isOpen" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Calendar Island Popup&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Component:&lt;/strong&gt; &lt;code&gt;&amp;lt;PPCalendarIsland&amp;gt;&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;"&gt;
            &lt;PPButton @click="showStdCalendarIsland = true"&gt;Open Calendar Island&lt;/PPButton&gt;
            &lt;PPCalendarIsland 
              v-model="showStdCalendarIsland"
              title="Select a Date"
              :showActionButtons="true"
              @confirm="(d) =&gt; { alertVal('Confirmed: ' + (d ? d.date.toLocaleDateString() : '')); showStdCalendarIsland = false; }"
              @cancel="showStdCalendarIsland = false"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPCalendarIsland v-model="isOpen" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
      
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-calendar-bg: /* value */;
  --pp-calendar-cell-height: /* value */;
  --pp-calendar-day-disabled-opacity: /* value */;
  --pp-calendar-range-bg: /* value */;
  --pp-calendar-selected-bg: /* value */;
  --pp-calendar-selected-text: /* value */;
  --pp-calendar-special-color: /* value */;
  --pp-calendar-subtitle-color: /* value */;
  --pp-calendar-subtitle-text: /* value */;
  --pp-calendar-sunday-color: /* value */;
  --pp-calendar-text: /* value */;
  --pp-calendar-today-border: /* value */;
  --pp-calendar-wheel-active: /* value */;
  --pp-calendar-wheel-text: /* value */;
  --pp-danger-color: /* value */;
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

const showStdCalendarSheet = ref(false);

const showStdCalendarIsland = ref(false);

const alertVal = (type: string) =&gt; console.log('Setup: ' + type);
// Search functionality



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

const showStdCalendarSheet = ref(false);

const showStdCalendarIsland = ref(false);

const alertVal = (type: string) => console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
