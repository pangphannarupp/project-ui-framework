<template>
<div class="guide-section">
        <h2>10. Account Saving Cards & Sheets</h2>

        <div class="variant-group">
          <h3>PPAccountSavingCard</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>accountName</code>, <code>accountNumber</code>, <code>balance</code>, <code>currency</code>, <code>type</code>, <code>selected</code></p>
          <div class="component-demo" style="background: #e5e5ea; padding: 20px; border-radius: 12px; display: flex; flex-direction: column; gap: 12px;">
            <PPAccountSavingCard 
              accountName="CHANT TY'S Savings"
              accountNumber="1-120-14354545-8"
              :balance="12000000.00"
              currency="USD"
              type="Savings"
              :selected="true"
            />
            <PPAccountSavingCard 
              accountName="CHANT TY'S Savings"
              accountNumber="1-120-14354545-8"
              :balance="420000"
              currency="KHR"
              type="Current"
              :selected="false"
            />
          </div>
          <pre class="code-block"><code>&lt;PPAccountSavingCard 
  accountName="CHANT TY'S Savings"
  accountNumber="1-120-14354545-8"
  :balance="12000000.00"
  currency="USD"
  type="Savings"
  :selected="true"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>PPReceivingAccountSheet</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>modelValue</code>, <code>accounts</code>, <code>selectedAccountId</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; padding: 20px; border-radius: 12px; display: flex; flex-direction: column; gap: 12px;">
            <PPButton @click="showReceivingAccount = true">Select Receiving Account</PPButton>
            <PPReceivingAccountSheet 
              v-model="showReceivingAccount"
              :accounts="demoAccounts"
              :selectedAccountId="selectedReceivingAccount"
              @select="acc => { selectedReceivingAccount = acc.id; alertVal(`Selected ${acc.name}`) }"
            />
          </div>
          <pre class="code-block"><code>&lt;PPReceivingAccountSheet 
  v-model="showReceivingAccount"
  :accounts="demoAccounts"
  :selectedAccountId="selectedReceivingAccount"
  @select="onSelectAccount"
/&gt;</code></pre>
        </div>

      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const showReceivingAccount = ref(false);

const selectedReceivingAccount = ref('acc1');

const demoAccounts = ref([
  { id: 'acc1', name: "Chan Ty' Saving", number: "1-120-14335454-8", balance: 12000000.00, currency: "USD" as const, type: "Savings", isHidden: false },
  { id: 'acc2', name: "Chan Ty' Saving", number: "1-120-14335455-9", balance: 50000.50, currency: "USD" as const, type: "Savings", isHidden: false },
  { id: 'acc3', name: "Chan Ty' Saving", number: "1-120-14335456-0", balance: 40000000, currency: "KHR" as const, type: "Savings", isHidden: true },
]);

const alertVal = (type: string) => console.log('Setup: ' + type);
// Search functionality



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
