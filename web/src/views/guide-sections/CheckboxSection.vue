<template>
<div class="guide-section">
        <h2>10. Checkboxes</h2>

        <div class="variant-group">
          <h3>Standard Checkbox</h3>
          <div class="component-demo">
            <PPCheckbox v-model="hideDeposit" label="Hide deposit amounts" />
          </div>
          <pre class="code-block"><code>&lt;PPCheckbox 
  v-model="isChecked" 
  label="Hide deposit amounts" 
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Checkbox Group</h3>
          <p class="custom-guide">Group multiple checkboxes bound to an array.</p>
          <div class="component-demo">
            <PPCheckboxGroup v-model="selectedFeatures" vertical>
              <PPCheckbox value="transfer" label="Transfers" />
              <PPCheckbox value="payment" label="Bill Payments" />
              <PPCheckbox value="topup" label="Mobile Topup" />
            </PPCheckboxGroup>
            <p style="margin-top: 10px; font-size: 14px;">Selected: {{ selectedFeatures }}</p>
          </div>
          <pre class="code-block"><code>&lt;PPCheckboxGroup v-model="features" vertical&gt;
  &lt;PPCheckbox value="transfer" label="Transfers" /&gt;
  &lt;PPCheckbox value="payment" label="Payments" /&gt;
&lt;/PPCheckboxGroup&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const hideDeposit = ref(false);

const selectedFeatures = ref(['payment']);



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
