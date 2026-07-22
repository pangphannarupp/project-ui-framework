<template>
<div class="guide-section">
        <h2>13. Month Picker</h2>

        <div class="variant-group">
          <h3>Standard Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Single' }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <PPMonthPicker 
              @month-selected="s => alertVal('Selected Month: ' + s.month + '/' + s.year)"
            />
          </div>
          <pre class="code-block"><code>&lt;PPMonthPicker @month-selected="onSelect" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Range Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Range' }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <PPMonthPicker 
              :config="{ selectionMode: 'Range' }"
              @range-selected="(start, end) => alertVal('Range: ' + (start ? start.month + '/' + start.year : '') + ' to ' + (end ? end.month + '/' + end.year : ''))"
            />
          </div>
          <pre class="code-block"><code>&lt;PPMonthPicker :config="{ selectionMode: 'Range' }" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Month Picker Bottom Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPMonthPickerSheet&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showMonthPickerSheet = true">Open Month Sheet</PPButton>
            <PPMonthPickerSheet 
              v-model="showMonthPickerSheet"
              title="Select a Month"
              :showActionButtons="true"
              @confirm="(s) => { alertVal('Confirmed: ' + (s ? s.month + '/' + s.year : '')); showMonthPickerSheet = false; }"
              @cancel="showMonthPickerSheet = false"
            />
          </div>
          <pre class="code-block"><code>&lt;PPMonthPickerSheet v-model="isOpen" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Month Picker Island Popup</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPMonthPickerIsland&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showMonthPickerIsland = true">Open Month Picker Island</PPButton>
            <PPMonthPickerIsland 
              v-model="showMonthPickerIsland"
              :showActionButtons="true"
              @confirm="s => { alertVal('Confirmed Month: ' + (s ? s.month + '/' + s.year : 'none')); showMonthPickerIsland = false; }"
              @cancel="showMonthPickerIsland = false"
            />
          </div>
          <pre class="code-block"><code>&lt;PPMonthPickerIsland v-model="isOpen" /&gt;</code></pre>
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

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
