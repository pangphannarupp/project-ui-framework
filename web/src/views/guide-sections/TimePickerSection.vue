<template>
<div class="guide-section">
        <h2>14. Time Picker</h2>

        <div class="variant-group">
          <h3>Standard Time Picker</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizTimePicker&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden; padding: 16px;">
            <BizTimePicker 
              v-model="timeVal"
              @change="(v) => alertVal('Selected Time: ' + v)"
            />
          </div>
          <pre class="code-block"><code>&lt;BizTimePicker v-model="timeVal" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Time Picker Bottom Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizTimePickerSheet&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <BizButton @click="showTimePickerSheet = true">Open Time Sheet</BizButton>
            <BizTimePickerSheet 
              v-model="showTimePickerSheet"
              v-model:timeValue="timeSheetVal"
              title="Select a Time"
              :showActionButtons="true"
              @confirm="() => { alertVal('Confirmed Time: ' + timeSheetVal); showTimePickerSheet = false; }"
              @cancel="showTimePickerSheet = false"
            />
          </div>
          <pre class="code-block"><code>&lt;BizTimePickerSheet v-model="isOpen" v-model:timeValue="val" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Time Picker Island Popup</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizTimePickerIsland&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <BizButton @click="showTimePickerIsland = true">Open Time Picker Island</BizButton>
            <BizTimePickerIsland 
              v-model="showTimePickerIsland"
              v-model:timeValue="timeIslandVal"
              :showActionButtons="true"
              @confirm="() => { alertVal('Confirmed Time: ' + timeIslandVal); showTimePickerIsland = false; }"
              @cancel="showTimePickerIsland = false"
            />
          </div>
          <pre class="code-block"><code>&lt;BizTimePickerIsland v-model="isOpen" v-model:timeValue="val" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Time Picker Alert</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizTimePickerAlert&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <BizButton @click="showTimePickerAlert = true">Open Time Alert</BizButton>
            <BizTimePickerAlert 
              v-model="showTimePickerAlert"
              v-model:timeValue="timeAlertVal"
              title="Select a Time"
              @confirm="() => { alertVal('Confirmed Time: ' + timeAlertVal); showTimePickerAlert = false; }"
              @cancel="showTimePickerAlert = false"
            />
          </div>
          <pre class="code-block"><code>&lt;BizTimePickerAlert v-model="isOpen" v-model:timeValue="val" /&gt;</code></pre>
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

import { BizButton, BizButtonGroup, BizImageTransition, BizSwipeItem, BizSlider, BizSwitch, BizBarChart, BizLineChart, BizDonutChart, BizPieChart, BizRadarChart, BizProgressGauge, BizScatterChart, BizFunnelChart, BizSkeleton, BizSkeletonItem, BizSkeletonList, BizSkeletonDetail, BizHideAppBar, BizBottomNav, BizFab, BizFabList, BizFabAction, BizNumberSpinner, BizRadio, BizRadioGroup, BizRating, BizCollapsingToolbar, BizPullToRefresh, BizInput, BizTextField, BizSelect, BizTransferList, BizToggleButton, BizCheckbox, BizCheckboxGroup, BizPhoneInput, BizOtpInput, BizInfoCard, BizActionCard, BizAccountCard, BizSegment, BizSegmentButton, BizCompanySelector, BizScrollSegment, BizScrollSegmentButton, BizNotificationItem, BizPinDots, BizKeypad, BizSecureKeypad, BizSecureKeyboard, BizKhmerKeyboard, BizToast, BizConfirmSheet, BizReceiveAmountSheet, BizAccountSavingCard, BizReceivingAccountSheet, BizKhmerCalendar, BizKhmerCalendarSheet, BizKhmerCalendarAlert, BizKhmerCalendarIsland, BizCalendar, BizCalendarSheet, BizCalendarAlert, BizCalendarIsland, BizFileUpload, BizMonthPicker, BizMonthPickerSheet, BizMonthPickerAlert, BizMonthPickerIsland, BizYearPicker, BizYearPickerSheet, BizYearPickerAlert, BizYearPickerIsland, BizTimePicker, BizTimePickerSheet, BizTimePickerAlert, BizTimePickerIsland, BizAutocomplete, BizAccountListCard, BizAccountReorderList, BizColorPicker, BizColorPickerSheet, BizColorPickerAlert, BizColorPickerIsland, BizNavigationDrawer, BizNavigationRail, BizDynamicIsland, BizCollapse, BizCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
