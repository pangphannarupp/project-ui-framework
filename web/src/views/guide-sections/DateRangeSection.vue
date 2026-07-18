<template>
<div class="guide-section">
        <h2>BizDateRangePicker</h2>
        <p class="guide-desc">A date range picker for desktop with presets and a double-month calendar view.</p>
        <div class="variant-group">
          <h3>Desktop Usage</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizDateRangePicker&gt;</code></p>
          <div class="component-demo">
            <BizDateRangePicker 
              v-model="dateRangeVal"
              @apply="onDateRangeApply"
            />
          </div>
          <pre class="code-block"><code>&lt;BizDateRangePicker v-model="dateRange" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Alert Overlay</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizDateRangePickerAlert&gt;</code></p>
          <div class="component-demo">
            <BizButton @click="showDateRangePickerAlert = true" variant="primary">Open Date Range Picker Alert</BizButton>
            <BizDateRangePickerAlert 
              v-model="showDateRangePickerAlert"
              :initialValue="dateRangeVal"
              @confirm="onDateRangeApply"
            />
          </div>
          <pre class="code-block"><code>&lt;BizDateRangePickerAlert v-model="isOpen" :initialValue="dateRange" @confirm="onConfirm" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Bottom Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizDateRangePickerSheet&gt;</code></p>
          <div class="component-demo">
            <BizButton @click="showDateRangePickerSheet = true" variant="primary">Open Date Range Picker Sheet</BizButton>
            <BizDateRangePickerSheet 
              v-model:visible="showDateRangePickerSheet"
              v-model="dateRangeVal"
              @apply="onDateRangeApply"
            />
            
            <div style="margin-top: 16px; padding: 12px; background: #f3f4f6; border-radius: 8px;">
              <strong>Selected Range:</strong> 
              <pre>{{ JSON.stringify(dateRangeVal, null, 2) }}</pre>
            </div>
          </div>
          <pre class="code-block"><code>&lt;BizDateRangePickerSheet v-model:visible="isOpen" v-model="dateRange" @apply="onApply" /&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const showDateRangePickerSheet = ref(false);

const showDateRangePickerAlert = ref(false);

const dateRangeVal = ref({ start: null, end: null, presetId: undefined });

const onDateRangeApply = (val: any) => {
  console.log('Date range applied:', val);
};



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { BizButton, BizButtonGroup, BizImageTransition, BizSwipeItem, BizSlider, BizSwitch, BizBarChart, BizLineChart, BizDonutChart, BizPieChart, BizRadarChart, BizProgressGauge, BizScatterChart, BizFunnelChart, BizSkeleton, BizSkeletonItem, BizSkeletonList, BizSkeletonDetail, BizHideAppBar, BizBottomNav, BizFab, BizFabList, BizFabAction, BizNumberSpinner, BizRadio, BizRadioGroup, BizRating, BizCollapsingToolbar, BizPullToRefresh, BizInput, BizTextField, BizSelect, BizTransferList, BizToggleButton, BizCheckbox, BizCheckboxGroup, BizPhoneInput, BizOtpInput, BizInfoCard, BizActionCard, BizAccountCard, BizSegment, BizSegmentButton, BizCompanySelector, BizScrollSegment, BizScrollSegmentButton, BizNotificationItem, BizPinDots, BizKeypad, BizSecureKeypad, BizSecureKeyboard, BizKhmerKeyboard, BizToast, BizConfirmSheet, BizReceiveAmountSheet, BizAccountSavingCard, BizReceivingAccountSheet, BizKhmerCalendar, BizKhmerCalendarSheet, BizKhmerCalendarAlert, BizKhmerCalendarIsland, BizCalendar, BizCalendarSheet, BizCalendarAlert, BizCalendarIsland, BizFileUpload, BizMonthPicker, BizMonthPickerSheet, BizMonthPickerAlert, BizMonthPickerIsland, BizYearPicker, BizYearPickerSheet, BizYearPickerAlert, BizYearPickerIsland, BizTimePicker, BizTimePickerSheet, BizTimePickerAlert, BizTimePickerIsland, BizAutocomplete, BizAccountListCard, BizAccountReorderList, BizColorPicker, BizColorPickerSheet, BizColorPickerAlert, BizColorPickerIsland, BizNavigationDrawer, BizNavigationRail, BizDynamicIsland, BizCollapse, BizCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
