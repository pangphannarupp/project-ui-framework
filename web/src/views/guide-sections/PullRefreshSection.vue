<template>
<div class="guide-section">
        <h2>Pull to Refresh</h2>
        <div class="variant-group">
          <h3>Interactive Refresher</h3>
          <p class="custom-guide">Drag the list down inside this container to trigger a refresh!</p>
          <div class="component-demo" style="height: 300px; padding: 0; border-radius: 12px; overflow: hidden; position: relative; border: 1px solid #ddd;">
            <PPPullToRefresh @refresh="handleRefresh">
              <div style="padding: 16px;">
                <div v-for="i in 15" :key="i" style="padding: 16px; border-bottom: 1px solid #eee; background: white;">
                  Item {{ i }} in the scrollable list
                </div>
              </div>
            </PPPullToRefresh>
          </div>
          <pre v-pre class="code-block"><code>&lt;PPPullToRefresh @refresh="handleRefresh"&gt;
  &lt;div class="content"&gt;
    &lt;!-- Your scrollable content here --&gt;
    &lt;div v-for="i in 15" :key="i"&gt;Item {{ i }}&lt;/div&gt;
  &lt;/div&gt;
&lt;/PPPullToRefresh&gt;

&lt;script setup&gt;
const handleRefresh = (complete) =&gt; {
  // Perform async refresh action
  setTimeout(() =&gt; {
    complete(); // Call complete() when finished
  }, 1500);
};
&lt;/script&gt;</code></pre>
        </div>
      
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  /* This component does not use CSS variables directly. */
  /* Use custom classes to override styles. */
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
        &lt;h2&gt;Pull to Refresh&lt;/h2&gt;
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Interactive Refresher&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;Drag the list down inside this container to trigger a refresh!&lt;/p&gt;
          &lt;div class="component-demo" style="height: 300px; padding: 0; border-radius: 12px; overflow: hidden; position: relative; border: 1px solid #ddd;"&gt;
            &lt;PPPullToRefresh @refresh="handleRefresh"&gt;
              &lt;div style="padding: 16px;"&gt;
                &lt;div v-for="i in 15" :key="i" style="padding: 16px; border-bottom: 1px solid #eee; background: white;"&gt;
                  Item {{ i }} in the scrollable list
                &lt;/div&gt;
              &lt;/div&gt;
            &lt;/PPPullToRefresh&gt;
          &lt;/div&gt;
          &lt;pre v-pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPPullToRefresh @refresh="handleRefresh"&amp;gt;
  &amp;lt;div class="content"&amp;gt;
    &amp;lt;!-- Your scrollable content here --&amp;gt;
    &amp;lt;div v-for="i in 15" :key="i"&amp;gt;Item {{ i }}&amp;lt;/div&amp;gt;
  &amp;lt;/div&amp;gt;
&amp;lt;/PPPullToRefresh&amp;gt;

&amp;lt;script setup&amp;gt;
const handleRefresh = (complete) =&amp;gt; {
  // Perform async refresh action
  setTimeout(() =&amp;gt; {
    complete(); // Call complete() when finished
  }, 1500);
};
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
      
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  /* This component does not use CSS variables directly. */
  /* Use custom classes to override styles. */
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
&lt;/div&gt;
&lt;/template&gt;

&lt;script setup lang="ts"&gt;
const alertVal = (msg: any) =&gt; alert(msg);
import { ref, computed } from 'vue';

const handleRefresh = (complete: () =&gt; void) =&gt; {
  setTimeout(() =&gt; {
    alertVal('Refresh Complete!');
    complete();
  }, 1500);
};



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
const alertVal = (msg: any) => alert(msg);
import { ref, computed } from 'vue';

const handleRefresh = (complete: () => void) => {
  setTimeout(() => {
    alertVal('Refresh Complete!');
    complete();
  }, 1500);
};



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
