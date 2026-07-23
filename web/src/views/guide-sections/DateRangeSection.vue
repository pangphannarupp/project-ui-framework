<template>
<div class="guide-section">
        <h2>PPDateRangePicker</h2>
        <p class="guide-desc">A date range picker for desktop with presets and a double-month calendar view.</p>
        <div class="variant-group">
          <h3>Desktop Usage</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPDateRangePicker&gt;</code></p>
          <div class="component-demo">
            <PPDateRangePicker 
              v-model="dateRangeVal"
              @apply="onDateRangeApply"
            />
          </div>
          <pre class="code-block"><code>&lt;PPDateRangePicker v-model="dateRange" /&gt;</code></pre>
        </div>
        <div class="variant-group">
          <h3>Hide Header Controls</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPDateRangePicker&gt;</code> with <code>hide-header-picker</code> and <code>hide-nav-buttons</code></p>
          <div class="component-demo">
            <PPDateRangePicker 
              v-model="dateRangeVal2"
              :hide-header-picker="true"
              :hide-nav-buttons="true"
              @apply="onDateRangeApply"
            />
          </div>
          <pre class="code-block"><code>&lt;PPDateRangePicker v-model="dateRange" :hide-header-picker="true" :hide-nav-buttons="true" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Alert Overlay</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPDateRangePickerAlert&gt;</code></p>
          <div class="component-demo">
            <PPButton @click="showDateRangePickerAlert = true" variant="primary">Open Date Range Picker Alert</PPButton>
            <PPDateRangePickerAlert 
              v-model="showDateRangePickerAlert"
              :initialValue="dateRangeVal"
              @confirm="onDateRangeApply"
            />
          </div>
          <pre class="code-block"><code>&lt;PPDateRangePickerAlert v-model="isOpen" :initialValue="dateRange" @confirm="onConfirm" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Bottom Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPDateRangePickerSheet&gt;</code></p>
          <div class="component-demo">
            <PPButton @click="showDateRangePickerSheet = true" variant="primary">Open Date Range Picker Sheet</PPButton>
            <PPDateRangePickerSheet 
              v-model:visible="showDateRangePickerSheet"
              v-model="dateRangeVal"
              @apply="onDateRangeApply"
            />
            
            <div style="margin-top: 16px; padding: 12px; background: #f3f4f6; border-radius: 8px;">
              <strong>Selected Range:</strong> 
              <pre>{{ JSON.stringify(dateRangeVal, null, 2) }}</pre>
            </div>
          </div>
          <pre class="code-block"><code>&lt;PPDateRangePickerSheet v-model:visible="isOpen" v-model="dateRange" @apply="onApply" /&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const showDateRangePickerSheet = ref(false);

const showDateRangePickerAlert = ref(false);

const dateRangeVal = ref({ start: null, end: null, presetId: undefined });
const dateRangeVal2 = ref({ start: null, end: null, presetId: undefined });

const onDateRangeApply = (val: any) => {
  console.log('Date range applied:', val);
};



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPDateRangePicker, PPDateRangePickerAlert, PPDateRangePickerSheet, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
