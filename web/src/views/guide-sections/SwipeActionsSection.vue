<template>
<div class="guide-section">
        <h2>Swipe Actions (List Items)</h2>
        <div class="variant-group">
          <h3>Swipe Left & Right</h3>
          <p class="custom-guide">Swipe horizontally to reveal actions. Supports rubber-banding physics.</p>
          <div class="component-demo" style="padding: 0; background: transparent; border-radius: 12px; overflow: hidden; border: 1px solid #eee; transform: translateZ(0); isolation: isolate;">
            <PPSwipeItem style="border-bottom: 1px solid #eee;">
              <template #left>
                <div style="background: #28ba62;" @click="alertVal('Pinned!')">
                  Pin
                </div>
              </template>
              <template #right>
                <div style="background: #ffc409; color: #333;" @click="alertVal('Edited!')">
                  Edit
                </div>
                <div style="background: #eb445a;" @click="alertVal('Deleted!')">
                  Delete
                </div>
              </template>
              <div style="padding: 16px; background: white;">
                <h4 style="margin: 0; color: #333;">Swipe me both ways</h4>
                <p style="margin: 4px 0 0; color: #666; font-size: 14px;">I have actions on both sides!</p>
              </div>
            </PPSwipeItem>
            
            <PPSwipeItem>
              <template #right>
                <div style="background: #eb445a;" @click="alertVal('Deleted!')">
                  Delete
                </div>
              </template>
              <div style="padding: 16px; background: white;">
                <h4 style="margin: 0; color: #333;">Swipe me left only</h4>
                <p style="margin: 4px 0 0; color: #666; font-size: 14px;">Only a delete button on the right.</p>
              </div>
            </PPSwipeItem>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPSwipeItem&gt;
  &lt;!-- Left actions (revealed by swiping right) --&gt;
  &lt;template #left&gt;
    &lt;div style="background: #28ba62;" @click="pin"&gt;Pin&lt;/div&gt;
  &lt;/template&gt;

  &lt;!-- Right actions (revealed by swiping left) --&gt;
  &lt;template #right&gt;
    &lt;div style="background: #eb445a;" @click="remove"&gt;Delete&lt;/div&gt;
  &lt;/template&gt;
  
  &lt;!-- Main Content --&gt;
  &lt;div class="content"&gt;
    &lt;h4&gt;Swipe me&lt;/h4&gt;
  &lt;/div&gt;
&lt;/PPSwipeItem&gt;</code></pre>
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
        &lt;h2&gt;Swipe Actions (List Items)&lt;/h2&gt;
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Swipe Left &amp; Right&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;Swipe horizontally to reveal actions. Supports rubber-banding physics.&lt;/p&gt;
          &lt;div class="component-demo" style="padding: 0; background: transparent; border-radius: 12px; overflow: hidden; border: 1px solid #eee; transform: translateZ(0); isolation: isolate;"&gt;
            &lt;PPSwipeItem style="border-bottom: 1px solid #eee;"&gt;
              &lt;template #left&gt;
                &lt;div style="background: #28ba62;" @click="alertVal('Pinned!')"&gt;
                  Pin
                &lt;/div&gt;
              &lt;/template&gt;
              &lt;template #right&gt;
                &lt;div style="background: #ffc409; color: #333;" @click="alertVal('Edited!')"&gt;
                  Edit
                &lt;/div&gt;
                &lt;div style="background: #eb445a;" @click="alertVal('Deleted!')"&gt;
                  Delete
                &lt;/div&gt;
              &lt;/template&gt;
              &lt;div style="padding: 16px; background: white;"&gt;
                &lt;h4 style="margin: 0; color: #333;"&gt;Swipe me both ways&lt;/h4&gt;
                &lt;p style="margin: 4px 0 0; color: #666; font-size: 14px;"&gt;I have actions on both sides!&lt;/p&gt;
              &lt;/div&gt;
            &lt;/PPSwipeItem&gt;
            
            &lt;PPSwipeItem&gt;
              &lt;template #right&gt;
                &lt;div style="background: #eb445a;" @click="alertVal('Deleted!')"&gt;
                  Delete
                &lt;/div&gt;
              &lt;/template&gt;
              &lt;div style="padding: 16px; background: white;"&gt;
                &lt;h4 style="margin: 0; color: #333;"&gt;Swipe me left only&lt;/h4&gt;
                &lt;p style="margin: 4px 0 0; color: #666; font-size: 14px;"&gt;Only a delete button on the right.&lt;/p&gt;
              &lt;/div&gt;
            &lt;/PPSwipeItem&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPSwipeItem&amp;gt;
  &amp;lt;!-- Left actions (revealed by swiping right) --&amp;gt;
  &amp;lt;template #left&amp;gt;
    &amp;lt;div style="background: #28ba62;" @click="pin"&amp;gt;Pin&amp;lt;/div&amp;gt;
  &amp;lt;/template&amp;gt;

  &amp;lt;!-- Right actions (revealed by swiping left) --&amp;gt;
  &amp;lt;template #right&amp;gt;
    &amp;lt;div style="background: #eb445a;" @click="remove"&amp;gt;Delete&amp;lt;/div&amp;gt;
  &amp;lt;/template&amp;gt;
  
  &amp;lt;!-- Main Content --&amp;gt;
  &amp;lt;div class="content"&amp;gt;
    &amp;lt;h4&amp;gt;Swipe me&amp;lt;/h4&amp;gt;
  &amp;lt;/div&amp;gt;
&amp;lt;/PPSwipeItem&amp;gt;&lt;/code&gt;&lt;/pre&gt;
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
import { ref, computed } from 'vue';

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

const alertVal = (type: string) => console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
