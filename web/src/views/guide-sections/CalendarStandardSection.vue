<template>
<div class="guide-section">
        <h2>12. Standard Calendar</h2>

        <div class="variant-group">
          <h3>Standard Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Single' }</code> (default)</p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <PPCalendar 
              @date-selected="s => alertVal('Selected Date: ' + s.date.toLocaleDateString())"
            />
          </div>
          <pre class="code-block"><code>&lt;PPCalendar @date-selected="onSelect" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Range Selection & Limits</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Range', minDate: ..., maxDate: ... }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <PPCalendar 
              :config="{ 
                selectionMode: 'Range', 
                minDate: new Date(new Date().getFullYear(), new Date().getMonth(), 1), 
                maxDate: new Date(new Date().getFullYear(), new Date().getMonth() + 1, 0) 
              }"
              @range-selected="(start, end) => alertVal('Range: ' + (start ? start.date.toLocaleDateString() : '') + ' to ' + (end ? end.date.toLocaleDateString() : ''))"
            />
          </div>
          <pre class="code-block"><code>&lt;PPCalendar :config="{ selectionMode: 'Range', minDate, maxDate }" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Week Selection</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>config={ selectionMode: 'Week' }</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <PPCalendar 
              :config="{ selectionMode: 'Week' }"
              @range-selected="(start, end) => alertVal('Week: ' + (start ? start.date.toLocaleDateString() : '') + ' to ' + (end ? end.date.toLocaleDateString() : ''))"
            />
          </div>
          <pre class="code-block"><code>&lt;PPCalendar :config="{ selectionMode: 'Week' }" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Hide Header Controls</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>hideHeaderPicker</code>, <code>hideNavButtons</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; overflow: hidden;">
            <PPCalendar 
              :hide-header-picker="true"
              :hide-nav-buttons="true"
              @date-selected="s => alertVal('Selected Date: ' + s.date.toLocaleDateString())"
            />
          </div>
          <pre class="code-block"><code>&lt;PPCalendar :hide-header-picker="true" :hide-nav-buttons="true" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Calendar Bottom Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPCalendarSheet&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showStdCalendarSheet = true">Open Calendar Sheet</PPButton>
            <PPCalendarSheet 
              v-model="showStdCalendarSheet"
              title="Select a Date"
              :showActionButtons="true"
              @confirm="(d) => { alertVal('Confirmed: ' + (d ? d.date.toLocaleDateString() : '')); showStdCalendarSheet = false; }"
              @cancel="showStdCalendarSheet = false"
            />
          </div>
          <pre class="code-block"><code>&lt;PPCalendarSheet v-model="isOpen" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Calendar Island Popup</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPCalendarIsland&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showStdCalendarIsland = true">Open Calendar Island</PPButton>
            <PPCalendarIsland 
              v-model="showStdCalendarIsland"
              title="Select a Date"
              :showActionButtons="true"
              @confirm="(d) => { alertVal('Confirmed: ' + (d ? d.date.toLocaleDateString() : '')); showStdCalendarIsland = false; }"
              @cancel="showStdCalendarIsland = false"
            />
          </div>
          <pre class="code-block"><code>&lt;PPCalendarIsland v-model="isOpen" /&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const showStdCalendarSheet = ref(false);

const showStdCalendarIsland = ref(false);

const alertVal = (type: string) => console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
