<template>
<div class="guide-section">
        <h2>14. Time Picker</h2>

        <div class="variant-group">
          <h3>Standard Time Picker</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPTimePicker&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden; padding: 16px;">
            <PPTimePicker 
              v-model="timeVal"
              @change="(v) => alertVal('Selected Time: ' + v)"
            />
          </div>
          <pre class="code-block"><code>&lt;PPTimePicker v-model="timeVal" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Time Picker Bottom Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPTimePickerSheet&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showTimePickerSheet = true">Open Time Sheet</PPButton>
            <PPTimePickerSheet 
              v-model="showTimePickerSheet"
              v-model:timeValue="timeSheetVal"
              title="Select a Time"
              :showActionButtons="true"
              @confirm="() => { alertVal('Confirmed Time: ' + timeSheetVal); showTimePickerSheet = false; }"
              @cancel="showTimePickerSheet = false"
            />
          </div>
          <pre class="code-block"><code>&lt;PPTimePickerSheet v-model="isOpen" v-model:timeValue="val" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Time Picker Island Popup</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPTimePickerIsland&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showTimePickerIsland = true">Open Time Picker Island</PPButton>
            <PPTimePickerIsland 
              v-model="showTimePickerIsland"
              v-model:timeValue="timeIslandVal"
              :showActionButtons="true"
              @confirm="() => { alertVal('Confirmed Time: ' + timeIslandVal); showTimePickerIsland = false; }"
              @cancel="showTimePickerIsland = false"
            />
          </div>
          <pre class="code-block"><code>&lt;PPTimePickerIsland v-model="isOpen" v-model:timeValue="val" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Time Picker Alert</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPTimePickerAlert&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showTimePickerAlert = true">Open Time Alert</PPButton>
            <PPTimePickerAlert 
              v-model="showTimePickerAlert"
              v-model:timeValue="timeAlertVal"
              title="Select a Time"
              @confirm="() => { alertVal('Confirmed Time: ' + timeAlertVal); showTimePickerAlert = false; }"
              @cancel="showTimePickerAlert = false"
            />
          </div>
          <pre class="code-block"><code>&lt;PPTimePickerAlert v-model="isOpen" v-model:timeValue="val" /&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const timeVal = ref('13:45');

const timeSheetVal = ref('12:00');

const timeIslandVal = ref('12:00');

const showTimePickerSheet = ref(false);

const timeAlertVal = ref('09:30');

const showTimePickerAlert = ref(false);

const showTimePickerIsland = ref(false);

const alertVal = (type: string) => console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
