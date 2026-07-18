<template>
<div class="guide-section">
        <h2>10. Account Saving Cards & Sheets</h2>

        <div class="variant-group">
          <h3>BizAccountSavingCard</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>accountName</code>, <code>accountNumber</code>, <code>balance</code>, <code>currency</code>, <code>type</code>, <code>selected</code></p>
          <div class="component-demo" style="background: #e5e5ea; padding: 20px; border-radius: 12px; display: flex; flex-direction: column; gap: 12px;">
            <BizAccountSavingCard 
              accountName="CHANT TY'S Savings"
              accountNumber="1-120-14354545-8"
              :balance="12000000.00"
              currency="USD"
              type="Savings"
              :selected="true"
            />
            <BizAccountSavingCard 
              accountName="CHANT TY'S Savings"
              accountNumber="1-120-14354545-8"
              :balance="420000"
              currency="KHR"
              type="Current"
              :selected="false"
            />
          </div>
          <pre class="code-block"><code>&lt;BizAccountSavingCard 
  accountName="CHANT TY'S Savings"
  accountNumber="1-120-14354545-8"
  :balance="12000000.00"
  currency="USD"
  type="Savings"
  :selected="true"
/&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizReceivingAccountSheet</h3>
          <p class="custom-guide"><strong>Props:</strong> <code>modelValue</code>, <code>accounts</code>, <code>selectedAccountId</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; padding: 20px; border-radius: 12px; display: flex; flex-direction: column; gap: 12px;">
            <BizButton @click="showReceivingAccount = true">Select Receiving Account</BizButton>
            <BizReceivingAccountSheet 
              v-model="showReceivingAccount"
              :accounts="demoAccounts"
              :selectedAccountId="selectedReceivingAccount"
              @select="acc => { selectedReceivingAccount = acc.id; alertVal(`Selected ${acc.name}`) }"
            />
          </div>
          <pre class="code-block"><code>&lt;BizReceivingAccountSheet 
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

import { BizButton, BizButtonGroup, BizImageTransition, BizSwipeItem, BizSlider, BizSwitch, BizBarChart, BizLineChart, BizDonutChart, BizPieChart, BizRadarChart, BizProgressGauge, BizScatterChart, BizFunnelChart, BizSkeleton, BizSkeletonItem, BizSkeletonList, BizSkeletonDetail, BizHideAppBar, BizBottomNav, BizFab, BizFabList, BizFabAction, BizNumberSpinner, BizRadio, BizRadioGroup, BizRating, BizCollapsingToolbar, BizPullToRefresh, BizInput, BizTextField, BizSelect, BizTransferList, BizToggleButton, BizCheckbox, BizCheckboxGroup, BizPhoneInput, BizOtpInput, BizInfoCard, BizActionCard, BizAccountCard, BizSegment, BizSegmentButton, BizCompanySelector, BizScrollSegment, BizScrollSegmentButton, BizNotificationItem, BizPinDots, BizKeypad, BizSecureKeypad, BizSecureKeyboard, BizKhmerKeyboard, BizToast, BizConfirmSheet, BizReceiveAmountSheet, BizAccountSavingCard, BizReceivingAccountSheet, BizKhmerCalendar, BizKhmerCalendarSheet, BizKhmerCalendarAlert, BizKhmerCalendarIsland, BizCalendar, BizCalendarSheet, BizCalendarAlert, BizCalendarIsland, BizFileUpload, BizMonthPicker, BizMonthPickerSheet, BizMonthPickerAlert, BizMonthPickerIsland, BizYearPicker, BizYearPickerSheet, BizYearPickerAlert, BizYearPickerIsland, BizTimePicker, BizTimePickerSheet, BizTimePickerAlert, BizTimePickerIsland, BizAutocomplete, BizAccountListCard, BizAccountReorderList, BizColorPicker, BizColorPickerSheet, BizColorPickerAlert, BizColorPickerIsland, BizNavigationDrawer, BizNavigationRail, BizDynamicIsland, BizCollapse, BizCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
