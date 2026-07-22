<template>
<div class="guide-section">
        <h2>Floating Action Button (FAB)</h2>
        <div class="variant-group">
          <h3>Standard FAB & Speed Dial</h3>
          <div class="component-demo">
            <PPFab position="bottom-right">
              <template #list>
                <PPFabList side="top">
                  <PPFabAction color="primary" @click="alertVal('Action 1')">1</PPFabAction>
                  <PPFabAction color="danger" @click="alertVal('Action 2')">2</PPFabAction>
                </PPFabList>
              </template>
            </PPFab>
            
            <PPFab position="bottom-left" color="secondary" :extended="isExtended">
              Extended FAB
            </PPFab>
            
            <div style="padding-bottom: 20px;">
              <PPButton @click="isExtended = !isExtended">Toggle Extended FAB</PPButton>
            </div>
          </div>
          <pre class="code-block"><code>&lt;PPFab position="bottom-right"&gt;
  &lt;template #list&gt;
    &lt;PPFabList side="top"&gt;
      &lt;PPFabAction color="primary" @click="doSomething"&gt;1&lt;/PPFabAction&gt;
    &lt;/PPFabList&gt;
  &lt;/template&gt;
&lt;/PPFab&gt;

&lt;PPFab position="bottom-left" color="secondary" :extended="isExtended"&gt;
  Extended FAB
&lt;/PPFab&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const alertVal = (type: string) => console.log('Setup: ' + type);
const isExtended = ref(true);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>

<style scoped>
.guide-section {
  display: flex;
  flex-direction: column;
  gap: 24px;
}
.component-demo {
  position: relative;
  min-height: 200px;
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 24px;
  background: #f9fafb;
  overflow: hidden;
}
</style>
