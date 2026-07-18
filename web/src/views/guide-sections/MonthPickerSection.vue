<template>
<div class="guide-section">
        <h2>13. Month Picker</h2>

        <div class="variant-group">
          <h3>Standard Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Single' }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <BizMonthPicker 
              @month-selected="s => alertVal('Selected Month: ' + s.month + '/' + s.year)"
            />
          </div>
          <pre class="code-block"><code>&lt;BizMonthPicker @month-selected="onSelect" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Range Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Range' }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <BizMonthPicker 
              :config="{ selectionMode: 'Range' }"
              @range-selected="(start, end) => alertVal('Range: ' + (start ? start.month + '/' + start.year : '') + ' to ' + (end ? end.month + '/' + end.year : ''))"
            />
          </div>
          <pre class="code-block"><code>&lt;BizMonthPicker :config="{ selectionMode: 'Range' }" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Month Picker Bottom Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizMonthPickerSheet&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <BizButton @click="showMonthPickerSheet = true">Open Month Sheet</BizButton>
            <BizMonthPickerSheet 
              v-model="showMonthPickerSheet"
              title="Select a Month"
              :showActionButtons="true"
              @confirm="(s) => { alertVal('Confirmed: ' + (s ? s.month + '/' + s.year : '')); showMonthPickerSheet = false; }"
              @cancel="showMonthPickerSheet = false"
            />
          </div>
          <pre class="code-block"><code>&lt;BizMonthPickerSheet v-model="isOpen" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Month Picker Island Popup</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizMonthPickerIsland&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <BizButton @click="showMonthPickerIsland = true">Open Month Picker Island</BizButton>
            <BizMonthPickerIsland 
              v-model="showMonthPickerIsland"
              :showActionButtons="true"
              @confirm="s => { alertVal('Confirmed Month: ' + (s ? s.month + '/' + s.year : 'none')); showMonthPickerIsland = false; }"
              @cancel="showMonthPickerIsland = false"
            />
          </div>
          <pre class="code-block"><code>&lt;BizMonthPickerIsland v-model="isOpen" /&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const showMonthPickerSheet = ref(false);

const showMonthPickerIsland = ref(false);

const alertVal = (type: string) => console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { BizButton, BizButtonGroup, BizImageTransition, BizSwipeItem, BizSlider, BizSwitch, BizBarChart, BizLineChart, BizDonutChart, BizPieChart, BizRadarChart, BizProgressGauge, BizScatterChart, BizFunnelChart, BizSkeleton, BizSkeletonItem, BizSkeletonList, BizSkeletonDetail, BizHideAppBar, BizBottomNav, BizFab, BizFabList, BizFabAction, BizNumberSpinner, BizRadio, BizRadioGroup, BizRating, BizCollapsingToolbar, BizPullToRefresh, BizInput, BizTextField, BizSelect, BizTransferList, BizToggleButton, BizCheckbox, BizCheckboxGroup, BizPhoneInput, BizOtpInput, BizInfoCard, BizActionCard, BizAccountCard, BizSegment, BizSegmentButton, BizCompanySelector, BizScrollSegment, BizScrollSegmentButton, BizNotificationItem, BizPinDots, BizKeypad, BizSecureKeypad, BizSecureKeyboard, BizKhmerKeyboard, BizToast, BizConfirmSheet, BizReceiveAmountSheet, BizAccountSavingCard, BizReceivingAccountSheet, BizKhmerCalendar, BizKhmerCalendarSheet, BizKhmerCalendarAlert, BizKhmerCalendarIsland, BizCalendar, BizCalendarSheet, BizCalendarAlert, BizCalendarIsland, BizFileUpload, BizMonthPicker, BizMonthPickerSheet, BizMonthPickerAlert, BizMonthPickerIsland, BizYearPicker, BizYearPickerSheet, BizYearPickerAlert, BizYearPickerIsland, BizTimePicker, BizTimePickerSheet, BizTimePickerAlert, BizTimePickerIsland, BizAutocomplete, BizAccountListCard, BizAccountReorderList, BizColorPicker, BizColorPickerSheet, BizColorPickerAlert, BizColorPickerIsland, BizNavigationDrawer, BizNavigationRail, BizDynamicIsland, BizCollapse, BizCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
