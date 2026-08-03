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

        <div class="variant-group">
          <h3>Circle Speed Dial</h3>
          <div class="component-demo" style="min-height: 400px; position: relative;">
            <p style="text-align: center; margin-bottom: 24px; color: #6b7280;">Click the center FAB to see the actions expand in a circle.</p>

            <!-- Full Circle Speed Dial -->
            <PPFab position="center" color="primary">
              <template #icon>
                <IonIcon :icon="addOutline" />
              </template>
              <template #list>
                <PPFabList side="circle" :circleRadius="80">
                  <PPFabAction color="primary"><IonIcon :icon="shareOutline" /></PPFabAction>
                  <PPFabAction color="danger"><IonIcon :icon="trashOutline" /></PPFabAction>
                  <PPFabAction color="secondary"><IonIcon :icon="documentTextOutline" /></PPFabAction>
                  <PPFabAction color="light"><IonIcon :icon="personOutline" /></PPFabAction>
                  <PPFabAction color="light"><IonIcon :icon="settingsOutline" /></PPFabAction>
                </PPFabList>
              </template>
            </PPFab>
            
            <!-- Semi-Circle Speed Dial (Top) -->
            <PPFab position="bottom-right" color="danger">
              <template #icon>
                <IonIcon :icon="addOutline" />
              </template>
              <template #list>
                <!-- A top semi-circle uses angles from -90 to 90. -->
                <PPFabList side="circle" :circleStartAngle="-90" :circleEndAngle="0" :circleRadius="90">
                  <PPFabAction color="light"><IonIcon :icon="chatbubbleOutline" /></PPFabAction>
                  <PPFabAction color="light"><IonIcon :icon="phonePortraitOutline" /></PPFabAction>
                  <PPFabAction color="light"><IonIcon :icon="personOutline" /></PPFabAction>
                </PPFabList>
              </template>
            </PPFab>

          </div>
          <pre class="code-block"><code>&lt;!-- Full Circle Speed Dial --&gt;
&lt;PPFab position="center"&gt;
  &lt;template #list&gt;
    &lt;PPFabList side="circle" :circleRadius="80"&gt;
      &lt;PPFabAction&gt;1&lt;/PPFabAction&gt;
      &lt;PPFabAction&gt;2&lt;/PPFabAction&gt;
      &lt;PPFabAction&gt;3&lt;/PPFabAction&gt;
      &lt;PPFabAction&gt;4&lt;/PPFabAction&gt;
    &lt;/PPFabList&gt;
  &lt;/template&gt;
&lt;/PPFab&gt;

&lt;!-- Quarter/Semi Circle Speed Dial --&gt;
&lt;PPFab position="bottom-right"&gt;
  &lt;template #list&gt;
    &lt;PPFabList side="circle" :circleStartAngle="-90" :circleEndAngle="0" :circleRadius="90"&gt;
      &lt;PPFabAction&gt;1&lt;/PPFabAction&gt;
      &lt;PPFabAction&gt;2&lt;/PPFabAction&gt;
      &lt;PPFabAction&gt;3&lt;/PPFabAction&gt;
    &lt;/PPFabList&gt;
  &lt;/template&gt;
&lt;/PPFab&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Shapes and Morph Animation</h3>
          <div class="component-demo" style="min-height: 400px; position: relative; overflow: hidden; transform: translateZ(0);">
            
            <!-- Rounded Shape -->
            <PPFab position="top-right" color="danger" shape="rounded">
              <template #icon>
                <IonIcon :icon="trashOutline" />
              </template>
            </PPFab>
            
            <!-- Square Shape -->
            <PPFab position="top-left" color="secondary" shape="square">
              <template #icon>
                <IonIcon :icon="documentTextOutline" />
              </template>
            </PPFab>

            <!-- Morph Animation to Full Screen -->
            <PPFab position="center" color="primary" morph>
              <template #icon>
                <IonIcon :icon="addOutline" />
              </template>
              <template #morph-content>
                <div style="padding: 60px 40px; color: white; display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100%; text-align: center;">
                  <h2 style="color: white; margin-bottom: 16px; font-size: 32px;">Create New Item</h2>
                  <p style="font-size: 18px; max-width: 400px; line-height: 1.5;">This is the fullscreen morph content. The button expands to fill the entire screen, and you can render anything you need right here!</p>
                  
                  <div style="margin-top: 40px; display: flex; gap: 16px;">
                     <PPButton variant="soft" style="background: rgba(255,255,255,0.2); color: white;">Save Draft</PPButton>
                     <PPButton variant="solid" color="secondary" style="background: white; color: var(--pp-primary-variant, #1a2a5e);">Publish Now</PPButton>
                  </div>
                </div>
              </template>
            </PPFab>

          </div>
          <pre class="code-block"><code>&lt;!-- Different Shapes --&gt;
&lt;PPFab shape="circle"&gt;&lt;/PPFab&gt;
&lt;PPFab shape="rounded"&gt;&lt;/PPFab&gt;
&lt;PPFab shape="square"&gt;&lt;/PPFab&gt;

&lt;!-- Morph Animation --&gt;
&lt;PPFab morph color="primary"&gt;
  &lt;template #icon&gt;
    &lt;IonIcon :icon="addOutline" /&gt;
  &lt;/template&gt;
  &lt;template #morph-content&gt;
    &lt;div class="fullscreen-content"&gt;...&lt;/div&gt;
  &lt;/template&gt;
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
