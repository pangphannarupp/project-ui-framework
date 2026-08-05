<template>
<div class="guide-section">
        <h2>10. Checkboxes</h2>

        <div class="variant-group">
          <h3>Standard Checkbox</h3>
          <div class="component-demo">
            <PPCheckbox v-model="hideDeposit" label="Hide deposit amounts" />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPCheckbox 
  v-model="isChecked" 
  label="Hide deposit amounts" 
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Checkbox Group</h3>
          <p class="custom-guide">Group multiple checkboxes bound to an array.</p>
          <div class="component-demo">
            <PPCheckboxGroup v-model="selectedFeatures" vertical>
              <PPCheckbox value="transfer" label="Transfers" />
              <PPCheckbox value="payment" label="Bill Payments" />
              <PPCheckbox value="topup" label="Mobile Topup" />
            </PPCheckboxGroup>
            <p style="margin-top: 10px; font-size: 14px;">Selected: {{ selectedFeatures }}</p>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPCheckboxGroup v-model="features" vertical&gt;
  &lt;PPCheckbox value="transfer" label="Transfers" /&gt;
  &lt;PPCheckbox value="payment" label="Payments" /&gt;
&lt;/PPCheckboxGroup&gt;</code></pre>
        </div>
      
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
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
        &lt;h2&gt;10. Checkboxes&lt;/h2&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Standard Checkbox&lt;/h3&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPCheckbox v-model="hideDeposit" label="Hide deposit amounts" /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPCheckbox 
  v-model="isChecked" 
  label="Hide deposit amounts" 
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Checkbox Group&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;Group multiple checkboxes bound to an array.&lt;/p&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPCheckboxGroup v-model="selectedFeatures" vertical&gt;
              &lt;PPCheckbox value="transfer" label="Transfers" /&gt;
              &lt;PPCheckbox value="payment" label="Bill Payments" /&gt;
              &lt;PPCheckbox value="topup" label="Mobile Topup" /&gt;
            &lt;/PPCheckboxGroup&gt;
            &lt;p style="margin-top: 10px; font-size: 14px;"&gt;Selected: {{ selectedFeatures }}&lt;/p&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPCheckboxGroup v-model="features" vertical&amp;gt;
  &amp;lt;PPCheckbox value="transfer" label="Transfers" /&amp;gt;
  &amp;lt;PPCheckbox value="payment" label="Payments" /&amp;gt;
&amp;lt;/PPCheckboxGroup&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
      
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
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

const hideDeposit = ref(false);

const selectedFeatures = ref(['payment']);



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

const hideDeposit = ref(false);

const selectedFeatures = ref(['payment']);



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
