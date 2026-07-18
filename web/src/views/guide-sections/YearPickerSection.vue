<template>
<div class="guide-section">
        <h2>13.5. Year Picker</h2>

        <div class="variant-group">
          <h3>Standard Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Single' }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <BizYearPicker 
              @year-selected="s => alertVal('Selected Year: ' + s.year)"
            />
          </div>
          <pre class="code-block"><code>&lt;BizYearPicker @year-selected="onSelect" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Range Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Range' }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <BizYearPicker 
              :config="{ selectionMode: 'Range' }"
              @range-selected="(start, end) => alertVal('Range: ' + (start ? start.year : '') + ' to ' + (end ? end.year : ''))"
            />
          </div>
          <pre class="code-block"><code>&lt;BizYearPicker :config="{ selectionMode: 'Range' }" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Year Picker Bottom Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizYearPickerSheet&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <BizButton @click="showYearPickerSheet = true">Open Year Sheet</BizButton>
            <BizYearPickerSheet 
              v-model="showYearPickerSheet"
              title="Select a Year"
              :showActionButtons="true"
              @confirm="(s) => { alertVal('Confirmed: ' + (s ? s.year : '')); showYearPickerSheet = false; }"
              @cancel="showYearPickerSheet = false"
            />
          </div>
          <pre class="code-block"><code>&lt;BizYearPickerSheet v-model="isOpen" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Year Picker Island Popup</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizYearPickerIsland&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <BizButton @click="showYearPickerIsland = true">Open Year Picker Island</BizButton>
            <BizYearPickerIsland 
              v-model="showYearPickerIsland"
              :showActionButtons="true"
              @confirm="s => { alertVal('Confirmed Year: ' + (s ? s.year : 'none')); showYearPickerIsland = false; }"
              @cancel="showYearPickerIsland = false"
            />
          </div>
          <pre class="code-block"><code>&lt;BizYearPickerIsland v-model="isOpen" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Year Picker Alert</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizYearPickerAlert&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <BizButton @click="showYearPickerAlert = true">Open Year Alert</BizButton>
            <BizYearPickerAlert 
              v-model="showYearPickerAlert"
              title="Select a Year"
              :showActionButtons="true"
              @confirm="(s) => { alertVal('Confirmed: ' + (s ? s.year : '')); showYearPickerAlert = false; }"
              @cancel="showYearPickerAlert = false"
            />
          </div>
          <pre class="code-block"><code>&lt;BizYearPickerAlert v-model="isOpen" /&gt;</code></pre>
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

import { BizButton, BizButtonGroup, BizImageTransition, BizSwipeItem, BizSlider, BizSwitch, BizBarChart, BizLineChart, BizDonutChart, BizPieChart, BizRadarChart, BizProgressGauge, BizScatterChart, BizFunnelChart, BizSkeleton, BizSkeletonItem, BizSkeletonList, BizSkeletonDetail, BizHideAppBar, BizBottomNav, BizFab, BizFabList, BizFabAction, BizNumberSpinner, BizRadio, BizRadioGroup, BizRating, BizCollapsingToolbar, BizPullToRefresh, BizInput, BizTextField, BizSelect, BizTransferList, BizToggleButton, BizCheckbox, BizCheckboxGroup, BizPhoneInput, BizOtpInput, BizInfoCard, BizActionCard, BizAccountCard, BizSegment, BizSegmentButton, BizCompanySelector, BizScrollSegment, BizScrollSegmentButton, BizNotificationItem, BizPinDots, BizKeypad, BizSecureKeypad, BizSecureKeyboard, BizKhmerKeyboard, BizToast, BizConfirmSheet, BizReceiveAmountSheet, BizAccountSavingCard, BizReceivingAccountSheet, BizKhmerCalendar, BizKhmerCalendarSheet, BizKhmerCalendarAlert, BizKhmerCalendarIsland, BizCalendar, BizCalendarSheet, BizCalendarAlert, BizCalendarIsland, BizFileUpload, BizMonthPicker, BizMonthPickerSheet, BizMonthPickerAlert, BizMonthPickerIsland, BizYearPicker, BizYearPickerSheet, BizYearPickerAlert, BizYearPickerIsland, BizTimePicker, BizTimePickerSheet, BizTimePickerAlert, BizTimePickerIsland, BizAutocomplete, BizAccountListCard, BizAccountReorderList, BizColorPicker, BizColorPickerSheet, BizColorPickerAlert, BizColorPickerIsland, BizNavigationDrawer, BizNavigationRail, BizDynamicIsland, BizCollapse, BizCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
