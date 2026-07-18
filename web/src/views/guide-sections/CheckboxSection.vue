<template>
<div class="guide-section">
        <h2>10. Checkboxes</h2>

        <div class="variant-group">
          <h3>Standard Checkbox</h3>
          <div class="component-demo">
            <BizCheckbox v-model="hideDeposit" label="Hide deposit amounts" />
          </div>
          <pre class="code-block"><code>&lt;BizCheckbox 
  v-model="isChecked" 
  label="Hide deposit amounts" 
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Checkbox Group</h3>
          <p class="custom-guide">Group multiple checkboxes bound to an array.</p>
          <div class="component-demo">
            <BizCheckboxGroup v-model="selectedFeatures" vertical>
              <BizCheckbox value="transfer" label="Transfers" />
              <BizCheckbox value="payment" label="Bill Payments" />
              <BizCheckbox value="topup" label="Mobile Topup" />
            </BizCheckboxGroup>
            <p style="margin-top: 10px; font-size: 14px;">Selected: {{ selectedFeatures }}</p>
          </div>
          <pre class="code-block"><code>&lt;BizCheckboxGroup v-model="features" vertical&gt;
  &lt;BizCheckbox value="transfer" label="Transfers" /&gt;
  &lt;BizCheckbox value="payment" label="Payments" /&gt;
&lt;/BizCheckboxGroup&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const hideDeposit = ref(false);

const selectedFeatures = ref(['payment']);



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { BizButton, BizButtonGroup, BizImageTransition, BizSwipeItem, BizSlider, BizSwitch, BizBarChart, BizLineChart, BizDonutChart, BizPieChart, BizRadarChart, BizProgressGauge, BizScatterChart, BizFunnelChart, BizSkeleton, BizSkeletonItem, BizSkeletonList, BizSkeletonDetail, BizHideAppBar, BizBottomNav, BizFab, BizFabList, BizFabAction, BizNumberSpinner, BizRadio, BizRadioGroup, BizRating, BizCollapsingToolbar, BizPullToRefresh, BizInput, BizTextField, BizSelect, BizTransferList, BizToggleButton, BizCheckbox, BizCheckboxGroup, BizPhoneInput, BizOtpInput, BizInfoCard, BizActionCard, BizAccountCard, BizSegment, BizSegmentButton, BizCompanySelector, BizScrollSegment, BizScrollSegmentButton, BizNotificationItem, BizPinDots, BizKeypad, BizSecureKeypad, BizSecureKeyboard, BizKhmerKeyboard, BizToast, BizConfirmSheet, BizReceiveAmountSheet, BizAccountSavingCard, BizReceivingAccountSheet, BizKhmerCalendar, BizKhmerCalendarSheet, BizKhmerCalendarAlert, BizKhmerCalendarIsland, BizCalendar, BizCalendarSheet, BizCalendarAlert, BizCalendarIsland, BizFileUpload, BizMonthPicker, BizMonthPickerSheet, BizMonthPickerAlert, BizMonthPickerIsland, BizYearPicker, BizYearPickerSheet, BizYearPickerAlert, BizYearPickerIsland, BizTimePicker, BizTimePickerSheet, BizTimePickerAlert, BizTimePickerIsland, BizAutocomplete, BizAccountListCard, BizAccountReorderList, BizColorPicker, BizColorPickerSheet, BizColorPickerAlert, BizColorPickerIsland, BizNavigationDrawer, BizNavigationRail, BizDynamicIsland, BizCollapse, BizCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
