<template>
<div class="guide-section">
        <h2>Liquid Glass Tab Bar (iOS) & Animated Tabs</h2>
        <p class="guide-desc">A custom floating tab bar with an iOS-style liquid glass (frosted) effect that animates between tab content.</p>

        <div class="variant-group">
          <h3>Interactive Demo</h3>
          <div class="component-demo" style="position: relative; height: 300px; background: url('https://images.unsplash.com/photo-1579546929518-9e396f3cc809?q=80&w=1000&auto=format&fit=crop') center/cover; border-radius: 12px; overflow: hidden;">
            <PPAnimatedTabs v-model="animatedTabVal" :tabs="animatedTabs">
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
            </PPAnimatedTabs>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPAnimatedTabs v-model="activeTab" :tabs="tabs"&gt;
  &lt;template #tab-0&gt;Content 1&lt;/template&gt;
  &lt;template #tab-1&gt;Content 2&lt;/template&gt;
&lt;/PPAnimatedTabs&gt;</code></pre>
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
        &lt;h2&gt;Liquid Glass Tab Bar (iOS) &amp; Animated Tabs&lt;/h2&gt;
        &lt;p class="guide-desc"&gt;A custom floating tab bar with an iOS-style liquid glass (frosted) effect that animates between tab content.&lt;/p&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Interactive Demo&lt;/h3&gt;
          &lt;div class="component-demo" style="position: relative; height: 300px; background: url('https://images.unsplash.com/photo-1579546929518-9e396f3cc809?q=80&amp;w=1000&amp;auto=format&amp;fit=crop') center/cover; border-radius: 12px; overflow: hidden;"&gt;
            &lt;PPAnimatedTabs v-model="animatedTabVal" :tabs="animatedTabs"&gt;
              &lt;template #tab-0&gt;
                &lt;div style="padding: 24px; color: white;"&gt;
                  &lt;h3 style="color: white; font-size: 24px;"&gt;Welcome Home&lt;/h3&gt;
                  &lt;p&gt;Slide transition applies smoothly across tabs.&lt;/p&gt;
                &lt;/div&gt;
              &lt;/template&gt;
              &lt;template #tab-1&gt;
                &lt;div style="padding: 24px; color: white;"&gt;
                  &lt;h3 style="color: white; font-size: 24px;"&gt;Transaction History&lt;/h3&gt;
                  &lt;p&gt;All your recent transactions appear here.&lt;/p&gt;
                &lt;/div&gt;
              &lt;/template&gt;
              &lt;template #tab-2&gt;
                &lt;div style="padding: 24px; color: white;"&gt;
                  &lt;h3 style="color: white; font-size: 24px;"&gt;Your Profile&lt;/h3&gt;
                  &lt;p&gt;Manage your account settings.&lt;/p&gt;
                &lt;/div&gt;
              &lt;/template&gt;
            &lt;/PPAnimatedTabs&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPAnimatedTabs v-model="activeTab" :tabs="tabs"&amp;gt;
  &amp;lt;template #tab-0&amp;gt;Content 1&amp;lt;/template&amp;gt;
  &amp;lt;template #tab-1&amp;gt;Content 2&amp;lt;/template&amp;gt;
&amp;lt;/PPAnimatedTabs&amp;gt;&lt;/code&gt;&lt;/pre&gt;
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

const animatedTabVal = ref(0);

const animatedTabs = ref([
  { label: 'Home', icon: homeOutline },
  { label: 'History', icon: documentTextOutline },
  { label: 'Profile', icon: personOutline }
]);



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

const animatedTabVal = ref(0);

const animatedTabs = ref([
  { label: 'Home', icon: homeOutline },
  { label: 'History', icon: documentTextOutline },
  { label: 'Profile', icon: personOutline }
]);



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
