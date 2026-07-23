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
          <pre class="code-block"><code>&lt;PPPullToRefresh @refresh="handleRefresh"&gt;
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
      </div>
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
