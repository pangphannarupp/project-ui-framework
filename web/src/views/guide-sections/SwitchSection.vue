<template>
<div class="guide-section">
        <h2>Switches</h2>
        <p class="guide-desc">A toggle switch component supporting multiple platform styles and Material Design 3.</p>

        <div class="variant-group">
          <h3>Standard Styles</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;">
            <PPSwitch v-model="switchVal1" label="Standard Toggle" />
            <PPSwitch v-model="switchVal1" label="iOS Mode Toggle" mode="ios" color="secondary" />
            <PPSwitch v-model="switchVal2" label="Disabled Toggle" :disabled="true" />
          </div>
          <pre class="code-block" v-pre><code>&lt;template&gt;
  &lt;PPSwitch v-model="switchVal1" label="Standard Toggle" /&gt;
  &lt;PPSwitch v-model="switchVal1" label="iOS Mode Toggle" mode="ios" color="secondary" /&gt;
  &lt;PPSwitch v-model="switchVal2" label="Disabled Toggle" :disabled="true" /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { ref } from 'vue';
const switchVal1 = ref(false);
const switchVal2 = ref(true);
&lt;/script&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Material 3 & Icon Styles</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;">
            <PPSwitch v-model="switchVal3" label="Material 3 Toggle" variant="m3" />
            <PPSwitch v-model="switchVal3" label="Icon Toggle" variant="icon" color="success" />
          </div>
          <pre class="code-block" v-pre><code>&lt;template&gt;
  &lt;PPSwitch v-model="switchVal3" label="Material 3 Toggle" variant="m3" /&gt;
  &lt;PPSwitch v-model="switchVal3" label="Icon Toggle" variant="icon" color="success" /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { ref } from 'vue';
const switchVal3 = ref(false);
&lt;/script&gt;</code></pre>
        </div>
      
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-primary: /* value */;
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
        &lt;h2&gt;Switches&lt;/h2&gt;
        &lt;p class="guide-desc"&gt;A toggle switch component supporting multiple platform styles and Material Design 3.&lt;/p&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Standard Styles&lt;/h3&gt;
          &lt;div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;"&gt;
            &lt;PPSwitch v-model="switchVal1" label="Standard Toggle" /&gt;
            &lt;PPSwitch v-model="switchVal1" label="iOS Mode Toggle" mode="ios" color="secondary" /&gt;
            &lt;PPSwitch v-model="switchVal2" label="Disabled Toggle" :disabled="true" /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPSwitch v-model="switchVal1" label="Standard Toggle" /&amp;gt;
  &amp;lt;PPSwitch v-model="switchVal1" label="iOS Mode Toggle" mode="ios" color="secondary" /&amp;gt;
  &amp;lt;PPSwitch v-model="switchVal2" label="Disabled Toggle" :disabled="true" /&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { ref } from 'vue';
const switchVal1 = ref(false);
const switchVal2 = ref(true);
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Material 3 &amp; Icon Styles&lt;/h3&gt;
          &lt;div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;"&gt;
            &lt;PPSwitch v-model="switchVal3" label="Material 3 Toggle" variant="m3" /&gt;
            &lt;PPSwitch v-model="switchVal3" label="Icon Toggle" variant="icon" color="success" /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPSwitch v-model="switchVal3" label="Material 3 Toggle" variant="m3" /&amp;gt;
  &amp;lt;PPSwitch v-model="switchVal3" label="Icon Toggle" variant="icon" color="success" /&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { ref } from 'vue';
const switchVal3 = ref(false);
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
      
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-primary: /* value */;
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

const switchVal1 = ref(false);

const switchVal2 = ref(true);

const switchVal3 = ref(false);



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

const switchVal1 = ref(false);

const switchVal2 = ref(true);

const switchVal3 = ref(false);



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
