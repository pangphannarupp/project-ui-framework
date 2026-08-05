<template>
<div class="guide-section">
        <h2>9. Feedback & Action Sheets</h2>

        <div class="variant-group">
          <h3>PPToast</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>modelValue</code>, <code>message</code>, <code>duration</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; padding: 20px; border-radius: 12px; display: flex; flex-direction: column; gap: 12px;">
            <PPButton @click="showToast = true">Trigger Toast</PPButton>
            <PPToast v-model="showToast" message="User has been deleted." />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPToast v-model="showToast" message="User has been deleted." /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>PPConfirmSheet</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>modelValue</code>, <code>title</code>, <code>subtitle</code>, <code>confirmText</code>, <code>cancelText</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; padding: 20px; border-radius: 12px; display: flex; flex-direction: column; gap: 12px;">
            <PPButton @click="showConfirmSheet = true">Trigger Confirm Sheet</PPButton>
            <PPConfirmSheet 
              v-model="showConfirmSheet" 
              title="Delete User?"
              subtitle="This action cannot be undone."
              confirmText="Delete"
              cancelText="Cancel"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPConfirmSheet 
  v-model="showConfirmSheet" 
  title="Delete User?"
  subtitle="This action cannot be undone."
  confirmText="Delete"
  cancelText="Cancel"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>PPReceiveAmountSheet</h3>
          <p class="custom-guide"><strong>Events:</strong> <code>@confirm</code> (emits payload with currency and amount)</p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; padding: 20px; border-radius: 12px; display: flex; flex-direction: column; gap: 12px;">
            <PPButton @click="showReceiveAmount = true">Trigger Receive Amount Sheet</PPButton>
            <PPReceiveAmountSheet 
              v-model="showReceiveAmount" 
              @confirm="val => alertVal(`Received ${val.currency} ${val.amount}`)"
            />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPReceiveAmountSheet 
  v-model="showReceiveAmount" 
  @confirm="handleConfirm" 
/&gt;</code></pre>
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
        &lt;h2&gt;9. Feedback &amp; Action Sheets&lt;/h2&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;PPToast&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Props:&lt;/strong&gt; &lt;code&gt;modelValue&lt;/code&gt;, &lt;code&gt;message&lt;/code&gt;, &lt;code&gt;duration&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; padding: 20px; border-radius: 12px; display: flex; flex-direction: column; gap: 12px;"&gt;
            &lt;PPButton @click="showToast = true"&gt;Trigger Toast&lt;/PPButton&gt;
            &lt;PPToast v-model="showToast" message="User has been deleted." /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPToast v-model="showToast" message="User has been deleted." /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;PPConfirmSheet&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Props:&lt;/strong&gt; &lt;code&gt;modelValue&lt;/code&gt;, &lt;code&gt;title&lt;/code&gt;, &lt;code&gt;subtitle&lt;/code&gt;, &lt;code&gt;confirmText&lt;/code&gt;, &lt;code&gt;cancelText&lt;/code&gt;&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; padding: 20px; border-radius: 12px; display: flex; flex-direction: column; gap: 12px;"&gt;
            &lt;PPButton @click="showConfirmSheet = true"&gt;Trigger Confirm Sheet&lt;/PPButton&gt;
            &lt;PPConfirmSheet 
              v-model="showConfirmSheet" 
              title="Delete User?"
              subtitle="This action cannot be undone."
              confirmText="Delete"
              cancelText="Cancel"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPConfirmSheet 
  v-model="showConfirmSheet" 
  title="Delete User?"
  subtitle="This action cannot be undone."
  confirmText="Delete"
  cancelText="Cancel"
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;PPReceiveAmountSheet&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;&lt;strong&gt;Events:&lt;/strong&gt; &lt;code&gt;@confirm&lt;/code&gt; (emits payload with currency and amount)&lt;/p&gt;
          &lt;div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; padding: 20px; border-radius: 12px; display: flex; flex-direction: column; gap: 12px;"&gt;
            &lt;PPButton @click="showReceiveAmount = true"&gt;Trigger Receive Amount Sheet&lt;/PPButton&gt;
            &lt;PPReceiveAmountSheet 
              v-model="showReceiveAmount" 
              @confirm="val =&gt; alertVal(`Received ${val.currency} ${val.amount}`)"
            /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPReceiveAmountSheet 
  v-model="showReceiveAmount" 
  @confirm="handleConfirm" 
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
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

const showToast = ref(false);

const showConfirmSheet = ref(false);

const showReceiveAmount = ref(false);

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

const showToast = ref(false);

const showConfirmSheet = ref(false);

const showReceiveAmount = ref(false);

const alertVal = (type: string) => console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
