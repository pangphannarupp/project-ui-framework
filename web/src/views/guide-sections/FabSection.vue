<template>
<div class="guide-section">
        <h2>Floating Action Button (FAB)</h2>
        <div class="variant-group">
          <h3>Standard FAB & Speed Dial</h3>
          <div class="component-demo" style="min-height: 400px; position: relative;">
            
            <!-- Standard -->
            <PPFab position="bottom-right" variant="solid" color="primary">
              <template #list>
                <PPFabList side="top">
                  <PPFabAction color="primary" @click="alertVal('Action 1')">1</PPFabAction>
                  <PPFabAction color="danger" @click="alertVal('Action 2')">2</PPFabAction>
                </PPFabList>
              </template>
            </PPFab>
            
            <!-- Extended -->
            <PPFab position="bottom-left" color="secondary" :extended="isExtended">
              Extended FAB
            </PPFab>

            <!-- Gradient Variant -->
            <PPFab position="center" variant="gradient" style="margin-top: -120px;">
              <template #icon>
                <IonIcon :icon="rocketOutline" />
              </template>
            </PPFab>

            <!-- Soft Variant -->
            <PPFab position="center" variant="soft" style="margin-left: -100px; margin-top: 40px;">
              <template #icon>
                <IonIcon :icon="layersOutline" />
              </template>
            </PPFab>

            <!-- Outline Variant -->
            <PPFab position="center" variant="outline" style="margin-left: 100px; margin-top: 40px;">
              <template #icon>
                <IonIcon :icon="searchOutline" />
              </template>
            </PPFab>

            <!-- Glass Variant -->
            <!-- Glass looks best on an image or pattern, but we'll demonstrate it here -->
            <div style="position: absolute; top: 20px; right: 20px; width: 100px; height: 100px; background: linear-gradient(45deg, #f093fb 0%, #f5576c 100%); border-radius: 12px; display: flex; align-items: center; justify-content: center;">
              <PPFab position="center" variant="glass" style="position: relative; top: 0; left: 0; transform: none;">
                <template #icon>
                  <IonIcon :icon="chatbubbleOutline" />
                </template>
              </PPFab>
            </div>
            
            <div style="padding-bottom: 20px; position: relative; z-index: 10;">
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
