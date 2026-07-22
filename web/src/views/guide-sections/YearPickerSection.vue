<template>
<div class="guide-section">
        <h2>13.5. Year Picker</h2>

        <div class="variant-group">
          <h3>Standard Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Single' }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <PPYearPicker 
              @year-selected="s => alertVal('Selected Year: ' + s.year)"
            />
          </div>
          <pre class="code-block"><code>&lt;PPYearPicker @year-selected="onSelect" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Range Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Range' }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <PPYearPicker 
              :config="{ selectionMode: 'Range' }"
              @range-selected="(start, end) => alertVal('Range: ' + (start ? start.year : '') + ' to ' + (end ? end.year : ''))"
            />
          </div>
          <pre class="code-block"><code>&lt;PPYearPicker :config="{ selectionMode: 'Range' }" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Year Picker Bottom Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPYearPickerSheet&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showYearPickerSheet = true">Open Year Sheet</PPButton>
            <PPYearPickerSheet 
              v-model="showYearPickerSheet"
              title="Select a Year"
              :showActionButtons="true"
              @confirm="(s) => { alertVal('Confirmed: ' + (s ? s.year : '')); showYearPickerSheet = false; }"
              @cancel="showYearPickerSheet = false"
            />
          </div>
          <pre class="code-block"><code>&lt;PPYearPickerSheet v-model="isOpen" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Year Picker Island Popup</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPYearPickerIsland&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showYearPickerIsland = true">Open Year Picker Island</PPButton>
            <PPYearPickerIsland 
              v-model="showYearPickerIsland"
              :showActionButtons="true"
              @confirm="s => { alertVal('Confirmed Year: ' + (s ? s.year : 'none')); showYearPickerIsland = false; }"
              @cancel="showYearPickerIsland = false"
            />
          </div>
          <pre class="code-block"><code>&lt;PPYearPickerIsland v-model="isOpen" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Year Picker Alert</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPYearPickerAlert&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showYearPickerAlert = true">Open Year Alert</PPButton>
            <PPYearPickerAlert 
              v-model="showYearPickerAlert"
              title="Select a Year"
              :showActionButtons="true"
              @confirm="(s) => { alertVal('Confirmed: ' + (s ? s.year : '')); showYearPickerAlert = false; }"
              @cancel="showYearPickerAlert = false"
            />
          </div>
          <pre class="code-block"><code>&lt;PPYearPickerAlert v-model="isOpen" /&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const showYearPickerSheet = ref(false);

const showYearPickerAlert = ref(false);

const showYearPickerIsland = ref(false);

const alertVal = (type: string) => console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
